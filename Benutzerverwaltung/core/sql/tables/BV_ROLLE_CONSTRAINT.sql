--------------------------------------------------------
--  Constraints for Table BV_ROLLE
--------------------------------------------------------

 ALTER TABLE "BV_ROLLE" ADD CONSTRAINT "ROL_AKTIV_CHK" CHECK (rol_aktiv in ('Y', 'N')) ENABLE;
