create or replace package bl_ben_pkg
as

  procedure benutzer_anlegen(
    p_ben_row in out nocopy bv_benutzer%rowtype);
    
  procedure benutzer_bearbeiten(
    p_ben_row in out nocopy bv_benutzer%rowtype);
    
  procedure benutzer_loeschen(
    p_ben_id in bv_benutzer.ben_id%type);

end bl_ben_pkg;
/