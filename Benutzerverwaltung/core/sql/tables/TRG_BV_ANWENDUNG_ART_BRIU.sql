--------------------------------------------------------
--  DDL for Trigger TRG_BV_ANWENDUNG_ART_BRIU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_BV_ANWENDUNG_ART_BRIU" 
before insert or update on bv_anwendung_art
for each row
begin
  /* Trigger zur Sicherstellung von Datenkonsistenzen:<br>
   * - AAR_ID in Großbuchstaben<br>
   * - AAR_ID muss einfacher SQL-Name sein<br>
   * - AAR_AKTIV auf N setzen, falls NULL (Anwendung interpretiert NULL as N)<br>
   */
  :new.aar_id := upper(dbms_assert.simple_sql_name(:new.aar_id));
  :new.aar_aktiv := nvl(upper(:new.aar_aktiv), 'N');
end;
/
ALTER TRIGGER "TRG_BV_ANWENDUNG_ART_BRIU" ENABLE;
