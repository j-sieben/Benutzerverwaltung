--------------------------------------------------------
--  DDL for Table BV_ROLLE_RECHT
--------------------------------------------------------

  CREATE TABLE "BV_ROLLE_RECHT" 
   (	"RRE_ROL_ID" VARCHAR2(20 CHAR), 
	"RRE_REC_ID" VARCHAR2(20 CHAR), 
	"RRE_ANW_ID" VARCHAR2(20 CHAR), 
	"RRE_GUELTIG_VON" DATE DEFAULT trunc(sysdate), 
	"RRE_GUELTIG_BIS" DATE DEFAULT date '2030-12-31', 
	 CONSTRAINT "BV_ROLLE_RECHT_PK" PRIMARY KEY ("RRE_ROL_ID", "RRE_REC_ID", "RRE_ANW_ID") ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS ;

   COMMENT ON COLUMN "BV_ROLLE_RECHT"."RRE_ROL_ID" IS 'Primaerschluessel, Referenz auf BV_ROLLE';
   COMMENT ON COLUMN "BV_ROLLE_RECHT"."RRE_REC_ID" IS 'Primaerschluessel, Referenz auf BV_RECHT';
   COMMENT ON COLUMN "BV_ROLLE_RECHT"."RRE_ANW_ID" IS 'Primaerschluessel, Referenz auf BV_ROLLE/BV_RECHT';
   COMMENT ON COLUMN "BV_ROLLE_RECHT"."RRE_GUELTIG_VON" IS 'Festlegung eines Gueltigkeitszeitraums';
   COMMENT ON COLUMN "BV_ROLLE_RECHT"."RRE_GUELTIG_BIS" IS 'Festlegung eines Gueltigkeitszeitraums';
   COMMENT ON TABLE "BV_ROLLE_RECHT"  IS 'Tabelle zur Zuweisung von Rechten auf Benutzer.';
