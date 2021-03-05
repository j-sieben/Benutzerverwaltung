create or replace view bv_lov_anwendung_admin as 
with anwendungen as (
       select column_value anw_anw_id, bv_utils.C_TRUE g_true
         from table(bl_recht.get_admin_anw(utl_apex.get_user, utl_apex.get_application_alias)))
select anw_name d, anw_id r
  from dl_bv_anwendung
  join anwendungen
    on anw_id = anw_anw_id
   and anw_aktiv = g_true;

comment on column bv_lov_anwendung_admin.d is 'Display-Wert des LOV';
comment on column bv_lov_anwendung_admin.r is 'Return-Wert des LOV';
comment on table bv_lov_anwendung_admin  is 'LOV-View aller Anwendungen, die durch den aktuell angemeldeten Benutzer administriert werden duerfen';
