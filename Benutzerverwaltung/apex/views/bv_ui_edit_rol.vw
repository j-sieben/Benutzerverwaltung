create or replace editionable view bv_ui_edit_rol as 
select rol_id,
       rol_anw_id,
       rol_name,
       rol_beschreibung,
       rol_aktiv,
       rol_sortierung
  from dl_bv_rolle;

comment on column  bv_ui_edit_rol.rol_id is 'Primaerschluessel';
comment on column  bv_ui_edit_rol.rol_anw_id is 'Referenz auf DL_BV_ANWENDUNG';
comment on column  bv_ui_edit_rol.rol_name is 'Darstelluzngsname der Rolle';
comment on column  bv_ui_edit_rol.rol_beschreibung is 'Beschreibung der Rolle';
comment on column  bv_ui_edit_rol.rol_aktiv is 'Flga, das anzeigt, ob der Datensatz aktuell genutzt wird';
comment on column  bv_ui_edit_rol.rol_sortierung is 'Sortierkriterium';
comment on table  bv_ui_edit_rol  is 'UI-Wrapper der Seite EDIT_ROL fuer Tabelle DL_BV_ROLLE';
