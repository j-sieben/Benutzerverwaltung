--------------------------------------------------------
--  Constraints for Table BV_RECHT
--------------------------------------------------------

  ALTER TABLE "BV_RECHT" ADD CONSTRAINT "REC_AKTIV_CHK" CHECK (rec_aktiv in ('Y', 'N')) ENABLE;
  ALTER TABLE "BV_RECHT" ADD CONSTRAINT "REC_NAME_NN" CHECK (rec_name is not null) ENABLE;
