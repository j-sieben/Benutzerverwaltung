create or replace editionable view bv_lov_anrede as 
select anr_name d, anr_id r
  from dl_bv_anrede;

comment on column bv_lov_anrede.d is 'Display-Wert des LOV';
comment on column bv_lov_anrede.r is 'Return-Wert des LOV';
comment on table bv_lov_anrede  is 'LOV-View der Tabelle BV_ANREDE';
