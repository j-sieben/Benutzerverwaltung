create or replace view bv_lov_anwendung_admin as 
select anw_name d, anw_id r
  from bv_anwendung anw
  join table(bl_recht.get_admin_anw(v('APP_USER'), '&APEX_ALIAS.')) rec
    on anw.anw_id = rec.column_value
 where anw.anw_aktiv = &C_TRUE.;

comment on column bv_lov_anwendung_admin.d is 'Display-Wert des LOV';
comment on column bv_lov_anwendung_admin.r is 'Return-Wert des LOV';
comment on table bv_lov_anwendung_admin  is 'LOV-View aller Anwendungen, die durch den aktuell angemeldeten Benutzer administriert werden duerfen';
