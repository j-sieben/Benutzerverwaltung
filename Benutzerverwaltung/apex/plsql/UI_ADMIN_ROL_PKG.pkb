--------------------------------------------------------
--  DDL for Package Body UI_ADMIN_ROL_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "UI_ADMIN_ROL_PKG" 
as

  /* Konstanten */
  c_pkg constant varchar2(30) := $$PLSQL_UNIT;
  
  /* Package-Variablen */
  g_row bv_rolle%rowtype;  
  
  procedure copy_values
  as
  begin
    execute immediate utl_apex.get_ig_values('bv_rolle') using out g_row;
    -- Anwendungs-ID aus Sessionstatus umkopieren
    g_row.rol_anw_id := v('P55_ROL_ANW_ID');
    apex_util.set_session_state('ROL_ANW_ID', g_row.rol_anw_id);
  end copy_values;
   

  /* Hilfsfunktionen */
  
   
  /* INTERFACE */
  function get_hierarchie_url
    return varchar2
  as
    l_anw_id bv_anwendung.anw_id%type := v('P55_ROL_ANW_ID');
    l_url varchar2(1000);
  begin
      with params as(
           select 'f?p=' || v('APP_ALIAS') || ':#PAGE#:' || v('SESSION') || '::::P#PAGE_NO#_ANW_ID:' || l_anw_id url
             from dual)
    select /*+ NO_MERGE (p) */ case anw_aar_id
           when 'HIERARCHIE_EINFACH' then apex_util.prepare_url(replace(replace(p.url, '#PAGE#', 'ADMIN_EINFACHE_ROL'), '#PAGE_NO#', '56'))
           when 'HIERARCHIE_KOMPLEX' then apex_util.prepare_url(replace(replace(p.url, '#PAGE#', 'ADMIN_KOMPLEXE_ROL'), '#PAGE_NO#', '57'))
           else null end
      into l_url
      from bv_anwendung
     cross join params p
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
    copy_values;
    case 
    when utl_apex.inserting then
      bl_anw_pkg.merge_rolle(g_row);
    when utl_apex.updating then
      bl_anw_pkg.merge_rolle(g_row);
    when utl_apex.deleting then
      bl_anw_pkg.delete_rolle(g_row);
    else
      raise_application_error(-20000, 'Unknown REQUEST: ' || v('REQUEST'));
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
