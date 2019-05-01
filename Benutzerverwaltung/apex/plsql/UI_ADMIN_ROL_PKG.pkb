create or replace package body ui_admin_rol_pkg 
as

  /* Konstanten */
  c_pkg constant varchar2(30) := $$plsql_unit;
  c_hierarchie_einfach constant bv_anwendung_art.aar_id%type := 'HIERARCHIE_EINFACH';
  c_hierarchie_komplex constant bv_anwendung_art.aar_id%type := 'HIERARCHIE_KOMPLEX';
  c_rolle constant varchar2(30 byte) := 'BV_ROLLE';
  
  /* Package-Variablen */
  g_row bv_rolle%rowtype;    

  /* Hilfsfunktionen */
  
   
  /* INTERFACE */
  function get_hierarchie_url
    return varchar2
  as
    l_anw_id bv_anwendung.anw_id%type := v('P55_ROL_ANW_ID');
    l_url varchar2(1000);
  begin
    l_url := 'f?p=' || v('APP_ALIAS') || ':#PAGE#:' || v('SESSION') || '::::P#PAGE_NO#_ANW_ID:' || l_anw_id;
    
    select case anw_aar_id
           when c_hierarchie_einfach then apex_util.prepare_url(replace(replace(l_url, '#PAGE#', 'ADMIN_EINFACHE_ROL'), '#PAGE_NO#', '56'))
           when c_hierarchie_komplex then apex_util.prepare_url(replace(replace(l_url, '#PAGE#', 'ADMIN_KOMPLEXE_ROL'), '#PAGE_NO#', '57'))
           else null end
      into l_url
      from bv_anwendung
     where anw_id = l_anw_id;
    
    return l_url;
  end get_hierarchie_url;
  
  
  procedure validate_admin_rol
  as
  begin
    null;
  end validate_admin_rol;
  
  
  procedure handle_admin_rol
  as
  begin
    execute immediate utl_apex.get_ig_values(c_rolle) using out g_row;
    case 
    when utl_apex.inserting then
      bl_anw_pkg.merge_rolle(g_row);
    when utl_apex.updating then
      bl_anw_pkg.merge_rolle(g_row);
    when utl_apex.deleting then
      bl_anw_pkg.delete_rolle(g_row);
    else
      raise_application_error(-20000, apex_lang.message('UNKNOWN_REQUEST', v('REQUEST')));
    end case;
  end handle_admin_rol;
  
  
  procedure handle_admin_einfache_rol(
    p_anw_id in bv_anwendung.anw_id%type,
    p_rol_rol_shuttle ui_admin_einfache_rol_shuttle.rol_rol_shuttle%type)
  as
    l_rol_parent bv_rolle.rol_id%type;
    l_rollen wwv_flow_global.vc_arr2;
  begin
    bl_anw_pkg.einfache_rollen_hierarchie(
      p_anw_id => p_anw_id,
      p_rol_hierarchie => p_rol_rol_shuttle);
  end handle_admin_einfache_rol;

end ui_admin_rol_pkg;

/
