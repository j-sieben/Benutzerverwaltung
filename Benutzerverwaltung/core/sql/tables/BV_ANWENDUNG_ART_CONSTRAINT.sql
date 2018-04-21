--------------------------------------------------------
--  Constraints for Table BV_ANWENDUNG_ART
--------------------------------------------------------

  ALTER TABLE "BV_ANWENDUNG_ART" ADD CONSTRAINT "AAR_AKTIV_CHK" CHECK (aar_aktiv in ('Y', 'N')) ENABLE;
