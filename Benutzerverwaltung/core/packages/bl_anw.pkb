create or replace package body bl_anw as

  /* Package-Konstanten */
  c_anw_id constant varchar2(2) := 'BV';


  /* Hilfsfunktionen */
  /** Methode erstellt intern benoetigte Rollen fuer die Benutzervewaltung, falls erforderlich
   * %param  p_row  Zeile der Tabelle BV_ANWENDUNG
   * %usage  Wird nur aufgerufen, falls Anwendung C_ANW_ID installiert wird.
   */
  procedure verwalte_bv_hierarchie(
    p_row in bv_anwendung%rowtype)
  as
  begin
    if p_row.anw_id = c_anw_id then
      -- Sonderfall initiale Installation: Fall C_ANW erzeugt wird,
      -- BV-Rollen erzeugen, um Constraintverletzung zu vermeiden.
      bl_recht.merge_rolle(
        p_rol_id => 'LESER',
        p_rol_anw_id => C_ANW_ID, 
        p_rol_name => 'Leser',
        p_rol_beschreibung => 'Einfaches Leserecht ohne Schreibbefugnis',
        p_rol_aktiv => bv_utils.C_TRUE,
        p_rol_sortierung => 10);
      bl_recht.merge_rolle(
        p_rol_id => 'ADMINISTRATOR',
        p_rol_anw_id => C_ANW_ID, 
        p_rol_name => 'Administrator',
        p_rol_beschreibung => 'Administrationsrecht fuer Basistabellen aller Anwendungen',
        p_rol_aktiv => bv_utils.C_TRUE,
        p_rol_sortierung => 20);
      bl_recht.merge_rolle(
        p_rol_id => 'SUPER_ADMIN',
        p_rol_anw_id => C_ANW_ID, 
        p_rol_name => 'Super-Administrator',
        p_rol_beschreibung => 'Administration von Basistabellen fuer neue Anwendungen, -arten oder Benutzerrechten und -rollen',
        p_rol_aktiv => bv_utils.C_TRUE,
        p_rol_sortierung => 30);
    end if;
  end verwalte_bv_hierarchie;
  
  
  /** Methode verwaltet hierarchische Rollen, falls erforderlich
   * %param  p_row  Zeile der Tabelle BV_ANWENDUNG
   * %usage  Fuegt fuer eine neue Anwendung die erforderlichen Berechtigungen ein, falls 
   *         diese ueber eine Hierarchie verfuegen. Dies ist erforderlich, um Anwendungen
   *         ueber die Benutzerveraltung verwalten zu koennen.
   */
  procedure verwalte_hierarchie(
    p_row in bv_anwendung%rowtype)
  as
    l_rol_id bv_rolle.rol_id%type;
  begin
    -- Initialisierung
    l_rol_id := 'APP_' || p_row.anw_id;
    
    -- Recht, die neue Anwendung zu administrieren, zu BV-Rechten hinzufuegen
    bl_recht.merge_recht(
      p_rec_id => l_rol_id,
      p_rec_anw_id => C_ANW_ID,
      p_rec_name => 'Anwendung ' || p_row.anw_id || ' administrieren',
      p_rec_beschreibung => 'Recht, die Anwendung ' || p_row.anw_id || ' zu administrieren',
      p_rec_aktiv => bv_utils.C_TRUE);
    
    case p_row.anw_aar_id 
    when bv_utils.C_AAR_HIER_EINFACH then
      verwalte_bv_hierarchie(p_row);

      -- Diese Variante hat eine 1:1-Beziehung zwischen Rolle und Recht
      bl_recht.merge_rolle(
        p_rol_id => l_rol_id,
        p_rol_anw_id => C_ANW_ID, 
        p_rol_name => 'Anwendung ' || p_row.anw_id || ' administrieren',
        p_rol_beschreibung => 'Recht, die Anwendung ' || p_row.anw_id || ' zu administrieren',
        p_rol_aktiv => bv_utils.C_TRUE);
      
      bl_recht.merge_rolle_recht(
        p_rre_rol_id => l_rol_id,
        p_rre_rec_id => l_rol_id,
        p_rre_anw_id => C_ANW_ID);

      -- Rolle in BV-Nutzungskonzept integrieren
      bl_recht.merge_rolle_rolle(
        p_rro_rol_id => 'LESER',
        p_rro_parent_rol_id => l_rol_id,
        p_rro_anw_id => C_ANW_ID);
      bl_recht.merge_rolle_rolle(
        p_rro_rol_id => 'ADMINISTRATOR',
        p_rro_parent_rol_id => l_rol_id,
        p_rro_anw_id => C_ANW_ID);
    when bv_utils.C_AAR_HIER_KOMPLEX then
      null;
    else
      null;
    end case;
  end verwalte_hierarchie;


  /* INTERFACE */

  procedure validiere_anwendung_art(
    p_row in out nocopy bv_anwendung_art%rowtype)
  as
  begin
    p_row.aar_id := dbms_assert.simple_sql_name(p_row.aar_id);
  end validiere_anwendung_art;
  

  procedure merge_anwendung_art(
    p_row in out nocopy bv_anwendung_art%rowtype)
  as
  begin
    -- Initialisierung
    p_row.aar_id := upper(p_row.aar_id);
    p_row.aar_aktiv := coalesce(upper(p_row.aar_aktiv), bv_utils.C_FALSE);
    
    validiere_anwendung_art(p_row);
    
    merge into bv_anwendung_art t
    using (select p_row.aar_id aar_id,
                  p_row.aar_name aar_name,
                  p_row.aar_beschreibung aar_beschreibung,
                  p_row.aar_aktiv aar_aktiv,
                  p_row.aar_sortierung aar_sortierung
             from dual) s
       on (t.aar_id = s.aar_id)
     when matched then update set
          t.aar_name = s.aar_name,
          t.aar_beschreibung = s.aar_beschreibung,
          t.aar_aktiv = s.aar_aktiv,
          t.aar_sortierung = s.aar_sortierung
     when not matched then insert (aar_id, aar_name, aar_beschreibung, aar_aktiv, aar_sortierung)
          values (s.aar_id, s.aar_name, s.aar_beschreibung, s.aar_aktiv, s.aar_sortierung);
  end merge_anwendung_art;
  
    
  procedure merge_anwendung_art(
    p_aar_id bv_anwendung_art.aar_id%type,
    p_aar_name bv_anwendung_art.aar_name%type,
    p_aar_beschreibung bv_anwendung_art.aar_beschreibung%type,
    p_aar_aktiv bv_anwendung_art.aar_aktiv%type default null,
    p_aar_sortierung bv_anwendung_art.aar_sortierung%type default null)
  as
    l_row bv_anwendung_art%rowtype;
  begin
    l_row.aar_id := p_aar_id;
    l_row.aar_name := p_aar_name;
    l_row.aar_beschreibung := p_aar_beschreibung;
    l_row.aar_aktiv := p_aar_aktiv;
    l_row.aar_sortierung := p_aar_sortierung;
    
    merge_anwendung_art(l_row);
  end merge_anwendung_art;
  
  
  procedure loesche_anwendung_art(
    p_row in bv_anwendung_art%rowtype)
  as
  begin
    delete from bv_anwendung_art
     where aar_id = p_row.aar_id;
  end loesche_anwendung_art;  
  
  
  procedure validiere_anwendung(
    p_row in out nocopy bv_anwendung%rowtype)
  as
  begin
    p_row.anw_id := dbms_assert.simple_sql_name(p_row.anw_id);
    p_row.anw_schema := dbms_assert.simple_sql_name(p_row.anw_schema);
  end validiere_anwendung;
  
  
  procedure merge_anwendung(
    p_row in out nocopy bv_anwendung%rowtype)
  as
    c_action_tmpl constant varchar2(200) := q'[begin bl_anw.create_anw_views('#ANW_ID#'); end;]';
    l_exists pls_integer;
  begin
    
    -- Initialisierung  
    p_row.anw_id := upper(p_row.anw_id);
    p_row.anw_aktiv := coalesce(upper(p_row.anw_aktiv), bv_utils.C_TRUE);
    p_row.anw_apex_alias := coalesce(p_row.anw_apex_alias, p_row.anw_id);
    p_row.anw_schema := upper(p_row.anw_schema);
    
    validiere_anwendung(p_row);
    
    select count(*)
      into l_exists
      from bv_anwendung
     where anw_id = p_row.anw_id;
    
    if l_exists = 1 then
      -- UPDATE-Zweig
      update bv_anwendung
         set anw_aar_id = p_row.anw_aar_id,
             anw_apex_alias = p_row.anw_apex_alias,
             anw_schema = p_row.anw_schema,
             anw_name = p_row.anw_name,
             anw_beschreibung = p_row.anw_beschreibung,
             anw_aktiv = p_row.anw_aktiv,
             anw_sortierung = p_row.anw_sortierung
       where anw_id = p_row.anw_id;
    else
      -- INSERT-Zweig
      insert into bv_anwendung
      values p_row;
  
      -- Referenz auf sich selbst und auf BV in Anwendungsreferenz einfuegen
      insert into bv_anwendung_referenz(arf_anw_id, arf_referenz_anw_id)
      values (p_row.anw_id, p_row.anw_id);
      
      verwalte_hierarchie(p_row);
    end if;

    -- Asynchrone Erstellung der Views im Transaktionskontext
    bv_utils.submit_job(replace(c_action_tmpl, '#ANW_ID#', p_row.anw_id));
    
  end merge_anwendung;


  procedure merge_anwendung(
    p_anw_id in bv_anwendung.anw_id%type,
    p_anw_apex_alias bv_anwendung.anw_apex_alias%type,
    p_anw_schema bv_anwendung.anw_schema%type,
    p_anw_aar_id bv_anwendung.anw_aar_id%type,
    p_anw_name bv_anwendung.anw_name%type,
    p_anw_beschreibung bv_anwendung.anw_beschreibung%type,
    p_anw_aktiv bv_anwendung.anw_aktiv%type,
    p_anw_sortierung bv_anwendung.anw_sortierung%type)
  as
    l_row bv_anwendung%rowtype;
  begin
    l_row.anw_id := p_anw_id;
    l_row.anw_apex_alias := p_anw_apex_alias;
    l_row.anw_schema := p_anw_schema;
    l_row.anw_aar_id := p_anw_aar_id;
    l_row.anw_name := p_anw_name;
    l_row.anw_beschreibung := p_anw_beschreibung;
    l_row.anw_aktiv := p_anw_aktiv;
    l_row.anw_sortierung := p_anw_sortierung;
    
    merge_anwendung(l_row);
  end merge_anwendung;


  procedure loesche_anwendung(
    p_row bv_anwendung%rowtype)
  as
    l_action varchar2(200) := q'[begin bl_anw.drop_anw_views('#ANW_ID#'); end;]';
  begin

    bl_recht.loesche_anwendung_rollen(
      p_anw_id => p_row.anw_id);

    -- Asynchrone Loeschung der Views im Transaktionskontext
    l_action := replace(l_action, '#ANW_ID#', p_row.anw_id);
    bv_utils.submit_job(l_action);

  end loesche_anwendung;


  procedure create_anw_views(
    p_anw_id in varchar2)
  as
    l_stmt varchar2(32767);
    l_view_name_list varchar2(2000) := '#ANW_ID#_BV_BENUTZER:#ANW_ID#_BV_BENUTZER_RECHTE:#ANW_ID#_BV_BENUTZER_ROLLE:#ANW_ID#_BV_RECHT:#ANW_ID#_BV_ROLLE';
    l_anw_schema varchar2(30);

    cursor view_cur(p_view_names in varchar2) is
      select column_value view_name
        from table(utl_text.string_to_table(p_view_names));
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
  join bv_anwendung anw on bre.anw_id = anw.anw_id
  left join bv_anwendung_referenz arf on bre.anw_id = arf.arf_referenz_anw_id
 where bre.anw_id = '#ANW_ID#']';
    execute immediate replace(l_stmt, '#ANW_ID#', upper(p_anw_id));

    l_stmt := q'[create or replace view #ANW_ID#_BV_BENUTZER_ROLLE as
select ben.ben_id, ben.ben_ad, bro.bro_rol_id
  from bv_benutzer_rolle bro
  join bv_benutzer ben on bro.bro_ben_id = ben.ben_id
 where sysdate between bro.bro_gueltig_ab and bro.bro_gueltig_bis
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

    begin
      l_stmt := 'grant execute on &INSTALL_USER..bv_recht_pkg to ' || l_anw_schema;
      execute immediate l_stmt;
    exception
      when others then
        dbms_output.put_line('Grant konnte nicht erteilt werden mit Anweisung ' || l_stmt);
        raise;
    end;

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
  
  
  procedure merge_anwendung_referenzen(
    p_anw_id  bv_anwendung.anw_id%type,
    p_anw_id_list varchar2)
  as
  begin
    loesche_anwendung_referenzen(p_anw_id);
    
    insert into bv_anwendung_referenz(arf_anw_id, arf_referenz_anw_id)
    select distinct p_anw_id, column_value
      from table(utl_text.string_to_table(p_anw_id));
  end merge_anwendung_referenzen;
    
    
  procedure loesche_anwendung_referenzen(
    p_anw_id  bv_anwendung.anw_id%type)
  as
  begin
    delete from bv_anwendung_referenz
     where arf_anw_id = p_anw_id;
  end loesche_anwendung_referenzen;

end bl_anw;
/
