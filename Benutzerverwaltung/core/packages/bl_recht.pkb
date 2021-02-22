create or replace package body bl_recht
as
  /* Package-Konstanten */
  c_anw_id constant bv_anwendung.anw_id%type := 'BV';
  c_super_admin constant bv_rolle.rol_id%type := 'SUPER_ADMIN';
  c_mv_name constant varchar2(30) := 'BV_BENUTZER_RECHTE';
  
  
  /* HILFSMETHODEN */
  /** Methode ermittelt zu einer Anwendung die hinterlegte Anwendungsart
   * %param  p_anw_id  ID der Anwendung
   * %return Anwendungsart der ID
   * %throws NO_DATA_FOUND, falls die Anwendung nicht existiert
   */
  function get_aar_id(
    p_anw_id in bv_anwendung.anw_id%type)
    return bv_anwendung_art.aar_id%type
  as
    l_aar_id bv_anwendung_art.aar_id%type;
  begin
    select anw_aar_id
      into l_aar_id
      from bv_anwendung
     where anw_id = p_anw_id;
    return l_aar_id;
  end get_aar_id;

  
  /** Methode ueberfuehrt einen Record vom Typ BV_ROLLE%ROWTYPE in einen Record des Typs BV_RECHT%ROWTYPE
   * %param  p_row  Record aus BV_ROLLE
   * %return Instanz von BV_RECHT
   * %usage  Wird in einfachen Rollenhierarchien verwendet, wo ein Recht einer Rolle
   *         gleichzusetzen ist.
   */
  function cast_to_recht(
    p_row in bv_rolle%rowtype)
    return bv_recht%rowtype
  as
    l_rec_row bv_recht%rowtype;
  begin
    l_rec_row.rec_id := p_row.rol_id;
    l_rec_row.rec_anw_id := p_row.rol_anw_id;
    l_rec_row.rec_name := p_row.rol_name;
    l_rec_row.rec_beschreibung := p_row.rol_beschreibung;
    l_rec_row.rec_aktiv := p_row.rol_aktiv;
    l_rec_row.rec_sortierung := p_row.rol_sortierung;
    return l_rec_row;
  end cast_to_recht;
    

  /* INTERFACE */
  procedure create_super_admin(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_ben_stz in bv_benutzer.ben_stz%type,
    p_ben_anr_id in bv_benutzer.ben_anr_id%type,
    p_ben_nachname in bv_benutzer.ben_nachname%type,
    p_ben_email in bv_benutzer.ben_email%type,
    p_ben_telefon in bv_benutzer.ben_telefon%type)
  as
    l_ben_id bv_benutzer.ben_id%type;
    l_bro_row bv_benutzer_rolle%rowtype;
  begin
    bl_ben.merge_benutzer(
      p_ben_id => l_ben_id,
      p_ben_ad => p_ben_ad,
      p_ben_stz => p_ben_stz,
      p_ben_anr_id => p_ben_anr_id,
      p_ben_nachname => p_ben_nachname,
      p_ben_email => p_ben_email,
      p_ben_telefon => p_ben_telefon);
      
    l_bro_row.bro_ben_id := l_ben_id;
    l_bro_row.bro_rol_id := C_SUPER_ADMIN;
    l_bro_row.bro_anw_id := C_ANW_ID;
    rolle_zuweisen(l_bro_row);

    commit;
    dbms_mview.refresh(c_mv_name);
  end create_super_admin;


  procedure refresh_mv
  as
    c_action constant varchar2(200) := 'begin dbms_mview.refresh(''' || c_mv_name || '''); end;';
  begin
    bv_utils.submit_job(
      p_action => c_action);
  end refresh_mv;


  function benutzer_hat_recht(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_rec_id in bv_recht.rec_id%type,
    p_anw_id in bv_anwendung.anw_id%type)
    return bv_utils.flag_type
  as
    l_flag pls_integer;
  begin
    select count(*)
      into l_flag
      from bv_benutzer ben
      join bv_benutzer_rechte bre on ben.ben_id = bre.ben_id
      join bv_anwendung anw on bre.anw_id = anw.anw_id
     where ben.ben_ad = p_ben_ad
       and (bre.rec_id like p_rec_id || '%' or bre.rec_id = 'SUPER_ADMIN')
       and anw.anw_apex_alias = p_anw_id;
      
    return case l_flag when 0 then bv_utils.C_FALSE else bv_utils.C_TRUE end;
  exception
    when no_data_found then
      return null;
  end benutzer_hat_recht;


  function benutzer_ist(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_rol_id in bv_rolle.rol_id%type,
    p_anw_id in bv_anwendung.anw_id%type)
    return number
  as
    l_flag number(1, 0);
  begin
    select count(*)
      into l_flag
      from bv_benutzer ben
      join bv_benutzer_rolle bro on ben.ben_id = bro_ben_id
      join bv_anwendung anw on bro.bro_anw_id = anw.anw_id
     where ben.ben_ad = p_ben_ad
       and bro_rol_id = p_rol_id
       and anw.anw_apex_alias = p_anw_id;
    return l_flag;
  exception
    when no_data_found then
      return null;
  end benutzer_ist;


  function get_admin_anw(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_anw_id in bv_anwendung.anw_id%type)
    return char_table
    pipelined
  as
    c_app_prefix constant varchar2(10) := 'APP_';
    cursor benutzer_rechte(
      p_ben_ad in bv_benutzer.ben_ad%type,
      p_anw_id in bv_anwendung.anw_id%type) 
    is
      select replace(rec_id, C_APP_PREFIX) rec_id
        from bv_bv_benutzer_rechte
       where (ben_id = (select ben_id
                          from bv_benutzer
                         where upper(ben_ad) = p_ben_ad)
          or benutzer_hat_recht(p_ben_ad, p_anw_id, C_SUPER_ADMIN) = bv_utils.C_TRUE);
  begin
    for rec in benutzer_rechte(upper(p_ben_ad), p_anw_id) loop
      pipe row (rec.rec_id);
    end loop;
    return;
  end get_admin_anw;


  procedure recht_zuweisen(
    p_row in bv_benutzer_recht%rowtype)
  as
  begin
    insert into bv_benutzer_recht
    values p_row;
    refresh_mv;
  end recht_zuweisen;


  procedure recht_entziehen(
    p_ben_id in bv_benutzer.ben_id%type,
    p_rec_id in bv_rolle.rol_id%type,
    p_anw_id in bv_anwendung.anw_id%type)
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
    p_row in bv_benutzer_rolle%rowtype)
  as
    l_row bv_benutzer_rolle%rowtype;
  begin
    -- Initialisierung
    l_row := p_row;
    l_row.bro_gueltig_ab := coalesce(p_row.bro_gueltig_ab, sysdate);
    l_row.bro_gueltig_bis := coalesce(p_row.bro_gueltig_ab, bv_utils.C_MAX_DATE);
    
    insert into bv_benutzer_rolle
    values l_row;
    refresh_mv;
  end rolle_zuweisen;


  procedure rolle_aktualisieren(
    p_row in bv_benutzer_rolle%rowtype)
  as
  begin
    update bv_benutzer_rolle
       set bro_gueltig_ab = p_row.bro_gueltig_ab,
           bro_gueltig_bis = p_row.bro_gueltig_bis
     where bro_ben_id = p_row.bro_ben_id
       and bro_rol_id = p_row.bro_rol_id
       and bro_anw_id = p_row.bro_anw_id;
    refresh_mv;
  end rolle_aktualisieren;


  procedure rolle_entziehen(
    p_ben_id in bv_benutzer.ben_id%type,
    p_rol_id in bv_rolle.rol_id%type,
    p_anw_id in bv_anwendung.anw_id%type)
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
    p_row in bv_benutzer_rolle%rowtype)
  as
  begin
    update bv_benutzer_rolle
       set bro_gueltig_bis = sysdate
     where bro_ben_id = p_row.bro_ben_id
       and bro_rol_id = p_row.bro_rol_id
       and bro_gueltig_bis > sysdate - interval '1' second;
    refresh_mv;
  end rolle_entziehen;
  
  
  procedure validiere_rolle(
    p_row in out nocopy bv_rolle%rowtype)
  as
  begin
    p_row.rol_id := dbms_assert.simple_sql_name(p_row.rol_id);
  end validiere_rolle;


  procedure merge_rolle(
    p_row in out nocopy bv_rolle%rowtype)
  as
  begin
    -- Initialisierung
    p_row.rol_id := upper(p_row.rol_id);
        
    merge into bv_rolle r
    using (select p_row.rol_id rol_id,
                  p_row.rol_anw_id rol_anw_id,
                  p_row.rol_name rol_name,
                  p_row.rol_beschreibung rol_beschreibung,
                  p_row.rol_aktiv rol_aktiv,
                  p_row.rol_sortierung rol_sortierung
             from dual) v
       on (r.rol_id = v.rol_id
       and r.rol_anw_id = v.rol_anw_id)
     when matched then update set
          rol_name = v.rol_name,
          rol_beschreibung = v.rol_beschreibung,
          rol_aktiv = v.rol_aktiv,
          rol_sortierung = v.rol_sortierung
     when not matched then insert (rol_id, rol_anw_id, rol_name, rol_beschreibung, rol_aktiv, rol_sortierung)
          values(v.rol_id, v.rol_anw_id, v.rol_name, v.rol_beschreibung, v.rol_aktiv, v.rol_sortierung);

    if get_aar_id(p_row.rol_anw_id) in (bv_utils.C_AAR_HIER_EINFACH, bv_utils.C_AAR_HIER_KOMPLEX) then
      p_row := cast_to_recht(p_row);
      merge_recht(p_row);
      merge_rolle_recht(
        p_rre_rol_id => p_row.rol_id,
        p_rre_rec_id => p_row.rol_id,
        p_rre_anw_id => p_row.rol_anw_id);
    else
      /* TODO: Recht/Rollenkonzept implementieren */
      null;
    end if;
  end merge_rolle;
  
  
  procedure merge_rolle(
    p_rol_id in bv_rolle.rol_id%type,
    p_rol_anw_id in bv_rolle.rol_anw_id%type,
    p_rol_name in bv_rolle.rol_name%type,
    p_rol_beschreibung in bv_rolle.rol_beschreibung%type,
    p_rol_aktiv in bv_rolle.rol_aktiv%type,
    p_rol_sortierung in bv_rolle.rol_sortierung%type default null)
  as
    l_row bv_rolle%rowtype;
  begin
    l_row.rol_id := p_rol_id;
    l_row.rol_anw_id := p_rol_anw_id;
    l_row.rol_name := p_rol_name;
    l_row.rol_beschreibung := p_rol_beschreibung;
    l_row.rol_aktiv := p_rol_aktiv;
    l_row.rol_sortierung := p_rol_sortierung;
    
    merge_rolle(l_row);
  end merge_rolle;
  

  procedure loesche_rolle(
    p_row in bv_rolle%rowtype)
  as
  begin
    delete from bv_rolle_rolle
     where rro_anw_id = p_row.rol_anw_id
       and (rro_rol_id = p_row.rol_id
        or  rro_parent_rol_id = p_row.rol_id);

    delete from bv_rolle_recht
     where rre_rol_id = p_row.rol_id
       and rre_anw_id = p_row.rol_anw_id;

    if get_aar_id(p_row.rol_anw_id) in (bv_utils.C_AAR_HIER_EINFACH, bv_utils.C_AAR_HIER_KOMPLEX) then
      delete from bv_recht
       where rec_id = p_row.rol_id
         and rec_anw_id = p_row.rol_anw_id;
    end if;

    delete from bv_rolle
     where rol_id = p_row.rol_id
       and rol_anw_id = p_row.rol_anw_id;

    refresh_mv;
  end loesche_rolle;
  
  
  procedure merge_rolle_rolle(
    p_rro_rol_id in bv_rolle_rolle.rro_rol_id%type,
    p_rro_parent_rol_id in bv_rolle_rolle.rro_parent_rol_id%type,
    p_rro_anw_id in bv_rolle_rolle.rro_anw_id%type)
  as
    l_row bv_rolle_rolle%rowtype;
  begin
    l_row.rro_rol_id := p_rro_rol_id;
    l_row.rro_parent_rol_id := p_rro_parent_rol_id;
    l_row.rro_anw_id := p_rro_anw_id;
  
    merge_rolle_rolle(l_row);
  end merge_rolle_rolle;
  
  
  procedure validiere_recht(
    p_row in out nocopy bv_recht%rowtype)
  as
  begin
    p_row.rec_id := dbms_assert.simple_sql_name(p_row.rec_id);
    p_row.rec_aktiv := coalesce(upper(p_row.rec_aktiv), 'N');
  end validiere_recht;
  

  procedure merge_recht(
    p_row in out nocopy bv_recht%rowtype)
  as
  begin
    -- Initialisierung
    p_row.rec_id := upper(p_row.rec_id);
    p_row.rec_aktiv := coalesce(upper(p_row.rec_aktiv), 'N');
  
    validiere_recht(p_row);
    
    merge into bv_recht r
    using (select p_row.rec_id rec_id,
                  p_row.rec_anw_id rec_anw_id,
                  p_row.rec_name rec_name,
                  p_row.rec_beschreibung rec_beschreibung,
                  p_row.rec_aktiv rec_aktiv,
                  p_row.rec_sortierung rec_sortierung
             from dual) v
       on (r.rec_id = v.rec_id
       and r.rec_anw_id = v.rec_anw_id)
     when matched then update set
          rec_name = v.rec_name,
          rec_beschreibung = v.rec_beschreibung,
          rec_aktiv = v.rec_aktiv,
          rec_sortierung = v.rec_sortierung
     when not matched then insert (rec_id, rec_anw_id, rec_name, rec_beschreibung, rec_aktiv, rec_sortierung)
          values(v.rec_id, v.rec_anw_id, v.rec_name, v.rec_beschreibung, v.rec_aktiv, v.rec_sortierung);
  end merge_recht;


  procedure merge_recht(
    p_rec_id in bv_recht.rec_id%type,
    p_rec_anw_id in bv_recht.rec_anw_id%type,
    p_rec_name in bv_recht.rec_name%type,
    p_rec_beschreibung in bv_recht.rec_beschreibung%type,
    p_rec_aktiv in bv_recht.rec_aktiv%type,
    p_rec_sortierung in bv_recht.rec_sortierung%type default null)
  as
    l_row bv_recht%rowtype;
  begin
    l_row.rec_id := p_rec_id;
    l_row.rec_anw_id := p_rec_anw_id;
    l_row.rec_name := p_rec_name;
    l_row.rec_beschreibung := p_rec_beschreibung;
    l_row.rec_aktiv := p_rec_aktiv;
    l_row.rec_sortierung := p_rec_sortierung;
    
    merge_recht(l_row);
  end merge_recht;
  
  
  procedure loesche_recht(
    p_row in bv_recht%rowtype)
  as
  begin
    delete from bv_recht
     where rec_id = p_row.rec_id;
  end loesche_recht;


  procedure merge_rolle_recht(
    p_row in out nocopy bv_rolle_recht%rowtype)
  as
  begin
    -- Initialisierung
    p_row.rre_gueltig_ab := coalesce(p_row.rre_gueltig_ab, sysdate);
    p_row.rre_gueltig_bis := coalesce(p_row.rre_gueltig_bis, bv_utils.C_MAX_DATE);
    
    merge into bv_rolle_recht r
    using (select p_row.rre_rol_id rre_rol_id,
                  p_row.rre_rec_id rre_rec_id,
                  p_row.rre_anw_id rre_anw_id,
                  coalesce(p_row.rre_gueltig_ab, trunc(sysdate)) rre_gueltig_ab,
                  coalesce(p_row.rre_gueltig_bis, date '2030-12-31') rre_gueltig_bis
             from dual) v
       on (r.rre_rol_id = v.rre_rol_id
       and r.rre_rec_id = v.rre_rec_id
       and r.rre_anw_id = v.rre_anw_id)
     when matched then update set
          rre_gueltig_ab = v.rre_gueltig_ab,
          rre_gueltig_bis = v.rre_gueltig_bis
     when not matched then insert(rre_rol_id, rre_rec_id, rre_anw_id, rre_gueltig_ab, rre_gueltig_bis)
          values (v.rre_rol_id, v.rre_rec_id, v.rre_anw_id, v.rre_gueltig_ab, v.rre_gueltig_bis);
  end merge_rolle_recht;
  
  
  procedure merge_rolle_recht(
    p_rre_rol_id in bv_rolle_recht.rre_rol_id%type,
    p_rre_rec_id in bv_rolle_recht.rre_rec_id%type,
    p_rre_anw_id in bv_rolle_recht.rre_anw_id%type,
    p_rre_gueltig_ab in bv_rolle_recht.rre_gueltig_ab%type default null,
    p_rre_gueltig_bis in bv_rolle_recht.rre_gueltig_bis%type default null)
  as
    l_row bv_rolle_recht%rowtype;
  begin
    l_row.rre_rol_id := p_rre_rol_id;
    l_row.rre_rec_id := p_rre_rec_id;
    l_row.rre_anw_id := p_rre_anw_id;
    l_row.rre_gueltig_ab := p_rre_gueltig_ab;
    l_row.rre_gueltig_bis := p_rre_gueltig_bis;

    merge_rolle_recht(l_row);
  end merge_rolle_recht;
  

  procedure loesche_rolle_recht(
    p_row in bv_rolle_recht%rowtype)
  as
  begin
    delete from bv_rolle_recht
     where rre_rol_id = p_row.rre_rol_id
       and rre_rec_id = p_row.rre_rec_id
       and rre_anw_id = p_row.rre_anw_id;
  end loesche_rolle_recht;


  procedure merge_rolle_rolle(
    p_row in bv_rolle_rolle%rowtype)
  as
  begin
    null;
  end merge_rolle_rolle;


  procedure loesche_rolle_rolle(
    p_row in bv_rolle_rolle%rowtype)
  as
  begin
    null;
  end loesche_rolle_rolle;
  
  
  procedure loesche_anwendung_rollen(
    p_anw_id in bv_anwendung.anw_id%type)
  as
    l_rol_id bv_rolle.rol_id%type;
  begin
    l_rol_id := 'APP_' || p_anw_id;

    delete from bv_rolle_rolle
     where rro_anw_id = p_anw_id
        or rro_rol_id = l_rol_id
        or rro_parent_rol_id = l_rol_id;

    delete from bv_rolle_recht
     where rre_anw_id = p_anw_id
        or rre_rol_id = l_rol_id;

    delete from bv_benutzer_rolle
     where bro_anw_id = p_anw_id
        or bro_rol_id = l_rol_id;

    delete from bv_benutzer_recht
     where bre_anw_id = p_anw_id
        or bre_rec_id = l_rol_id;

    delete from bv_rolle
     where rol_anw_id = p_anw_id
        or rol_id = l_rol_id;

    delete from bv_recht
     where rec_anw_id = p_anw_id
        or rec_id = l_rol_id;

    delete from bv_anwendung_referenz
     where arf_anw_id = p_anw_id;

    delete from bv_anwendung
     where anw_id = p_anw_id;
  end loesche_anwendung_rollen;


  procedure einfache_rollen_hierarchie(
    p_anw_id in bv_anwendung.anw_id%type,
    p_rol_hierarchie in varchar2)
  as
    l_rol_parent bv_rolle.rol_id%type;
    l_rollen char_table;
  begin
    -- Alte Zuordnung loeschen
    delete from bv_rolle_rolle
     where rro_anw_id = p_anw_id;

    -- Neue Eintraege gemaess Sortierung des Controls erstellen
    utl_text.string_to_table(p_rol_hierarchie, l_rollen);

    -- Erste Rolle ist Master und wird ROL_ID = PARENT_ROL_ID
    l_rol_parent := l_rollen(l_rollen.first);
    for rol in l_rollen.first .. l_rollen.last loop
      -- Neue Rollenzuordnung eintragen. Nicht gewaehlte Rollen werden
      -- nicht beruecksichtigt, aber auch nicht deaktiv gesetzt.
      insert into bv_rolle_rolle(rro_rol_id, rro_parent_rol_id, rro_anw_id)
      values (l_rollen(rol), l_rol_parent, p_anw_id);
      -- Aktuelle Rolle als Parent merken
      l_rol_parent := l_rollen(rol);

      -- Sortierung der Rollen neu setzen
      update bv_rolle
         set rol_sortierung = rol * 10
       where rol_id = l_rollen(rol)
         and rol_anw_id = p_anw_id;
    end loop;
  end einfache_rollen_hierarchie;


  procedure komplexe_rollen_hierarchie(
    p_anw_id in bv_anwendung.anw_id%type,
    p_rro_parent_rol_id in bv_rolle.rol_id%type,
    p_rro_child_rol_id in varchar2)
  as
    l_rol_child bv_rolle.rol_id%type;
    l_rollen char_table;
  begin
    delete from bv_rolle_rolle
     where rro_anw_id = p_anw_id
       and rro_parent_rol_id = p_rro_parent_rol_id;

    -- Neue Eintraege gemaess Sortierung des Controls erstellen
    if p_rro_child_rol_id is not null then
      utl_text.string_to_table(p_rro_child_rol_id, l_rollen);
      for rol in l_rollen.first .. l_rollen.last loop
        -- Neue Rollenzuordnung eintragen. Nicht gewaehlte Rollen werden
        -- nicht beruecksichtigt, aber auch nicht deaktiv gesetzt.
        insert into bv_rolle_rolle(rro_rol_id, rro_parent_rol_id, rro_anw_id)
        values (l_rollen(rol), p_rro_parent_rol_id, p_anw_id);
        -- Aktuelle Rolle als Parent merken
        l_rol_child := l_rollen(rol);
      end loop;
    end if;
  end komplexe_rollen_hierarchie;

end bl_recht;
/
