--------------------------------------------------------
--  Constraints for Table BV_ANWENDUNG_ART
--------------------------------------------------------

  ALTER TABLE "BV_ANWENDUNG_ART" ADD CONSTRAINT "BV_ANWENDUNG_ART_PK" PRIMARY KEY ("AAR_ID")
  USING INDEX  ENABLE;
  ALTER TABLE "BV_ANWENDUNG_ART" ADD CONSTRAINT "AAR_AKTIV_CHK" CHECK (aar_aktiv in ('Y', 'N')) ENABLE;
