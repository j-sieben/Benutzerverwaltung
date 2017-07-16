--------------------------------------------------------
--  DDL for View LOV_BENUTZER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "LOV_BENUTZER" ("D", "R", "BEN_AKTIV") AS 
  select ben_nachname || ', ' || ben_vorname || ' (' || ben_ad || ')' d, ben_id r,
       case when sysdate between ben_aktiv_von and ben_aktiv_bis then 'Y' else 'N' end ben_aktiv
  from bv_benutzer;

   COMMENT ON COLUMN "LOV_BENUTZER"."D" IS 'Display-Wert des LOV';
   COMMENT ON COLUMN "LOV_BENUTZER"."R" IS 'Return-Wert des LOV';
   COMMENT ON COLUMN "LOV_BENUTZER"."BEN_AKTIV" IS 'Flag, das anzeigt, ob der Eintrag aktuell genutzt wird.';
   COMMENT ON TABLE "LOV_BENUTZER"  IS 'LOV-View der Tabelle BV_BENUTZER'
;
