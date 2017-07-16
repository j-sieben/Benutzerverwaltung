--------------------------------------------------------
--  DDL for View UI_ADMIN_BEN_ROL_MAIN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "UI_ADMIN_BEN_ROL_MAIN" ("BRO_BEN_ID", "BRO_ROL_ID", "BRO_ANW_ID", "BRO_GUELTIG_VON", "BRO_GUELTIG_BIS") AS 
  select bro_ben_id,
       bro_rol_id,
       bro_anw_id,
       bro_gueltig_von,
       bro_gueltig_bis
  from bv_benutzer_rolle;

   COMMENT ON COLUMN "UI_ADMIN_BEN_ROL_MAIN"."BRO_BEN_ID" IS 'Primaerschluessel, Referenz auf BV_BENUTZER';
   COMMENT ON COLUMN "UI_ADMIN_BEN_ROL_MAIN"."BRO_ROL_ID" IS 'Primaerschluessel, Referenz auf BV_ROLLE';
   COMMENT ON COLUMN "UI_ADMIN_BEN_ROL_MAIN"."BRO_ANW_ID" IS 'Primaerschluessel, Referenz auf BV_ROLLE';
   COMMENT ON COLUMN "UI_ADMIN_BEN_ROL_MAIN"."BRO_GUELTIG_VON" IS 'Festlegung eines Gueltigkeitszeitraums';
   COMMENT ON COLUMN "UI_ADMIN_BEN_ROL_MAIN"."BRO_GUELTIG_BIS" IS 'Festlegung eines Gueltigkeitszeitraums';
   COMMENT ON TABLE "UI_ADMIN_BEN_ROL_MAIN"  IS 'UI-Wrapper der Seite ADMIN_BEN_ROL fuer Tabelle BV_BENUTZER_ROLLE'
;
