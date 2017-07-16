--------------------------------------------------------
--  Constraints for Table BV_BENUTZER_RECHT
--------------------------------------------------------

  ALTER TABLE "BV_BENUTZER_RECHT" ADD CONSTRAINT "BV_BENUTZER_RECHT_PK" PRIMARY KEY ("BRE_BEN_ID", "BRE_REC_ID", "BRE_ANW_ID")
  USING INDEX  ENABLE;
  ALTER TABLE "BV_BENUTZER_RECHT" ADD CONSTRAINT "BRE_GUELTIG_BIS_NN" CHECK (bre_gueltig_bis is not null) ENABLE;
  ALTER TABLE "BV_BENUTZER_RECHT" ADD CONSTRAINT "BRE_GUELTIG_VON_NN" CHECK (bre_gueltig_von is not null) ENABLE;
