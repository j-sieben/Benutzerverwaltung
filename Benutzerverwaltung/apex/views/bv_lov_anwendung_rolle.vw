create or replace editionable view bv_lov_anwendung_rolle as 
with params as(
       select bv_utils.c_true g_true,
              'SUPER_ADMIN' g_super_admin
         from dual)
select /*+ no_merge (p) */ rol.rol_name || ' (' || anw.r || ')' d, rol.rol_id || '_' || anw.r r
  from dl_bv_rolle rol
  join bv_lov_anwendung_admin anw
    on rol.rol_anw_id = anw.r
  join params p
    on rol.rol_aktiv = g_true
   and rol.rol_id != g_super_admin
 order by anw.r, rol.rol_name;

comment on table bv_lov_anwendung_rolle  is 'LOV-View der Tabelle BV_ROLLE, Join auf BV_ANWENDUNG';
