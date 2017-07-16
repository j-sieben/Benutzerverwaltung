--------------------------------------------------------
--  DDL for Trigger TRG_BV_RECHT_BRIU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_BV_RECHT_BRIU" 
before insert or update on bv_recht
for each row
begin
  /* Trigger zur Sicherstellung von Datenkonsistenzen:<br>
   * - REC_ID in Großbuchstaben<br>
   * - REC_ID muss einfacher SQL-Name sein<br>
   * - REC_AKTIV auf N setzen, falls NULL (Anwendung interpretiert NULL as N)<br>
   */
  :new.rec_id := upper(dbms_assert.simple_sql_name(:new.rec_id));
  :new.rec_aktiv := nvl(upper(:new.rec_aktiv), 'N');
end;
/
ALTER TRIGGER "TRG_BV_RECHT_BRIU" ENABLE;
