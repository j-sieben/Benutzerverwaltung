--------------------------------------------------------
--  DDL for Table BV_BENUTZER_ROLLE
--------------------------------------------------------

  CREATE TABLE "BV_BENUTZER_ROLLE" 
   (	"BRO_BEN_ID" NUMBER, 
	"BRO_ROL_ID" VARCHAR2(20 CHAR), 
	"BRO_ANW_ID" VARCHAR2(20 CHAR), 
	"BRO_GUELTIG_VON" DATE DEFAULT trunc(sysdate), 
	"BRO_GUELTIG_BIS" DATE DEFAULT date '2030-12-31', 
	 CONSTRAINT "BV_BENUTZER_ROLLE_PK" PRIMARY KEY ("BRO_BEN_ID", "BRO_ROL_ID", "BRO_ANW_ID") ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS ;

   COMMENT ON COLUMN "BV_BENUTZER_ROLLE"."BRO_BEN_ID" IS 'Primaerschluessel, Referenz auf BV_BENUTZER';
   COMMENT ON COLUMN "BV_BENUTZER_ROLLE"."BRO_ROL_ID" IS 'Primaerschluessel, Referenz auf BV_ROLLE';
   COMMENT ON COLUMN "BV_BENUTZER_ROLLE"."BRO_ANW_ID" IS 'Primaerschluessel, Referenz auf BV_ROLLE';
   COMMENT ON COLUMN "BV_BENUTZER_ROLLE"."BRO_GUELTIG_VON" IS 'Festlegung eines Gueltigkeitszeitraums';
   COMMENT ON COLUMN "BV_BENUTZER_ROLLE"."BRO_GUELTIG_BIS" IS 'Festlegung eines Gueltigkeitszeitraums';
   COMMENT ON TABLE "BV_BENUTZER_ROLLE"  IS 'Tabelle zur Zuweisung von Rechten auf Benutzer.';
