--------------------------------------------------------
--  DDL for Table BV_ANWENDUNG_REFERENZ
--------------------------------------------------------

  CREATE TABLE "BV_ANWENDUNG_REFERENZ" 
   (	"ARF_ANW_ID" VARCHAR2(20 CHAR), 
	"ARF_REFERENZ_ANW_ID" VARCHAR2(20 CHAR)
   ) ;

   COMMENT ON COLUMN "BV_ANWENDUNG_REFERENZ"."ARF_ANW_ID" IS 'Primaerschluessel, Referenz auf BV_ANWENDUNG, Anwendung, die eine Referenz auf andere Anwendungen hat';
   COMMENT ON COLUMN "BV_ANWENDUNG_REFERENZ"."ARF_REFERENZ_ANW_ID" IS 'Primaerschluessel, Referenz auf BV_ANWENDUNG, Anwendung, die aus einer Anwendungen referenziert wird';
   COMMENT ON TABLE "BV_ANWENDUNG_REFERENZ"  IS 'Referenztabelle, die steuert, welche Anwendung welche Anwendungsrechte anderer Anwendung zeigen soll. Wird fuer Querverweise benoetigt';
