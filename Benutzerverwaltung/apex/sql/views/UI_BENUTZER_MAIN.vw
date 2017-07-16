--------------------------------------------------------
--  DDL for View UI_BENUTZER_MAIN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "UI_BENUTZER_MAIN" ("BEN_ID", "BEN_AD", "BEN_STZ", "ANR_NAME", "TIT_NAME", "BEN_VORNAME", "BEN_NACHNAME", "BEN_EMAIL", "BEN_TELEFON", "BEN_AKTIV") AS 
  select ben.ben_id,
       ben.ben_ad,
       ben.ben_stz,
       anr.anr_name,
       tit.tit_name,
       ben.ben_vorname,
       ben.ben_nachname,
       ben.ben_email,
       ben.ben_telefon,
       case when sysdate between ben.ben_aktiv_von and ben.ben_aktiv_bis
       then 'Ja'
       else 'Nein' end ben_aktiv
  from bv_benutzer ben
  join bv_anrede anr on ben.ben_anr_id = anr.anr_id
  left join bv_titel tit on ben.ben_tit_id = tit.tit_id;

   COMMENT ON COLUMN "UI_BENUTZER_MAIN"."BEN_ID" IS 'Primaerschluessel';
   COMMENT ON COLUMN "UI_BENUTZER_MAIN"."BEN_AD" IS 'Active Directory DN';
   COMMENT ON COLUMN "UI_BENUTZER_MAIN"."BEN_STZ" IS 'Stellenzeichen';
   COMMENT ON COLUMN "UI_BENUTZER_MAIN"."ANR_NAME" IS 'Anrede des Benutzers';
   COMMENT ON COLUMN "UI_BENUTZER_MAIN"."TIT_NAME" IS 'Titel des Benutzers';
   COMMENT ON COLUMN "UI_BENUTZER_MAIN"."BEN_VORNAME" IS 'Vorname des Benutzers';
   COMMENT ON COLUMN "UI_BENUTZER_MAIN"."BEN_NACHNAME" IS 'Nachname des Benutzers';
   COMMENT ON COLUMN "UI_BENUTZER_MAIN"."BEN_EMAIL" IS 'EMail-Adresse des Benutzers';
   COMMENT ON COLUMN "UI_BENUTZER_MAIN"."BEN_TELEFON" IS 'Telefnonnumer des Benutzers';
   COMMENT ON COLUMN "UI_BENUTZER_MAIN"."BEN_AKTIV" IS 'Darstellug Ja|Nein, ob Benutzer aktiv ist oder nicht';
   COMMENT ON TABLE "UI_BENUTZER_MAIN"  IS 'UI-Wrapper der Seite BENUTZER_MAIN um BV_BENUTZER, Darstellung mit aufgeloesten Lookup-Tabellen'
;
