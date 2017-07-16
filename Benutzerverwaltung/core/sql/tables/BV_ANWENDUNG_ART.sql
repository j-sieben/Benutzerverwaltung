--------------------------------------------------------
--  DDL for Table BV_ANWENDUNG_ART
--------------------------------------------------------

  CREATE TABLE "BV_ANWENDUNG_ART" 
   (	"AAR_ID" VARCHAR2(20 CHAR), 
	"AAR_NAME" VARCHAR2(50 CHAR), 
	"AAR_BESCHREIBUNG" VARCHAR2(200 CHAR), 
	"AAR_AKTIV" CHAR(1 BYTE) DEFAULT 'Y', 
	"AAR_SORTIERUNG" NUMBER DEFAULT 0, 
	 CONSTRAINT "BV_ANWENDUNG_ART_PK" PRIMARY KEY ("AAR_ID") ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS ;

   COMMENT ON COLUMN "BV_ANWENDUNG_ART"."AAR_ID" IS 'Primaerschluessel';
   COMMENT ON COLUMN "BV_ANWENDUNG_ART"."AAR_NAME" IS 'Displayname zur Darstellung im Einblendmenue auf der Oberflaeche';
   COMMENT ON COLUMN "BV_ANWENDUNG_ART"."AAR_BESCHREIBUNG" IS 'Optionale Kurzbeschreibung (zur Verwendung im Tooltip)';
   COMMENT ON COLUMN "BV_ANWENDUNG_ART"."AAR_AKTIV" IS 'Flag, das anzeigt, ob der Eintrag aktuell verwendet werden soll';
   COMMENT ON COLUMN "BV_ANWENDUNG_ART"."AAR_SORTIERUNG" IS 'Sortierkrierium zur Anzeige auf der Oberflaeche';
   COMMENT ON TABLE "BV_ANWENDUNG_ART"  IS 'Art der Beuntzerverwaltung, die fuer diese Anwendung verwendet wird.';
