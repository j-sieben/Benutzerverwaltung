--------------------------------------------------------
--  DDL for Trigger TRG_BV_ANREDE_BRIU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_BV_ANREDE_BRIU" 
before insert or update on bv_anrede
for each row
begin
  /* Trigger zur Sicherstellung von Datenkonsistenzen:<br>
   * - ANR_ID in Großbuchstaben<br>
   * - ANR_ID muss einfacher SQL-Name sein<br>
   * - ANR_AKTIV auf N setzen, falls NULL (Anwendung interpretiert NULL as N)<br>
   */
  :new.anr_id := upper(dbms_assert.simple_sql_name(:new.anr_id));
  :new.anr_aktiv := nvl(upper(:new.anr_aktiv), 'N');
end;
/
ALTER TRIGGER "TRG_BV_ANREDE_BRIU" ENABLE;
