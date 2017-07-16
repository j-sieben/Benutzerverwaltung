--------------------------------------------------------
--  DDL for View UI_ADMIN_AAR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "UI_ADMIN_AAR" ("AAR_ID", "AAR_NAME", "AAR_BESCHREIBUNG", "AAR_AKTIV", "AAR_SORTIERUNG") AS 
  select aar_id,
       aar_name,
       aar_beschreibung,
       aar_aktiv,
       aar_sortierung
  from bv_anwendung_art;

   COMMENT ON COLUMN "UI_ADMIN_AAR"."AAR_ID" IS 'Primaerschluessel';
   COMMENT ON COLUMN "UI_ADMIN_AAR"."AAR_NAME" IS 'Displayname zur Darstellung im Einblendmenue auf der Oberflaeche';
   COMMENT ON COLUMN "UI_ADMIN_AAR"."AAR_BESCHREIBUNG" IS 'Optionale Kurzbeschreibung (zur Verwendung im Tooltip)';
   COMMENT ON COLUMN "UI_ADMIN_AAR"."AAR_AKTIV" IS 'Flag, das anzeigt, ob der Eintrag aktuell verwendet werden soll';
   COMMENT ON COLUMN "UI_ADMIN_AAR"."AAR_SORTIERUNG" IS 'Sortierkrierium zur Anzeige auf der Oberflaeche';
   COMMENT ON TABLE "UI_ADMIN_AAR"  IS 'UI-Wrapper der Seite ADMIN_AAR fuer BV_ANWENDUNG_ART'
;
