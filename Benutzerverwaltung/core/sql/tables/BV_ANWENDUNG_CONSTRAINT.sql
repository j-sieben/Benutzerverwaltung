--------------------------------------------------------
--  Constraints for Table BV_ANWENDUNG
--------------------------------------------------------

  ALTER TABLE "BV_ANWENDUNG" ADD CONSTRAINT "BV_ANWENDUNG_PK" PRIMARY KEY ("ANW_ID")
  USING INDEX  ENABLE;
  ALTER TABLE "BV_ANWENDUNG" ADD CONSTRAINT "ANW_AKTIV_CHK" CHECK (anw_aktiv in ('Y', 'N')) ENABLE;
