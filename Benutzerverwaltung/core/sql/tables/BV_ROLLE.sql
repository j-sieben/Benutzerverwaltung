--------------------------------------------------------
--  DDL for Table BV_ROLLE
--------------------------------------------------------

  CREATE TABLE "BV_ROLLE" 
   (	"ROL_ID" VARCHAR2(20 CHAR), 
	"ROL_ANW_ID" VARCHAR2(20 CHAR), 
	"ROL_NAME" VARCHAR2(50 CHAR), 
	"ROL_BESCHREIBUNG" VARCHAR2(200 CHAR), 
	"ROL_AKTIV" CHAR(1 BYTE) DEFAULT 'Y', 
	"ROL_SORTIERUNG" NUMBER DEFAULT 0, 
	 CONSTRAINT "BV_ROLLE_PK" PRIMARY KEY ("ROL_ID", "ROL_ANW_ID") ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS ;

   COMMENT ON COLUMN "BV_ROLLE"."ROL_ID" IS 'Primaerschluessel';
   COMMENT ON COLUMN "BV_ROLLE"."ROL_ANW_ID" IS 'Primaerschluessel, Referenz auf Tabelle BV_ANWENDUNG';
   COMMENT ON COLUMN "BV_ROLLE"."ROL_NAME" IS 'Displayname zur Darstellung im Einblendmenue auf der Oberflaeche';
   COMMENT ON COLUMN "BV_ROLLE"."ROL_BESCHREIBUNG" IS 'Optionale Kurzbeschreibung (zur Verwendung im Tooltip)';
   COMMENT ON COLUMN "BV_ROLLE"."ROL_AKTIV" IS 'Flag, das anzeigt, ob der Eintrag aktuell verwendet werden soll';
   COMMENT ON COLUMN "BV_ROLLE"."ROL_SORTIERUNG" IS 'Sortierkrierium zur Anzeige auf der Oberflaeche';
   COMMENT ON TABLE "BV_ROLLE"  IS 'Tabelle zur Deklaration von Benutzerrollen je Anwendung';
