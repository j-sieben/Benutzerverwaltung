--------------------------------------------------------
--  DDL for View UI_ADMIN_ANW
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "UI_ADMIN_ANW" ("ANW_ID", "ANW_APEX_ALIAS", "ANW_SCHEMA", "ANW_AAR_ID", "ANW_NAME", "ANW_BESCHREIBUNG", "ANW_AKTIV", "ANW_SORTIERUNG") AS 
  select anw_id,
       anw_apex_alias,
       anw_schema,
       anw_aar_id,
       anw_name,
       anw_beschreibung,
       anw_aktiv,
       anw_sortierung
  from bv_anwendung;

   COMMENT ON COLUMN "UI_ADMIN_ANW"."ANW_ID" IS 'Primaerschluessel';
   COMMENT ON COLUMN "UI_ADMIN_ANW"."ANW_APEX_ALIAS" IS 'APEX-Alias fuer die Anwendung';
   COMMENT ON COLUMN "UI_ADMIN_ANW"."ANW_SCHEMA" IS 'Schemabenutzer der APEX-Anwendung, muss existierender Benutzer sein.';
   COMMENT ON COLUMN "UI_ADMIN_ANW"."ANW_NAME" IS 'Displayname zur Darstellung im Einblendmenue auf der Oberflaeche';
   COMMENT ON COLUMN "UI_ADMIN_ANW"."ANW_BESCHREIBUNG" IS 'Optionale Kurzbeschreibung (zur Verwendung im Tooltip)';
   COMMENT ON COLUMN "UI_ADMIN_ANW"."ANW_AKTIV" IS 'Flag, das anzeigt, ob der Eintrag aktuell verwendet werden soll';
   COMMENT ON COLUMN "UI_ADMIN_ANW"."ANW_SORTIERUNG" IS 'Sortierkrierium zur Anzeige auf der Oberflaeche';
   COMMENT ON TABLE "UI_ADMIN_ANW"  IS 'UI-Wrapper der Seite ADMIN_ANW fuer BV_ANWENDUNG'
;
