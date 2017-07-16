--------------------------------------------------------
--  DDL for Table BV_TITEL
--------------------------------------------------------

  CREATE TABLE "BV_TITEL" 
   (	"TIT_ID" VARCHAR2(20 CHAR), 
	"TIT_NAME" VARCHAR2(50 CHAR), 
	"TIT_BESCHREIBUNG" VARCHAR2(200 CHAR), 
	"TIT_AKTIV" CHAR(1 CHAR) DEFAULT 'Y', 
	"TIT_SORTIERUNG" NUMBER(4,0) DEFAULT 0, 
	 CONSTRAINT "BV_TITEL_PK" PRIMARY KEY ("TIT_ID") ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS ;

   COMMENT ON COLUMN "BV_TITEL"."TIT_ID" IS 'Primaerschluessel';
   COMMENT ON COLUMN "BV_TITEL"."TIT_NAME" IS 'Displayname zur Darstellung im Einblendmenue auf der Oberflaeche';
   COMMENT ON COLUMN "BV_TITEL"."TIT_BESCHREIBUNG" IS 'Optionale Kurzbeschreibung (zur Verwendung im Tooltip)';
   COMMENT ON COLUMN "BV_TITEL"."TIT_AKTIV" IS 'Flag, das anzeigt, ob der Eintrag aktuell verwendet werden soll';
   COMMENT ON COLUMN "BV_TITEL"."TIT_SORTIERUNG" IS 'Sortierkrierium zur Anzeige auf der Oberflaeche';
   COMMENT ON TABLE "BV_TITEL"  IS 'Lookup-Tabelle fuer akademische Titel in Adressen.';
