--------------------------------------------------------
--  DDL for Trigger TRG_BV_ANWENDUNG_BRIU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_BV_ANWENDUNG_BRIU" 
before insert or update on bv_anwendung
for each row
begin
  /* Trigger zur Sicherstellung von Datenkonsistenzen:<br>
   * - ANW_ID in Großbuchstaben<br>
   * - ANW_ID muss einfacher SQL-Name sein<br>
   * - ANW_AKTIV auf N setzen, falls NULL (Anwendung interpretiert NULL as N)<br>
   * - ANW_APEX_ALIAS auf ANW_ID setzen, falls NULL<br>
   * - ANW_SCHEMA muss vorhandener Schemaname sein.<br>
   */
  :new.anw_id := upper(dbms_assert.simple_sql_name(:new.anw_id));
  :new.anw_aktiv := coalesce(upper(:new.anw_aktiv), 'N');
  :new.anw_apex_alias := coalesce(:new.anw_apex_alias, :new.anw_id);
  :new.anw_schema := upper(dbms_assert.schema_name(:new.anw_schema));
exception
  when no_data_found then
    raise_application_error(-20000, 'Der Benutzer der APEX-Anwendung existiert nicht.');
end;
/
ALTER TRIGGER "TRG_BV_ANWENDUNG_BRIU" ENABLE;
