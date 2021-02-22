create or replace editionable view bv_lov_rolle as 
select rol_name d, rol_id r, rol_anw_id
  from bv_rolle
 where rol_aktiv = &C_TRUE.
 order by rol_anw_id, rol_name;

comment on table bv_lov_rolle  is 'LOV-View der Tabelle BV_ROLLE';
comment on column bv_lov_rolle.d is 'Display-Wert des LOV';
comment on column bv_lov_rolle.r is 'Return-Wert des LOV';
