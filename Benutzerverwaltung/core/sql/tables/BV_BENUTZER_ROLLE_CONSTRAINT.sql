--------------------------------------------------------
--  Constraints for Table BV_BENUTZER_ROLLE
--------------------------------------------------------

  ALTER TABLE "BV_BENUTZER_ROLLE" ADD CONSTRAINT "BV_BENUTZER_ROLLE_PK" PRIMARY KEY ("BRO_BEN_ID", "BRO_ROL_ID", "BRO_ANW_ID")
  USING INDEX  ENABLE;
  ALTER TABLE "BV_BENUTZER_ROLLE" ADD CONSTRAINT "BRO_GUELTIG_BIS_NN" CHECK (bro_gueltig_bis is not null) ENABLE;
  ALTER TABLE "BV_BENUTZER_ROLLE" ADD CONSTRAINT "BRO_GUELTIG_VON_NN" CHECK (bro_gueltig_von is not null) ENABLE;
