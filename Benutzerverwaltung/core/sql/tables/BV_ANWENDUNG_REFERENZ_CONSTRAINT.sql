--------------------------------------------------------
--  Constraints for Table BV_ANWENDUNG_REFERENZ
--------------------------------------------------------

  ALTER TABLE "BV_ANWENDUNG_REFERENZ" ADD CONSTRAINT "BV_ANWENDUNG_REFERENZ_PK" PRIMARY KEY ("ARF_ANW_ID", "ARF_REFERENZ_ANW_ID")
  USING INDEX  ENABLE;
