--------------------------------------------------------
--  DDL for Table BV_ANREDE
--------------------------------------------------------

  CREATE TABLE "BV_ANREDE" 
   (	"ANR_ID" VARCHAR2(20 CHAR), 
	"ANR_NAME" VARCHAR2(50 CHAR), 
	"ANR_BESCHREIBUNG" VARCHAR2(200 CHAR), 
	"ANR_AKTIV" CHAR(1 CHAR) DEFAULT 'Y', 
	"ANR_SORTIERUNG" NUMBER(4,0) DEFAULT 0, 
	 CONSTRAINT "BV_ANREDE_PK" PRIMARY KEY ("ANR_ID") ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS ;

   COMMENT ON COLUMN "BV_ANREDE"."ANR_ID" IS 'Primaerschluessel';
   COMMENT ON COLUMN "BV_ANREDE"."ANR_NAME" IS 'Displayname zur Darstellung im Einblendmenue auf der Oberflaeche';
   COMMENT ON COLUMN "BV_ANREDE"."ANR_BESCHREIBUNG" IS 'Optionale Kurzbeschreibung (zur Verwendung im Tooltip)';
   COMMENT ON COLUMN "BV_ANREDE"."ANR_AKTIV" IS 'Flag, das anzeigt, ob der Eintrag aktuell verwendet werden soll';
   COMMENT ON COLUMN "BV_ANREDE"."ANR_SORTIERUNG" IS 'Sortierkrierium zur Anzeige auf der Oberflaeche';
   COMMENT ON TABLE "BV_ANREDE"  IS 'Lookup-Tabelle fuer Anreden in Adressen.';
