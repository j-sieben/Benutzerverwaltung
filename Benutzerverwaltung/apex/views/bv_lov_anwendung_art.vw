create or replace editionable view bv_lov_anwendung_art as 
  select aar_name d, aar_id r, aar_aktiv ist_aktiv
  from dl_bv_anwendung_art;

comment on table bv_lov_anwendung_art  is 'LOV-View aller Anwendungsarten';
comment on column bv_lov_anwendung_art.d is 'Display-Wert des LOV';
comment on column bv_lov_anwendung_art.r is 'Return-Wert des LOV';
