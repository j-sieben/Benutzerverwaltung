create or replace editionable view  bv_ui_admin_anr as 
  select anr_id,
       anr_name,
       anr_beschreibung,
       anr_aktiv,
       anr_sortierung
  from bv_anrede;

comment on column  bv_ui_admin_anr.anr_id is 'Primaerschluessel';
comment on column  bv_ui_admin_anr.anr_name is 'Displayname zur Darstellung im Einblendmenue auf der Oberflaeche';
comment on column  bv_ui_admin_anr.anr_beschreibung is 'Optionale Kurzbeschreibung (zur Verwendung im Tooltip)';
comment on column  bv_ui_admin_anr.anr_aktiv is 'Flag, das anzeigt, ob der Eintrag aktuell verwendet werden soll';
comment on column  bv_ui_admin_anr.anr_sortierung is 'Sortierkrierium zur Anzeige auf der Oberflaeche';
comment on table  bv_ui_admin_anr  is 'UI-Wrapper der Seite ADMIN_ANR fuer Tabelle BV_ANREDE';
