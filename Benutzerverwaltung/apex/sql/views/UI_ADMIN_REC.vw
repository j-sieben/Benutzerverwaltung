--------------------------------------------------------
--  DDL for View UI_ADMIN_REC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "UI_ADMIN_REC" ("REC_ID", "REC_ANW_ID", "REC_NAME", "REC_BESCHREIBUNG", "REC_AKTIV", "REC_SORTIERUNG") AS 
  select rec_id,
       rec_anw_id,
       rec_name,
       rec_beschreibung,
       rec_aktiv,
       rec_sortierung
  from bv_recht;

   COMMENT ON COLUMN "UI_ADMIN_REC"."REC_ID" IS 'Primaerschluessel';
   COMMENT ON COLUMN "UI_ADMIN_REC"."REC_ANW_ID" IS 'Primaerschluessel, Referenz auf BV_ANWENDUNG';
   COMMENT ON COLUMN "UI_ADMIN_REC"."REC_NAME" IS 'Displayname zur Darstellung im Einblendmenue auf der Oberflaeche';
   COMMENT ON COLUMN "UI_ADMIN_REC"."REC_BESCHREIBUNG" IS 'Optionale Kurzbeschreibung (zur Verwendung im Tooltip)';
   COMMENT ON COLUMN "UI_ADMIN_REC"."REC_AKTIV" IS 'Flag, das anzeigt, ob der Eintrag aktuell verwendet werden soll';
   COMMENT ON COLUMN "UI_ADMIN_REC"."REC_SORTIERUNG" IS 'Sortierkrierium zur Anzeige auf der Oberflaeche';
   COMMENT ON TABLE "UI_ADMIN_REC"  IS 'UI-Wrapper der Seite ADMIN_REC fuer Tabelle BV_RECHT'
;
