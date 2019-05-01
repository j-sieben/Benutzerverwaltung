--------------------------------------------------------
--  DDL for Table BV_BENUTZER
--------------------------------------------------------

  CREATE TABLE "BV_BENUTZER" 
   (	"BEN_ID" NUMBER, 
	"BEN_AD" VARCHAR2(200 CHAR), 
	"BEN_STZ" VARCHAR2(20 CHAR), 
	"BEN_ANR_ID" VARCHAR2(20 CHAR), 
	"BEN_TIT_ID" VARCHAR2(20 CHAR), 
	"BEN_VORNAME" VARCHAR2(50 CHAR), 
	"BEN_NACHNAME" VARCHAR2(50 CHAR), 
	"BEN_EMAIL" VARCHAR2(200 CHAR), 
	"BEN_TELEFON" VARCHAR2(50 CHAR), 
	"BEN_AKTIV_VON" DATE DEFAULT trunc(sysdate), 
	"BEN_AKTIV_BIS" DATE DEFAULT date '2030-12-31'
   );

   COMMENT ON COLUMN "BV_BENUTZER"."BEN_ID" IS 'Primaerschluessel';
   COMMENT ON COLUMN "BV_BENUTZER"."BEN_AD" IS 'Active Directory DN';
   COMMENT ON COLUMN "BV_BENUTZER"."BEN_STZ" IS 'Stellenzeichen';
   COMMENT ON COLUMN "BV_BENUTZER"."BEN_ANR_ID" IS 'Referenz auf BV_ANREDE';
   COMMENT ON COLUMN "BV_BENUTZER"."BEN_TIT_ID" IS 'Referenz auf BV_TITEL';
   COMMENT ON COLUMN "BV_BENUTZER"."BEN_VORNAME" IS 'Vorname des Benutzers';
   COMMENT ON COLUMN "BV_BENUTZER"."BEN_NACHNAME" IS 'Nachname des Benutzers';
   COMMENT ON COLUMN "BV_BENUTZER"."BEN_EMAIL" IS 'EMail-Adresse des Benutzers';
   COMMENT ON COLUMN "BV_BENUTZER"."BEN_TELEFON" IS 'Telefnonnumer des Benutzers';
   COMMENT ON COLUMN "BV_BENUTZER"."BEN_AKTIV_VON" IS 'Benutzer gueltig von';
   COMMENT ON COLUMN "BV_BENUTZER"."BEN_AKTIV_BIS" IS 'Benutzer gueltig von';
   COMMENT ON TABLE "BV_BENUTZER"  IS 'Benutzertabelle';
