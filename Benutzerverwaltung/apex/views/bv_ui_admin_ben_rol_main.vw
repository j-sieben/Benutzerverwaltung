create or replace editionable view  bv_ui_admin_ben_rol_main as 
select bro_ben_id,
       bro_rol_id,
       bro_anw_id,
       bro_gueltig_ab,
       bro_gueltig_bis
  from dl_bv_benutzer_rolle;

comment on column  bv_ui_admin_ben_rol_main.bro_ben_id is 'Primaerschluessel, Referenz auf BV_BENUTZER';
comment on column  bv_ui_admin_ben_rol_main.bro_rol_id is 'Primaerschluessel, Referenz auf BV_ROLLE';
comment on column  bv_ui_admin_ben_rol_main.bro_anw_id is 'Primaerschluessel, Referenz auf BV_ROLLE';
comment on column  bv_ui_admin_ben_rol_main.bro_gueltig_ab is 'Festlegung eines Gueltigkeitszeitraums';
comment on column  bv_ui_admin_ben_rol_main.bro_gueltig_bis is 'Festlegung eines Gueltigkeitszeitraums';
comment on table  bv_ui_admin_ben_rol_main  is 'UI-Wrapper der Seite ADMIN_BEN_ROL fuer Tabelle BV_BENUTZER_ROLLE';
