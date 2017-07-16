--------------------------------------------------------
--  DDL for View LOV_ROLLE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "LOV_ROLLE" ("D", "R", "ROL_ANW_ID") AS 
  select rol_name d, rol_id r, rol_anw_id
  from bv_rolle
 where rol_aktiv = 'Y'
 order by rol_anw_id, rol_name;

   COMMENT ON COLUMN "LOV_ROLLE"."D" IS 'Display-Wert des LOV';
   COMMENT ON COLUMN "LOV_ROLLE"."R" IS 'Return-Wert des LOV';
   COMMENT ON TABLE "LOV_ROLLE"  IS 'LOV-View der Tabelle BV_ROLLE'
;
