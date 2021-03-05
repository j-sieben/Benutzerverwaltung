create or replace view bv_ui_admin_anw as 
select anw_id,
       anw_apex_alias,
       anw_schema,
       aar_name anw_aar_id,
       anw_name,
       anw_beschreibung,
       case anw_aktiv when bv_utils.C_TRUE then 'fa-check' else 'fa-times' end anw_aktiv,
       anw_sortierung,
       case 
         when anw_id = utl_apex.get_application_alias then
           '#'
         else
           utl_apex.get_page_url(
             p_page => 'EDIT_ANW',
             p_param_items => 'P41_ANW_ID',
             p_value_list => anw_id)
       end anwendung_link,
       case 
         when anw_id = utl_apex.get_application_alias then
           '#'
         when anw_aar_id = bv_utils.C_AAR_HIER_KOMPLEX then
           utl_apex.get_page_url(
             p_page => 'EDIT_KOMPLEXE_ROL',
             p_param_items => 'P57_ANW_ID',
             p_value_list => anw_id)
         else
           utl_apex.get_page_url(
             p_page => 'EDIT_EINFACHE_ROL',
             p_param_items => 'P56_ANW_ID',
             p_value_list => anw_id)
       end hierarchie_link,
       case 
         when anw_id = utl_apex.get_application_alias then
           'fa-lock'
         else
           'fa-pencil'
       end link_icon
  from dl_bv_anwendung
  join dl_bv_anwendung_art
    on anw_aar_id = aar_id;

comment on table  bv_ui_admin_anw  is 'UI-Wrapper der Seite ADMIN_ANW fuer BV_ANWENDUNG';
comment on column  bv_ui_admin_anw.anw_id is 'Primaerschluessel';
comment on column  bv_ui_admin_anw.anw_apex_alias is 'APEX-Alias fuer die Anwendung';
comment on column  bv_ui_admin_anw.anw_schema is 'Schemabenutzer der APEX-Anwendung, muss existierender Benutzer sein.';
comment on column  bv_ui_admin_anw.anw_name is 'Displayname zur Darstellung im Einblendmenue auf der Oberflaeche';
comment on column  bv_ui_admin_anw.anw_beschreibung is 'Optionale Kurzbeschreibung (zur Verwendung im Tooltip)';
comment on column  bv_ui_admin_anw.anw_aktiv is 'Flag, das anzeigt, ob der Eintrag aktuell verwendet werden soll';
comment on column  bv_ui_admin_anw.anw_sortierung is 'Sortierkrierium zur Anzeige auf der Oberflaeche';
comment on column  bv_ui_admin_anw.anwendung_link is 'URL zur Verzweigung auf die Bearbeitungsseite der Anwendung, konditional, Benutzerverwaltung selbst kann nicht bearbeitet werden';
comment on column  bv_ui_admin_anw.hierarchie_link is 'URL zur Verzweigung auf die Bearbeitungsseite der Hierarchie, konditional, Benutzerverwaltung selbst kann nicht bearbeitet werden';
comment on column  bv_ui_admin_anw.link_icon is 'FA-Icon, das für den Link angezeigt wird.';
