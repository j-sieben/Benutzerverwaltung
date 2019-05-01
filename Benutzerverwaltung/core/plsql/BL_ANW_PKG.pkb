--------------------------------------------------------
--  DDL for Package Body BL_ANW_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "BL_ANW_PKG" as

  /* Package-Konstanten */
  c_anw_id constant varchar2(2) := 'BV';
  c_aar_hier_einfach constant bv_anwendung_art.aar_id%type := 'HIERARCHIE_EINFACH';
  c_aar_hier_komplex constant bv_anwendung_art.aar_id%type := 'HIERARCHIE_KOMPLEX';
  
  
  /* Hilfsfunktionen */
  
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
  procedure create_anwendung(
    p_row in bv_anwendung%rowtype)
  as
    c_action_tmpl constant varchar2(200) := q'[begin bl_anw_pkg.create_anw_views('#ANW_ID#'); end;]';
    l_anw_id bv_anwendung.anw_id%type;
    l_rol_id bv_rolle.rol_id%type;
  begin
    l_anw_id := upper(p_row.anw_id);
    l_rol_id := 'APP_' || l_anw_id;
    insert into bv_anwendung
    values p_row;

    -- Recht, die neue Anwendung zu administrieren, zu BV-Rechten hinzufuegen
    insert into bv_recht(rec_id, rec_anw_id, rec_name, rec_beschreibung, rec_aktiv)
    values (l_rol_id, c_anw_id, 'Anwendung ' || l_anw_id || ' administrieren',
            'Recht, die Anwendung ' || l_anw_id || ' zu administrieren', 'Y');

    -- Referenz auf sich selbst und auf BV in Anwendungsreferenz einfuegen
    insert into bv_anwendung_referenz(arf_anw_id, arf_referenz_anw_id)
    select l_anw_id, l_anw_id from dual;

    case
    when p_row.anw_aar_id in (c_aar_hier_einfach, c_aar_hier_komplex) then

      if l_anw_id = c_anw_id then
        -- Sonderfall initiale Installation: Fall C_ANW erzeugt wird,
        -- BV-Rollen erzeugen, um Constraintverletzung zu vermeiden.
        insert into ui_admin_rol(rol_id, rol_anw_id, rol_name, rol_beschreibung, rol_aktiv, rol_sortierung)
        select 'LESER', c_anw_id, 'Leser',  'Einfaches Leserecht ohne Schreibbefugnis', 'Y', 10 from dual union all
        select 'ADMINISTRATOR', c_anw_id, 'Administrator', 'Administrationsrecht fuer Basistabellen aller Anwendungen', 'Y', 20 from dual union all
        select 'SUPER_ADMIN', c_anw_id, 'Super-Administrator', 'Administration von Basistabellen fuer neue Anwendungen, -arten oder Benutzerrechten und -rollen', 'Y', 20 from dual;

      end if;

      -- Diese Varianten haben eine 1:1-Beziehung zwischen Rolle und Recht
      insert into bv_rolle(rol_id, rol_anw_id, rol_name, rol_beschreibung, rol_aktiv)
      values (l_rol_id, c_anw_id, 'Anwendung ' || l_anw_id || ' administrieren',
              'Recht, die Anwendung ' || l_anw_id || ' zu administrieren', 'Y');

      insert into bv_rolle_recht(rre_rol_id, rre_rec_id, rre_anw_id)
      values (l_rol_id, l_rol_id, c_anw_id);

      -- Rolle in BV-Nutzungskonzept integrieren
      insert into bv_rolle_rolle(rro_rol_id, rro_parent_rol_id, rro_anw_id)
      select 'LESER', l_rol_id, c_anw_id from dual union all
      select l_rol_id, 'ADMINISTRATOR', c_anw_id from dual;

    else null;
    end case;

    -- Asynchrone Erstellung der Views im Transaktionskontext
    utils.submit_job(replace(c_action_tmpl, '#ANW_ID#', l_anw_id));
  end create_anwendung;


  procedure alter_anwendung(
    p_row bv_anwendung%rowtype)
  as
  begin
    update bv_anwendung
       set anw_aar_id = p_row.anw_aar_id,
           anw_apex_alias = p_row.anw_apex_alias,
           anw_schema = p_row.anw_schema,
           anw_name = p_row.anw_name,
           anw_beschreibung = p_row.anw_beschreibung,
           anw_aktiv = p_row.anw_aktiv,
           anw_sortierung = p_row.anw_sortierung
     where anw_id = p_row.anw_id;
  end alter_anwendung;


  procedure drop_anwendung(
    p_row bv_anwendung%rowtype)
  as
    l_action varchar2(200) := q'[begin bl_anw_pkg.drop_anw_views('#ANW_ID#'); end;]';
    l_rol_id bv_rolle.rol_id%type;
  begin
    l_rol_id := 'APP_' || p_row.anw_id;

    delete from bv_rolle_rolle
     where rro_anw_id = p_row.anw_id
        or rro_rol_id = l_rol_id
        or rro_parent_rol_id = l_rol_id;

    delete from bv_rolle_recht
     where rre_anw_id = p_row.anw_id
        or rre_rol_id = l_rol_id;

    delete from bv_benutzer_rolle
     where bro_anw_id = p_row.anw_id
        or bro_rol_id = l_rol_id;

    delete from bv_benutzer_recht
     where bre_anw_id = p_row.anw_id
        or bre_rec_id = l_rol_id;

    delete from bv_rolle
     where rol_anw_id = p_row.anw_id
        or rol_id = l_rol_id;

    delete from bv_recht
     where rec_anw_id = p_row.anw_id
        or rec_id = l_rol_id;

    delete from bv_anwendung_referenz
     where arf_anw_id = p_row.anw_id;

    delete from bv_anwendung
     where anw_id = p_row.anw_id;

    -- Asynchrone Loeschung der Views im Transaktionskontext
    l_action := replace(l_action, '#ANW_ID#', p_row.anw_id);
    utils.submit_job(l_action);

  end drop_anwendung;


  procedure create_anw_views(
    p_anw_id in varchar2)
  as
    l_stmt varchar2(32767);
    l_view_name_list varchar2(2000) := '#ANW_ID#_BV_BENUTZER:#ANW_ID#_BV_BENUTZER_RECHTE:#ANW_ID#_BV_BENUTZER_ROLLE:#ANW_ID#_BV_RECHT:#ANW_ID#_BV_ROLLE';
    l_anw_schema varchar2(30);

    cursor view_cur(p_view_names in varchar2) is
      select column_value view_name
        from table(utils.string_to_table(p_view_names));
  begin
    select anw_schema
      into l_anw_schema
      from bv_anwendung
     where anw_id = p_anw_id;
    l_stmt := q'[
create or replace view #ANW_ID#_BV_BENUTZER as
select ben.ben_id, ben.ben_ad, ben.ben_stz,
       anr.anr_name ben_anrede, tit.tit_name ben_titel,
       ben.ben_vorname, ben_nachname,
       ben.ben_email, ben.ben_telefon
  from bv_benutzer ben
  join bv_anrede anr on ben.ben_anr_id = anr.anr_id
  left join bv_titel tit on ben.ben_tit_id = tit.tit_id
 where exists (
       select 'Y'
         from bv_benutzer_rechte bre
        where bre.ben_id = bre.ben_id
          and bre.anw_id = '#ANW_ID#')]';
    execute immediate replace(l_stmt, '#ANW_ID#', upper(p_anw_id));

    l_stmt := q'[create or replace view #ANW_ID#_BV_BENUTZER_RECHTE as
select anw.anw_id, anw.anw_apex_alias, ben.ben_id, ben.ben_ad, bre.rec_id
  from bv_benutzer ben
  join bv_benutzer_rechte bre on ben.ben_id = bre.ben_id
  join bv_anwendung_referenz arf on bre.anw_id = arf.arf_referenz_anw_id
  join bv_anwendung anw on arf.arf_referenz_anw_id = anw.anw_id
 where arf.arf_anw_id = '#ANW_ID#']';
    execute immediate replace(l_stmt, '#ANW_ID#', upper(p_anw_id));

    l_stmt := q'[create or replace view #ANW_ID#_BV_BENUTZER_ROLLE as
select ben.ben_id, ben.ben_ad, bro.bro_rol_id
  from bv_benutzer_rolle bro
  join bv_benutzer ben on bro.bro_ben_id = ben.ben_id
 where sysdate between bro.bro_gueltig_von and bro.bro_gueltig_bis
   and bro.bro_anw_id = '#ANW_ID#']';
    execute immediate replace(l_stmt, '#ANW_ID#', upper(p_anw_id));

    l_stmt := q'[create or replace view #ANW_ID#_BV_RECHT as
select rec_id, rec_name, rec_beschreibung, rec_aktiv, rec_sortierung
  from bv_recht
 where rec_anw_id = '#ANW_ID#']';
    execute immediate replace(l_stmt, '#ANW_ID#', upper(p_anw_id));

    l_stmt := q'[create or replace view #ANW_ID#_BV_ROLLE as
select rol_id, rol_name, rol_beschreibung, rol_aktiv, rol_sortierung
  from bv_rolle
 where rol_anw_id = '#ANW_ID#']';
    execute immediate replace(l_stmt, '#ANW_ID#', upper(p_anw_id));

    l_view_name_list := replace(l_view_name_list, '#ANW_ID#', upper(p_anw_id));
    for vw in view_cur(l_view_name_list) loop
      l_stmt := q'[grant select, references on #VIEW_NAME# to #ANW_SCHEMA#]';
      execute immediate replace(replace(l_stmt, '#ANW_SCHEMA#', l_anw_schema), '#VIEW_NAME#', vw.view_name);
    end loop;
    
    execute immediate 'grant execute on bv_recht_pkg to ' || l_anw_schema;
  
  end create_anw_views;


  procedure drop_anw_views(
    p_anw_id in varchar2)
  as
    cursor anw_views(p_anw_id in varchar2) is
      select view_name
        from user_views
       where view_name like upper(p_anw_id) || '/_BV%' escape '/';
  begin
    for vw in anw_views(p_anw_id) loop
     execute immediate 'drop view ' || vw.view_name;
    end loop;
  end drop_anw_views;
    
  
  procedure merge_rolle(
    p_row in bv_rolle%rowtype)
  as
    l_rre_rec bv_rolle_recht%rowtype;
  begin
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
          
    case
    when get_aar_id(p_row.rol_anw_id) in (c_aar_hier_einfach, c_aar_hier_komplex) then
      merge_recht(cast_to_recht(p_row));
      l_rre_rec.rre_rol_id := p_row.rol_id;
      l_rre_rec.rre_rec_id := p_row.rol_id;
      l_rre_rec.rre_anw_id := p_row.rol_anw_id;
      merge_rolle_recht(l_rre_rec);
    else
      /* TODO: Recht/Rollenkonzept implementieren */
      null;
    end case;
  end merge_rolle;
    
    
  procedure delete_rolle(
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

    if get_aar_id(p_row.rol_anw_id) in (c_aar_hier_einfach, c_aar_hier_komplex) then
      delete from bv_recht
       where rec_id = p_row.rol_id
         and rec_anw_id = p_row.rol_anw_id;
    end if;

    delete from bv_rolle
     where rol_id = p_row.rol_id
       and rol_anw_id = p_row.rol_anw_id;

    bl_recht_pkg.refresh_mv;
  end delete_rolle;
  
  
  procedure merge_recht(
    p_row in bv_recht%rowtype)
  as
  begin
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
    
  
  procedure delete_recht(
    p_row in bv_recht%rowtype)
  as
  begin
    delete from bv_recht
     where rec_id = p_row.rec_id;
  end delete_recht;
  
    
  procedure merge_rolle_recht(
    p_row in bv_rolle_recht%rowtype)
  as
  begin
    merge into bv_rolle_recht r
    using (select p_row.rre_rol_id rre_rol_id,
                  p_row.rre_rec_id rre_rec_id,
                  p_row.rre_anw_id rre_anw_id,
                  coalesce(p_row.rre_gueltig_von, trunc(sysdate)) rre_gueltig_von,
                  coalesce(p_row.rre_gueltig_bis, date '2030-12-31') rre_gueltig_bis
             from dual) v
       on (r.rre_rol_id = v.rre_rol_id
       and r.rre_rec_id = v.rre_rec_id
       and r.rre_anw_id = v.rre_anw_id)
     when matched then update set
          rre_gueltig_von = v.rre_gueltig_von,
          rre_gueltig_bis = v.rre_gueltig_bis
     when not matched then insert(rre_rol_id, rre_rec_id, rre_anw_id, rre_gueltig_von, rre_gueltig_bis)
          values (v.rre_rol_id, v.rre_rec_id, v.rre_anw_id, v.rre_gueltig_von, v.rre_gueltig_bis);
  end merge_rolle_recht;
    
    
  procedure delete_rolle_recht(
    p_row in bv_rolle_recht%rowtype)
  as
  begin
    delete from bv_rolle_recht
     where rre_rol_id = p_row.rre_rol_id
       and rre_rec_id = p_row.rre_rec_id
       and rre_anw_id = p_row.rre_anw_id;
  end delete_rolle_recht;
    
  
  procedure merge_rolle_rolle(
    p_row in bv_rolle_rolle%rowtype)
  as
  begin
    null;
  end merge_rolle_rolle;
    
  
  procedure delete_rolle_rolle(
    p_row in bv_rolle_rolle%rowtype)
  as
  begin
    null;
  end delete_rolle_rolle;
  
  
  procedure einfache_rollen_hierarchie(
    p_anw_id in bv_anwendung.anw_id%type,
    p_rol_hierarchie in varchar2)
  as
    l_rol_parent bv_rolle.rol_id%type;
    l_rollen wwv_flow_global.vc_arr2;
  begin
  -- Alte Zuordnung loeschen
    delete from bv_rolle_rolle
     where rro_anw_id = p_anw_id;

    -- Neue Eintraege gemaess Sortierung des Controls erstellen
    l_rollen := apex_util.string_to_table(p_rol_hierarchie);
    
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


  procedure klompexe_rollen_hierarchie(
    p_anw_id in bv_anwendung.anw_id%type,
    p_rro_parent_rol_id in bv_rolle.rol_id%type,
    p_rro_child_rol_id in varchar2)
  as
    l_rol_child bv_rolle.rol_id%type;
    l_rollen wwv_flow_global.vc_arr2;
  begin
    delete from bv_rolle_rolle
     where rro_anw_id = p_anw_id
       and rro_parent_rol_id = p_rro_parent_rol_id;

    -- Neue Eintraege gemaess Sortierung des Controls erstellen
    if p_rro_child_rol_id is not null then
      l_rollen := apex_util.string_to_table(p_rro_child_rol_id);
      for rol in l_rollen.first .. l_rollen.last loop
        -- Neue Rollenzuordnung eintragen. Nicht gewaehlte Rollen werden
        -- nicht beruecksichtigt, aber auch nicht deaktiv gesetzt.
        insert into bv_rolle_rolle(rro_rol_id, rro_parent_rol_id, rro_anw_id)
        values (l_rollen(rol), p_rro_parent_rol_id, p_anw_id);
        -- Aktuelle Rolle als Parent merken
        l_rol_child := l_rollen(rol);
      end loop;
    end if;
  end klompexe_rollen_hierarchie;
  
  
end bl_anw_pkg;

/
