create or replace editionable view  bv_ui_admin_rec as 
select rec_id,
       rec_anw_id,
       rec_name,
       rec_beschreibung,
       rec_aktiv,
       rec_sortierung
  from bv_recht;

comment on column  bv_ui_admin_rec.rec_id is 'Primaerschluessel';
comment on column  bv_ui_admin_rec.rec_anw_id is 'Primaerschluessel, Referenz auf BV_ANWENDUNG';
comment on column  bv_ui_admin_rec.rec_name is 'Displayname zur Darstellung im Einblendmenue auf der Oberflaeche';
comment on column  bv_ui_admin_rec.rec_beschreibung is 'Optionale Kurzbeschreibung (zur Verwendung im Tooltip)';
comment on column  bv_ui_admin_rec.rec_aktiv is 'Flag, das anzeigt, ob der Eintrag aktuell verwendet werden soll';
comment on column  bv_ui_admin_rec.rec_sortierung is 'Sortierkrierium zur Anzeige auf der Oberflaeche';
comment on table  bv_ui_admin_rec  is 'UI-Wrapper der Seite ADMIN_REC fuer Tabelle BV_RECHT';
