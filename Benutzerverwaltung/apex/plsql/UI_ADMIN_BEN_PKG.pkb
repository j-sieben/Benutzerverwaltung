create or replace package body ui_admin_ben_pkg 
as

  c_date_format constant varchar2(30) := 'dd.mm.yyyy';
  
  c_benutzer constant varchar2(30 byte) := 'BV_BENUTZER';
  C_BENUTZER_ROLLE constant varchar2(30 byte) := 'BV_BENUTZER_ROLLE';
  
  g_ben_row bv_benutzer%rowtype;
  g_bro_row bv_benutzer_rolle%rowtype;    
  
  
  function validate_admin_ben
    return boolean
  as
  begin
    execute immediate utl_apex.get_page_values(c_benutzer) using out g_ben_row;
    -- Validierung der Anwendungsseite
    utl_apex.assert(
      p_test => g_ben_row.ben_email is not null, 
      p_affected_element => utl_apex.get_page || 'BEN_EMAIL', 
      p_message => apex_lang.message('EMAIL_TO_MISSING'));
    utl_apex.assert(
      p_test => g_ben_row.ben_nachname is not null, 
      p_affected_element => utl_apex.get_page || 'BEN_NACHNAME', 
      p_message => apex_lang.message('LASTNAME_MISSING'));
    utl_apex.assert(
      p_test => g_ben_row.ben_aktiv_bis is not null, 
      p_affected_element => utl_apex.get_page || 'AKTIV_BIS', 
      p_message => apex_lang.message('VALID_TO_MISSING', 'der Benutzer'));
    return true;
  end validate_admin_ben;
  
  
  procedure handle_admin_ben
  as
  begin
    case
    when utl_apex.inserting then
      bl_ben_pkg.benutzer_anlegen(g_ben_row);
    when utl_apex.updating then
      bl_ben_pkg.benutzer_bearbeiten(g_ben_row);
    when utl_apex.deleting then
      bl_ben_pkg.benutzer_loeschen(g_ben_row.ben_id);
    else
      null;
    end case;  
  end handle_admin_ben;
  
  
  procedure handle_admin_ben_ig
  as
  begin
    execute immediate utl_apex.get_ig_values(p_row_type => C_BENUTZER_ROLLE) using out g_bro_row;
    case
    when utl_apex.inserting then
      bl_recht_pkg.rolle_zuweisen(g_bro_row);
    when utl_apex.updating then
      bl_recht_pkg.rolle_aktualisieren(g_bro_row);
    when utl_apex.deleting then
      bl_recht_pkg.rolle_entziehen(g_bro_row);
    else
      null;
    end case;  
  end handle_admin_ben_ig;

end ui_admin_ben_pkg;
/
