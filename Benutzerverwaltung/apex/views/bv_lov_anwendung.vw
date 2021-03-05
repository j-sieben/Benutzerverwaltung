create or replace editionable view bv_lov_anwendung as 
  select anw_name || ' (' || anw_id || ')' d, anw_id r, anw_aktiv aktiv
  from dl_bv_anwendung
 order by anw_name;

comment on table bv_lov_anwendung  is 'LOV-View aller Anwendungen';
comment on column bv_lov_anwendung.d is 'Display-Wert des LOV';
comment on column bv_lov_anwendung.r is 'Return-Wert des LOV';
comment on column bv_lov_anwendung.aktiv is 'Flag, das anzeigt, ob der Eintrag aktuell genutzt wird.';
