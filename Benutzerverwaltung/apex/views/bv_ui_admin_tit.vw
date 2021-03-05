create or replace editionable view  bv_ui_admin_tit as 
select tit_id,
       tit_name,
       tit_beschreibung,
       tit_aktiv,
       tit_sortierung
  from dl_bv_titel;

comment on column  bv_ui_admin_tit.tit_id is 'Primaerschluessel';
comment on column  bv_ui_admin_tit.tit_name is 'Displayname zur Darstellung im Einblendmenue auf der Oberflaeche';
comment on column  bv_ui_admin_tit.tit_beschreibung is 'Optionale Kurzbeschreibung (zur Verwendung im Tooltip)';
comment on column  bv_ui_admin_tit.tit_aktiv is 'Flag, das anzeigt, ob der Eintrag aktuell verwendet werden soll';
comment on column  bv_ui_admin_tit.tit_sortierung is 'Sortierkrierium zur Anzeige auf der Oberflaeche';
comment on table  bv_ui_admin_tit  is 'UI-Wrapper der Seite ADMIN_TIT fuer Tabelle BV_TITEL';
