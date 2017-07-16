--------------------------------------------------------
--  DDL for Table BV_BENUTZER_RECHT
--------------------------------------------------------

  CREATE TABLE "BV_BENUTZER_RECHT" 
   (	"BRE_BEN_ID" NUMBER, 
	"BRE_REC_ID" VARCHAR2(20 CHAR), 
	"BRE_ANW_ID" VARCHAR2(20 CHAR), 
	"BRE_GUELTIG_VON" DATE DEFAULT trunc(sysdate), 
	"BRE_GUELTIG_BIS" DATE DEFAULT date '2030-12-31', 
	 CONSTRAINT "BV_BENUTZER_RECHT_PK" PRIMARY KEY ("BRE_BEN_ID", "BRE_REC_ID", "BRE_ANW_ID") ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS ;

   COMMENT ON COLUMN "BV_BENUTZER_RECHT"."BRE_BEN_ID" IS 'Primaerschluessel, Referenz auf BV_BENUTZER';
   COMMENT ON COLUMN "BV_BENUTZER_RECHT"."BRE_REC_ID" IS 'Primaerschluessel, Referenz auf BV_RECHT';
   COMMENT ON COLUMN "BV_BENUTZER_RECHT"."BRE_ANW_ID" IS 'Primaerschluessel, Referenz auf BV_RECHT';
   COMMENT ON COLUMN "BV_BENUTZER_RECHT"."BRE_GUELTIG_VON" IS 'Festlegung eines Gueltigkeitszeitraums';
   COMMENT ON COLUMN "BV_BENUTZER_RECHT"."BRE_GUELTIG_BIS" IS 'Festlegung eines Gueltigkeitszeitraums';
   COMMENT ON TABLE "BV_BENUTZER_RECHT"  IS 'Tabelle zur Zuweisung von Rechten auf Benutzer.';
