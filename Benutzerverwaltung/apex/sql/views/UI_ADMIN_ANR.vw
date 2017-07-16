--------------------------------------------------------
--  DDL for View UI_ADMIN_ANR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "UI_ADMIN_ANR" ("ANR_ID", "ANR_NAME", "ANR_BESCHREIBUNG", "ANR_AKTIV", "ANR_SORTIERUNG") AS 
  select anr_id,
       anr_name,
       anr_beschreibung,
       anr_aktiv,
       anr_sortierung
  from bv_anrede;

   COMMENT ON COLUMN "UI_ADMIN_ANR"."ANR_ID" IS 'Primaerschluessel';
   COMMENT ON COLUMN "UI_ADMIN_ANR"."ANR_NAME" IS 'Displayname zur Darstellung im Einblendmenue auf der Oberflaeche';
   COMMENT ON COLUMN "UI_ADMIN_ANR"."ANR_BESCHREIBUNG" IS 'Optionale Kurzbeschreibung (zur Verwendung im Tooltip)';
   COMMENT ON COLUMN "UI_ADMIN_ANR"."ANR_AKTIV" IS 'Flag, das anzeigt, ob der Eintrag aktuell verwendet werden soll';
   COMMENT ON COLUMN "UI_ADMIN_ANR"."ANR_SORTIERUNG" IS 'Sortierkrierium zur Anzeige auf der Oberflaeche';
   COMMENT ON TABLE "UI_ADMIN_ANR"  IS 'UI-Wrapper der Seite ADMIN_ANR fuer Tabelle BV_ANREDE'
;
