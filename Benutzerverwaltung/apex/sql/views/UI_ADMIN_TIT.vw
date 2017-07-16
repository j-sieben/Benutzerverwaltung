--------------------------------------------------------
--  DDL for View UI_ADMIN_TIT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "UI_ADMIN_TIT" ("TIT_ID", "TIT_NAME", "TIT_BESCHREIBUNG", "TIT_AKTIV", "TIT_SORTIERUNG") AS 
  select tit_id,
       tit_name,
       tit_beschreibung,
       tit_aktiv,
       tit_sortierung
  from bv_titel;

   COMMENT ON COLUMN "UI_ADMIN_TIT"."TIT_ID" IS 'Primaerschluessel';
   COMMENT ON COLUMN "UI_ADMIN_TIT"."TIT_NAME" IS 'Displayname zur Darstellung im Einblendmenue auf der Oberflaeche';
   COMMENT ON COLUMN "UI_ADMIN_TIT"."TIT_BESCHREIBUNG" IS 'Optionale Kurzbeschreibung (zur Verwendung im Tooltip)';
   COMMENT ON COLUMN "UI_ADMIN_TIT"."TIT_AKTIV" IS 'Flag, das anzeigt, ob der Eintrag aktuell verwendet werden soll';
   COMMENT ON COLUMN "UI_ADMIN_TIT"."TIT_SORTIERUNG" IS 'Sortierkrierium zur Anzeige auf der Oberflaeche';
   COMMENT ON TABLE "UI_ADMIN_TIT"  IS 'UI-Wrapper der Seite ADMIN_TIT fuer Tabelle BV_TITEL'
;
