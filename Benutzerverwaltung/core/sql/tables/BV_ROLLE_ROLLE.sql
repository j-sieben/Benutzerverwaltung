--------------------------------------------------------
--  DDL for Table BV_ROLLE_ROLLE
--------------------------------------------------------

  CREATE TABLE "BV_ROLLE_ROLLE" 
   (	"RRO_ROL_ID" VARCHAR2(20 CHAR), 
	"RRO_PARENT_ROL_ID" VARCHAR2(20 CHAR), 
	"RRO_ANW_ID" VARCHAR2(20 CHAR), 
	 CONSTRAINT "BV_ROLLE_ROLLE_PK" PRIMARY KEY ("RRO_ROL_ID", "RRO_PARENT_ROL_ID", "RRO_ANW_ID") ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS ;

   COMMENT ON COLUMN "BV_ROLLE_ROLLE"."RRO_ROL_ID" IS 'Primaerschluessel, Referenz auf BV_ROLLE';
   COMMENT ON COLUMN "BV_ROLLE_ROLLE"."RRO_PARENT_ROL_ID" IS 'Primaerschluessel, Referenz auf BV_ROLLE';
   COMMENT ON COLUMN "BV_ROLLE_ROLLE"."RRO_ANW_ID" IS 'Primaerschluessel, Referenz auf BV_ROLLE';
   COMMENT ON TABLE "BV_ROLLE_ROLLE"  IS 'Selbstrefenz zur Darstellung hierarchischer Rollen';
