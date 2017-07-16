--------------------------------------------------------
--  Constraints for Table BV_ROLLE
--------------------------------------------------------

  ALTER TABLE "BV_ROLLE" ADD CONSTRAINT "BV_ROLLE_PK" PRIMARY KEY ("ROL_ID", "ROL_ANW_ID")
  USING INDEX  ENABLE;
  ALTER TABLE "BV_ROLLE" ADD CONSTRAINT "ROL_AKTIV_CHK" CHECK (rol_aktiv in ('Y', 'N')) ENABLE;
