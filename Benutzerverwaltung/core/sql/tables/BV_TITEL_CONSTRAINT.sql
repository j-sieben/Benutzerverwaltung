--------------------------------------------------------
--  Constraints for Table BV_TITEL
--------------------------------------------------------

  ALTER TABLE "BV_TITEL" ADD CONSTRAINT "BV_TITEL_PK" PRIMARY KEY ("TIT_ID")
  USING INDEX  ENABLE;
  ALTER TABLE "BV_TITEL" ADD CONSTRAINT "TIT_AKTIV_CHK" CHECK (tit_aktiv in ('Y', 'N')) ENABLE;
