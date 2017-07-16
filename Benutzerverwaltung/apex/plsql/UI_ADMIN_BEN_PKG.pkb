create or replace package body ui_admin_ben_pkg 
as

  c_pkg constant varchar2(30) := $$PLSQL_UNIT;
  c_date_format constant varchar2(30) := 'dd.mm.yyyy';
  
  g_row bv_benutzer_rolle%rowtype;  
  
  procedure copy_values
  as
  begin
    execute immediate utl_apex.get_ig_values('bv_benutzer_rolle') using out g_row;
    -- Benutzer-ID aus Sessionstate kopieren
    g_row.bro_ben_id := v('P10_BEN_ID');
    apex_util.set_session_state('BRO_BEN_ID', g_row.bro_ben_id);
  end copy_values;
  
  
  function validate_admin_ben
    return boolean
  as
  begin
    copy_values;
    return true;
  end validate_admin_ben;
  
  
  procedure handle_admin_ben
  as
  begin
    copy_values;
    case
    when utl_apex.inserting then
     bl_recht_pkg.rolle_zuweisen(g_row);
    when utl_apex.updating then
      bl_recht_pkg.rolle_aktualisieren(g_row);
    when utl_apex.deleting then
      bl_recht_pkg.rolle_entziehen(g_row);
    else
      null;
    end case;  
  end handle_admin_ben;

end ui_admin_ben_pkg;
/