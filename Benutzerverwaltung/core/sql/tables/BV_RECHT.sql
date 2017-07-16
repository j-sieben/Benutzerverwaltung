--------------------------------------------------------
--  DDL for Table BV_RECHT
--------------------------------------------------------

  CREATE TABLE "BV_RECHT" 
   (	"REC_ID" VARCHAR2(20 CHAR), 
	"REC_ANW_ID" VARCHAR2(20 CHAR), 
	"REC_NAME" VARCHAR2(50 CHAR), 
	"REC_BESCHREIBUNG" VARCHAR2(200 CHAR), 
	"REC_AKTIV" CHAR(1 BYTE) DEFAULT 'Y', 
	"REC_SORTIERUNG" NUMBER DEFAULT 0, 
	 CONSTRAINT "BV_RECHT_PK" PRIMARY KEY ("REC_ID", "REC_ANW_ID") ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS ;

   COMMENT ON COLUMN "BV_RECHT"."REC_ID" IS 'Primaerschluessel';
   COMMENT ON COLUMN "BV_RECHT"."REC_ANW_ID" IS 'Primaerschluessel, Referenz auf BV_ANWENDUNG';
   COMMENT ON COLUMN "BV_RECHT"."REC_NAME" IS 'Displayname zur Darstellung im Einblendmenue auf der Oberflaeche';
   COMMENT ON COLUMN "BV_RECHT"."REC_BESCHREIBUNG" IS 'Optionale Kurzbeschreibung (zur Verwendung im Tooltip)';
   COMMENT ON COLUMN "BV_RECHT"."REC_AKTIV" IS 'Flag, das anzeigt, ob der Eintrag aktuell verwendet werden soll';
   COMMENT ON COLUMN "BV_RECHT"."REC_SORTIERUNG" IS 'Sortierkrierium zur Anzeige auf der Oberflaeche';
   COMMENT ON TABLE "BV_RECHT"  IS 'Tabelle zur Deklaration von Anwendungsrechten.';
