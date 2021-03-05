create or replace editionable view  bv_ui_admin_aar as 
select aar_id,
       aar_name,
       aar_beschreibung,
       aar_aktiv,
       aar_sortierung
  from dl_bv_anwendung_art;

comment on column  bv_ui_admin_aar.aar_id is 'Primaerschluessel';
comment on column  bv_ui_admin_aar.aar_name is 'Displayname zur Darstellung im Einblendmenue auf der Oberflaeche';
comment on column  bv_ui_admin_aar.aar_beschreibung is 'Optionale Kurzbeschreibung (zur Verwendung im Tooltip)';
comment on column  bv_ui_admin_aar.aar_aktiv is 'Flag, das anzeigt, ob der Eintrag aktuell verwendet werden soll';
comment on column  bv_ui_admin_aar.aar_sortierung is 'Sortierkrierium zur Anzeige auf der Oberflaeche';
comment on table  bv_ui_admin_aar  is 'UI-Wrapper der Seite ADMIN_AAR fuer BV_ANWENDUNG_ART';
