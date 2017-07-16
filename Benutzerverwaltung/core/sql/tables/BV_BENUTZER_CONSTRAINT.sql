--------------------------------------------------------
--  Constraints for Table BV_BENUTZER
--------------------------------------------------------

  ALTER TABLE "BV_BENUTZER" ADD CONSTRAINT "BV_BENUTZER_PK" PRIMARY KEY ("BEN_ID")
  USING INDEX  ENABLE;
  ALTER TABLE "BV_BENUTZER" ADD CONSTRAINT "BEN_AKTIV_BIS_NN" CHECK (ben_aktiv_bis is not null) ENABLE;
  ALTER TABLE "BV_BENUTZER" ADD CONSTRAINT "BEN_AKTIV_VON_NN" CHECK (ben_aktiv_von is not null) ENABLE;
  ALTER TABLE "BV_BENUTZER" ADD CONSTRAINT "BEN_EMAIL_NN" CHECK (ben_email is not null) ENABLE;
  ALTER TABLE "BV_BENUTZER" ADD CONSTRAINT "BEN_NACHNAME_NN" CHECK (ben_nachname is not null) ENABLE;
  ALTER TABLE "BV_BENUTZER" ADD CONSTRAINT "BEN_STZ_NN" CHECK (ben_stz is not null) ENABLE;
