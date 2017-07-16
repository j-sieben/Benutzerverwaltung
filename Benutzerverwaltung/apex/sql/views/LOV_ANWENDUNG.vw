--------------------------------------------------------
--  DDL for View LOV_ANWENDUNG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "LOV_ANWENDUNG" ("D", "R", "AKTIV") AS 
  select anw_name || ' (' || anw_id || ')' d, anw_id r, anw_aktiv aktiv
  from bv_anwendung
 order by anw_name;

   COMMENT ON COLUMN "LOV_ANWENDUNG"."D" IS 'Display-Wert des LOV';
   COMMENT ON COLUMN "LOV_ANWENDUNG"."R" IS 'Return-Wert des LOV';
   COMMENT ON COLUMN "LOV_ANWENDUNG"."AKTIV" IS 'Flag, das anzeigt, ob der Eintrag aktuell genutzt wird.';
   COMMENT ON TABLE "LOV_ANWENDUNG"  IS 'LOV-View aller Anwendungen'
;
