--------------------------------------------------------
--  Constraints for Table BV_ROLLE_RECHT
--------------------------------------------------------

  ALTER TABLE "BV_ROLLE_RECHT" ADD CONSTRAINT "BV_ROLLE_RECHT_PK" PRIMARY KEY ("RRE_ROL_ID", "RRE_REC_ID", "RRE_ANW_ID")
  USING INDEX  ENABLE;
  ALTER TABLE "BV_ROLLE_RECHT" ADD CONSTRAINT "RRE_GUELTIG_BIS_NN" CHECK (rre_gueltig_bis is not null) ENABLE;
  ALTER TABLE "BV_ROLLE_RECHT" ADD CONSTRAINT "RRE_GUELTIG_VON_NN" CHECK (rre_gueltig_von is not null) ENABLE;
