--------------------------------------------------------
--  DDL for Trigger TRG_BV_BENUTZER_BRIU
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_BV_BENUTZER_BRIU" 
before insert or update on bv_benutzer
for each row
begin
  /* Trigger zur Sicherstellung von Datenkonsistenzen:<br>
   * - BEN_ID aus Sequenz BV_BENUTZER_SEQ ermitteln, falls NULL<br>
   * - BEN_AKTIV_VON auf aktuellen Tag legen, falls NULL<br>
   * - BEN_AKTIV_BIS auf 31.12.2030 legen, falls NULL<br>
   */
  :new.ben_id := coalesce(:new.ben_id, bv_seq.nextval);
  :new.ben_aktiv_von := coalesce(:new.ben_aktiv_von, trunc(sysdate));
  :new.ben_aktiv_bis := coalesce(:new.ben_aktiv_bis, date '2030-12-31');
end;
/
ALTER TRIGGER "TRG_BV_BENUTZER_BRIU" ENABLE;
