--------------------------------------------------------
--  DDL for Trigger TRG_BV_ROLLE_BRIU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_BV_ROLLE_BRIU" 
before insert or update on bv_rolle
for each row
begin
  :new.rol_id := upper(dbms_assert.simple_sql_name(:new.rol_id));
end;
/
ALTER TRIGGER "TRG_BV_ROLLE_BRIU" ENABLE;
