--------------------------------------------------------
--  DDL for Package Body BL_RECHT_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "BL_RECHT_PKG" 
as
  c_anw_id constant bv_anwendung.anw_id%type := 'BV';
  c_super_admin constant bv_rolle.rol_id%type := 'SUPER_ADMIN';
  c_mv_name constant varchar2(30) := 'BV_BENUTZER_RECHTE';

  procedure create_super_admin(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_ben_stz in bv_benutzer.ben_stz%type,
    p_anr_id in bv_anrede.anr_id%type,
    p_ben_nachname in bv_benutzer.ben_nachname%type,
    p_ben_email in bv_benutzer.ben_email%type,
    p_ben_telefon in bv_benutzer.ben_telefon%type)
  as
    l_ben_id bv_benutzer.ben_id%type;
  begin
    insert into bv_benutzer(ben_ad, ben_stz, ben_anr_id, ben_nachname, ben_email, ben_telefon)
    values (p_ben_ad, p_ben_stz, p_anr_id, p_ben_nachname, p_ben_email, p_ben_telefon)
    returning ben_id into l_ben_id;

    insert into bv_benutzer_rolle(bro_ben_id, bro_rol_id, bro_anw_id)
    values (l_ben_id, c_super_admin, c_anw_id);

    commit;
    dbms_mview.refresh(c_mv_name);

  end create_super_admin;


  procedure refresh_mv
  as
    c_action constant varchar2(200) := 'begin dbms_mview.refresh(''' || c_mv_name || '''); end;';
  begin
    utils.submit_job(
      p_action => c_action);
  end refresh_mv;


  function aktueller_benutzer_hat_recht(
    p_rec_id in bv_recht.rec_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return varchar2
  as
  begin
    return bl_recht_pkg.benutzer_hat_recht(v('APP_USER'), p_rec_id, p_anw_id);
  end aktueller_benutzer_hat_recht;


  function benutzer_hat_recht(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_rec_id in bv_recht.rec_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return varchar2
  as
    l_flag number(1, 0);
  begin
    with params as(
           select anw_id
             from bv_anwendung
            where anw_apex_alias = nvl(p_anw_id, v('APP_ALIAS')))
    select count(*)
      into l_flag
      from bv_benutzer_rechte bre
     cross join params p
     where bre.anw_id = p.anw_id
       and rec_id like p_rec_id
       and ben_id = (select ben_id
                       from bv_benutzer
                      where ben_ad = p_ben_ad);
    return case l_flag when 1 then 'Y' else 'N' end;
  exception
    when no_data_found then
      return null;
  end benutzer_hat_recht;


  function aktueller_benutzer_ist(
    p_rol_id in bv_rolle.rol_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return varchar2
  as
  begin
    return bl_recht_pkg.benutzer_ist(v('APP_USER'), p_rol_id, p_anw_id);
  end aktueller_benutzer_ist;


  function benutzer_ist(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_rol_id in bv_rolle.rol_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return varchar2
  as
    l_flag number(1, 0);
  begin
    with params as(
           select anw_id
             from bv_anwendung
            where anw_apex_alias = nvl(p_anw_id, v('APP_ALIAS')))
    select count(*)
      into l_flag
      from bv_benutzer_rolle bro
     cross join params p
     where bro.bro_anw_id = p.anw_id
       and bro_rol_id = p_rol_id
       and bro_ben_id = (select ben_id
                           from bv_benutzer
                          where ben_ad = p_ben_ad);
    return case l_flag when 1 then 'Y' else 'N' end;
  exception
    when no_data_found then
      return null;
  end benutzer_ist;


  function get_admin_anw
    return char_table
    pipelined
  as
    cursor benutzer_rechte is
      select replace(rec_id, 'APP_', '') rec_id
        from bv_bv_benutzer_rechte
       where (ben_id = (select ben_id
                          from bv_benutzer
                         where upper(ben_ad) = upper(v('APP_USER')))
          or bl_recht_pkg.aktueller_benutzer_hat_recht(c_super_admin) = 'Y')
         and rec_id like 'APP%';
  begin
    for rec in benutzer_rechte loop
      pipe row (rec.rec_id);
    end loop;
    return;
  end get_admin_anw;


  procedure recht_zuweisen(
    p_row bv_benutzer_recht%rowtype)
  as
  begin
    insert into bv_benutzer_recht
    values p_row;
    refresh_mv;
  end recht_zuweisen;


  procedure recht_entziehen(
    p_ben_id bv_benutzer.ben_id%type,
    p_rec_id bv_rolle.rol_id%type,
    p_anw_id bv_anwendung.anw_id%type)
  as
  begin
    update bv_benutzer_recht
       set bre_gueltig_bis = sysdate
     where bre_ben_id = p_ben_id
       and bre_rec_id = p_rec_id
       and bre_gueltig_bis > sysdate - interval '1' second;
    refresh_mv;
  end recht_entziehen;
  

  procedure rolle_zuweisen(
    p_row bv_benutzer_rolle%rowtype)
  as
  begin
    insert into bv_benutzer_rolle
    values p_row;
    refresh_mv;
  end rolle_zuweisen;


  procedure rolle_aktualisieren(
    p_row bv_benutzer_rolle%rowtype)
  as
  begin
    update bv_benutzer_rolle
         set bro_gueltig_von = p_row.bro_gueltig_von,
             bro_gueltig_bis = p_row.bro_gueltig_bis
       where bro_ben_id = p_row.bro_ben_id
         and bro_rol_id = p_row.bro_rol_id
         and bro_anw_id = p_row.bro_anw_id;
    refresh_mv;
  end rolle_aktualisieren;


  procedure rolle_entziehen(
    p_ben_id bv_benutzer.ben_id%type,
    p_rol_id bv_rolle.rol_id%type,
    p_anw_id bv_anwendung.anw_id%type)
  as
  begin
    update bv_benutzer_rolle
       set bro_gueltig_bis = sysdate
     where bro_ben_id = p_ben_id
       and bro_rol_id = p_rol_id
       and bro_anw_id = p_anw_id
       and bro_gueltig_bis > sysdate - interval '1' second;
    refresh_mv;
  end rolle_entziehen;
    
  procedure rolle_entziehen(
    p_row bv_benutzer_rolle%rowtype)
  as
  begin
    update bv_benutzer_rolle
       set bro_gueltig_bis = sysdate
     where bro_ben_id = p_row.bro_ben_id
       and bro_rol_id = p_row.bro_rol_id
       and bro_gueltig_bis > sysdate - interval '1' second;
    refresh_mv;
  end rolle_entziehen;

end bl_recht_pkg;

/
