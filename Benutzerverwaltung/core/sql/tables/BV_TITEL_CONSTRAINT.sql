--------------------------------------------------------
--  Constraints for Table BV_TITEL
--------------------------------------------------------

  ALTER TABLE "BV_TITEL" ADD CONSTRAINT "TIT_AKTIV_CHK" CHECK (tit_aktiv in ('Y', 'N')) ENABLE;
