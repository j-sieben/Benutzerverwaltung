--------------------------------------------------------
--  Constraints for Table BV_ROLLE_ROLLE
--------------------------------------------------------

  ALTER TABLE "BV_ROLLE_ROLLE" ADD CONSTRAINT "BV_ROLLE_ROLLE_PK" PRIMARY KEY ("RRO_ROL_ID", "RRO_PARENT_ROL_ID", "RRO_ANW_ID")
  USING INDEX  ENABLE;
