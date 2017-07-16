--------------------------------------------------------
--  DDL for View UI_ADMIN_BEN_MAIN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "UI_ADMIN_BEN_MAIN" ("BEN_ID", "BEN_AD", "BEN_STZ", "BEN_ANR_ID", "BEN_TIT_ID", "BEN_VORNAME", "BEN_NACHNAME", "BEN_EMAIL", "BEN_TELEFON", "BEN_AKTIV_VON", "BEN_AKTIV_BIS") AS 
  select ben_id,
       ben_ad,
       ben_stz,
       ben_anr_id,
       ben_tit_id,
       ben_vorname,
       ben_nachname,
       ben_email,
       ben_telefon,
       ben_aktiv_von,
       ben_aktiv_bis
  from bv_benutzer ben;

   COMMENT ON COLUMN "UI_ADMIN_BEN_MAIN"."BEN_ID" IS 'Primaerschluessel';
   COMMENT ON COLUMN "UI_ADMIN_BEN_MAIN"."BEN_AD" IS 'Active Directory DN';
   COMMENT ON COLUMN "UI_ADMIN_BEN_MAIN"."BEN_STZ" IS 'Stellenzeichen';
   COMMENT ON COLUMN "UI_ADMIN_BEN_MAIN"."BEN_ANR_ID" IS 'Referenz auf BV_ANREDE';
   COMMENT ON COLUMN "UI_ADMIN_BEN_MAIN"."BEN_TIT_ID" IS 'Referenz auf BV_TITEL';
   COMMENT ON COLUMN "UI_ADMIN_BEN_MAIN"."BEN_VORNAME" IS 'Vorname des Benutzers';
   COMMENT ON COLUMN "UI_ADMIN_BEN_MAIN"."BEN_NACHNAME" IS 'Nachname des Benutzers';
   COMMENT ON COLUMN "UI_ADMIN_BEN_MAIN"."BEN_EMAIL" IS 'EMail-Adresse des Benutzers';
   COMMENT ON COLUMN "UI_ADMIN_BEN_MAIN"."BEN_TELEFON" IS 'Telefnonnumer des Benutzers';
   COMMENT ON COLUMN "UI_ADMIN_BEN_MAIN"."BEN_AKTIV_VON" IS 'Benutzer gueltig von';
   COMMENT ON COLUMN "UI_ADMIN_BEN_MAIN"."BEN_AKTIV_BIS" IS 'Benutzer gueltig von';
   COMMENT ON TABLE "UI_ADMIN_BEN_MAIN"  IS 'UI-Wrapper der Seite BEN_ADMIN fuer Tabelle BV_BENUTZER'
;
