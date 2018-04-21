--------------------------------------------------------
--  DDL for Trigger TRG_BV_TITEL_BRIU
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_BV_TITEL_BRIU" 
before insert or update on bv_titel
for each row
begin
  /* Trigger zur Sicherstellung von Datenkonsistenzen:<br>
   * - TIT_ID in Großbuchstaben<br>
   * - TIT_ID muss einfacher SQL-Name sein<br>
   * - TIT_AKTIV auf N setzen, falls NULL (Anwendung interpretiert NULL as N)<br>
   */
  :new.tit_id := upper(dbms_assert.simple_sql_name(:new.tit_id));
  :new.tit_aktiv := coalesce(upper(:new.tit_aktiv), 'N');
end;
/
ALTER TRIGGER "TRG_BV_TITEL_BRIU" ENABLE;
