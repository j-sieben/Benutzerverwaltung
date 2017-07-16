--------------------------------------------------------
--  DDL for Table BV_ANWENDUNG
--------------------------------------------------------

  CREATE TABLE "BV_ANWENDUNG" 
   (	"ANW_ID" VARCHAR2(20 CHAR), 
	"ANW_APEX_ALIAS" VARCHAR2(20 CHAR), 
	"ANW_SCHEMA" VARCHAR2(30 BYTE), 
	"ANW_AAR_ID" VARCHAR2(20 CHAR), 
	"ANW_NAME" VARCHAR2(50 CHAR), 
	"ANW_BESCHREIBUNG" VARCHAR2(200 CHAR), 
	"ANW_AKTIV" CHAR(1 BYTE) DEFAULT 'Y', 
	"ANW_SORTIERUNG" NUMBER DEFAULT 0, 
	 CONSTRAINT "BV_ANWENDUNG_PK" PRIMARY KEY ("ANW_ID") ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS ;

   COMMENT ON COLUMN "BV_ANWENDUNG"."ANW_ID" IS 'Primaerschluessel';
   COMMENT ON COLUMN "BV_ANWENDUNG"."ANW_APEX_ALIAS" IS 'APEX-Alias fuer die Anwendung';
   COMMENT ON COLUMN "BV_ANWENDUNG"."ANW_SCHEMA" IS 'Schemabenutzer der APEX-Anwendung, muss existierender Benutzer sein.';
   COMMENT ON COLUMN "BV_ANWENDUNG"."ANW_AAR_ID" IS 'Art der Anwendung, Referenzu auf BV_ANWENDUNG_ART.';
   COMMENT ON COLUMN "BV_ANWENDUNG"."ANW_NAME" IS 'Displayname zur Darstellung im Einblendmenue auf der Oberflaeche';
   COMMENT ON COLUMN "BV_ANWENDUNG"."ANW_BESCHREIBUNG" IS 'Optionale Kurzbeschreibung (zur Verwendung im Tooltip)';
   COMMENT ON COLUMN "BV_ANWENDUNG"."ANW_AKTIV" IS 'Flag, das anzeigt, ob der Eintrag aktuell verwendet werden soll';
   COMMENT ON COLUMN "BV_ANWENDUNG"."ANW_SORTIERUNG" IS 'Sortierkrierium zur Anzeige auf der Oberflaeche';
   COMMENT ON TABLE "BV_ANWENDUNG"  IS 'Liste der Anwendungen, fuer die eine Benutzerverwaltung durchgefuehrt wird.';
