create or replace package body bl_ben_pkg
as

  procedure benutzer_anlegen(
    p_ben_row in out nocopy bv_benutzer%rowtype)
  as
  begin
    p_ben_row.ben_id := bv_benutzer_seq.nextval;
    insert into bv_benutzer
    values p_ben_row;
  end benutzer_anlegen;
  
  
  procedure benutzer_bearbeiten(
    p_ben_row in out nocopy bv_benutzer%rowtype)
  as
  begin
    update bv_benutzer
       set ben_ad = p_ben_row.ben_ad,
           ben_stz = p_ben_row.ben_stz,
           ben_anr_id = p_ben_row.ben_anr_id,
           ben_tit_id = p_ben_row.ben_tit_id,
           ben_vorname = p_ben_row.ben_vorname,
           ben_nachname = p_ben_row.ben_nachname,
           ben_telefon = p_ben_row.ben_telefon,
           ben_aktiv_bis = p_ben_row.ben_aktiv_bis
     where ben_id = p_ben_row.ben_id;
  end benutzer_bearbeiten;
  
    
  procedure benutzer_loeschen(
    p_ben_id in bv_benutzer.ben_id%type)
  as
  begin
    delete from bv_benutzer
     where ben_id = p_ben_id;
  end benutzer_loeschen;

end bl_ben_pkg;
/