--------------------------------------------------------
--  DDL for Table BV_BENUTZER_RECHTE
--------------------------------------------------------

  CREATE TABLE "BV_BENUTZER_RECHTE" 
   (	"BEN_ID" NUMBER, 
	"BEN_AD" VARCHAR2(200 CHAR), 
	"ANW_ID" VARCHAR2(20 CHAR), 
	"ANW_APEX_ALIAS" VARCHAR2(20 CHAR), 
	"REC_ID" VARCHAR2(20 CHAR)
   ) ;

   COMMENT ON COLUMN "BV_BENUTZER_RECHTE"."BEN_ID" IS 'Benutzer-ID, Technischer Schluessel. Wird gebraucht fuer Joins.';
   COMMENT ON COLUMN "BV_BENUTZER_RECHTE"."BEN_AD" IS 'AD-Name des Benutzers, wir als Filterkriterium verwendet';
   COMMENT ON COLUMN "BV_BENUTZER_RECHTE"."ANW_ID" IS 'Anwendungs-ID, wird gebraucht fuer Joins';
   COMMENT ON COLUMN "BV_BENUTZER_RECHTE"."ANW_APEX_ALIAS" IS 'APEX-Alias der Anwendung, wir als Filterkriterium verwendet';
   COMMENT ON COLUMN "BV_BENUTZER_RECHTE"."REC_ID" IS 'Recht, das der Benutzer haelt.';
   COMMENT ON MATERIALIZED VIEW "BV_BENUTZER_RECHTE"  IS 'Materialisierte Sicht zur Integration der Rechte pro Benutzer';
