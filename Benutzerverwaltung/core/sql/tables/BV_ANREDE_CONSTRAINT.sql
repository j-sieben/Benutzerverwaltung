--------------------------------------------------------
--  Constraints for Table BV_ANREDE
--------------------------------------------------------

  ALTER TABLE "BV_ANREDE" ADD CONSTRAINT "ANR_AKTIV_CHK" CHECK (anr_aktiv in ('Y', 'N')) ENABLE;
