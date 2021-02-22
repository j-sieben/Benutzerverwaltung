create or replace view bv_ui_admin_anw as 
select anw_id,
       anw_apex_alias,
       anw_schema,
       anw_aar_id,
       anw_name,
       anw_beschreibung,
       anw_aktiv,
       anw_sortierung
  from bv_anwendung;

comment on table  bv_ui_admin_anw  is 'UI-Wrapper der Seite ADMIN_ANW fuer BV_ANWENDUNG';
comment on column  bv_ui_admin_anw.anw_id is 'Primaerschluessel';
comment on column  bv_ui_admin_anw.anw_apex_alias is 'APEX-Alias fuer die Anwendung';
comment on column  bv_ui_admin_anw.anw_schema is 'Schemabenutzer der APEX-Anwendung, muss existierender Benutzer sein.';
comment on column  bv_ui_admin_anw.anw_name is 'Displayname zur Darstellung im Einblendmenue auf der Oberflaeche';
comment on column  bv_ui_admin_anw.anw_beschreibung is 'Optionale Kurzbeschreibung (zur Verwendung im Tooltip)';
comment on column  bv_ui_admin_anw.anw_aktiv is 'Flag, das anzeigt, ob der Eintrag aktuell verwendet werden soll';
comment on column  bv_ui_admin_anw.anw_sortierung is 'Sortierkrierium zur Anzeige auf der Oberflaeche';
