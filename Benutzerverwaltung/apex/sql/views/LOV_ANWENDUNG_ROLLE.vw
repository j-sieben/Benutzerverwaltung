CREATE OR REPLACE EDITIONABLE VIEW "LOV_ANWENDUNG_ROLLE" ("D", "R") AS 
select rol.rol_name || ' (' || anw.r || ')' d, rol.rol_id || '_' || anw.r r
  from bv_rolle rol
  join lov_anwendung_admin anw
    on rol.rol_anw_id = anw.r
 where rol.rol_aktiv = 'Y'
 order by anw.r, rol.rol_name;

COMMENT ON TABLE "LOV_ANWENDUNG_ROLLE"  IS 'LOV-View der Tabelle BV_ROLLE, Join auf BV_ANWENDUNG';
