--------------------------------------------------------
--  DDL for View UI_ADMIN_KOMPLEXE_ROL_MAIN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "UI_ADMIN_KOMPLEXE_ROL_MAIN" ("RRO_ANW_ID", "RRO_PARENT_ROL_ID", "RRO_CHILD_ROL_ID") AS 
  select rro_anw_id,
       rro_parent_rol_id,
       listagg(rro_rol_id, ':') within group (order by rro_rol_id) rro_child_rol_id
  from bv_rolle_rolle
 group by rro_anw_id, rro_parent_rol_id;

   COMMENT ON COLUMN "UI_ADMIN_KOMPLEXE_ROL_MAIN"."RRO_ANW_ID" IS 'Primaerschluessel, Referenz auf BV_ROLLE';
   COMMENT ON COLUMN "UI_ADMIN_KOMPLEXE_ROL_MAIN"."RRO_PARENT_ROL_ID" IS 'Primaerschluessel, Referenz auf BV_ROLLE';
   COMMENT ON COLUMN "UI_ADMIN_KOMPLEXE_ROL_MAIN"."RRO_CHILD_ROL_ID" IS '":"-separierte Liste der Rollen, die in RRO_ANW_ID direkt inkludiert sind. Gruppierung.';
   COMMENT ON TABLE "UI_ADMIN_KOMPLEXE_ROL_MAIN"  IS 'UI-Wrapper der Seite ADMIN_KOMPLEXE_ROL fuer Tabelle BV_ROLLE_ROLLE, Aggregierende View, DML direkt ueber UI_ADMIN_KOMPLEXE_ROL_PKG'
;
