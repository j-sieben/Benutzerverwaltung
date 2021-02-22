create or replace editionable view bv_lov_anwendung_rolle as 
select rol.rol_name || ' (' || anw.r || ')' d, rol.rol_id || '_' || anw.r r
  from bv_rolle rol
  join bv_lov_anwendung_admin anw
    on rol.rol_anw_id = anw.r
 where rol.rol_aktiv = &c_true.
 order by anw.r, rol.rol_name;

comment on table bv_lov_anwendung_rolle  is 'LOV-View der Tabelle BV_ROLLE, Join auf BV_ANWENDUNG';
