create or replace editionable view bv_lov_titel as 
select tit_name d, tit_id r
  from dl_bv_titel
 order by tit_sortierung, tit_name;

comment on table bv_lov_titel  is 'LOV-View der Tabelle BV_TITEL';
comment on column bv_lov_titel.d is 'Display-Wert des LOV';
comment on column bv_lov_titel.r is 'Return-Wert des LOV';
