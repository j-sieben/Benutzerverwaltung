--------------------------------------------------------
--  DDL for Package Body UI_ADMIN_ANW_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "UI_ADMIN_ANW_PKG" 
as

  g_page_values utl_apex.page_value_tab;
  g_row bv_anwendung%rowtype;  
  
  procedure copy_values
  as
  begin
    g_page_values := utl_apex.get_page_values;
    g_row.anw_id := upper(dbms_assert.simple_sql_name(utl_apex.get_value(g_page_values, 'ANW_ID')));
    g_row.anw_apex_alias := coalesce(upper(utl_apex.get_value(g_page_values, 'ANW_APEX_ALIAS')), g_row.anw_id);
    g_row.anw_schema := upper(dbms_assert.schema_name(utl_apex.get_value(g_page_values, 'ANW_SCHEMA')));
    g_row.anw_aar_id := utl_apex.get_value(g_page_values, 'ANW_AAR_ID');
    g_row.anw_name := utl_apex.get_value(g_page_values, 'ANW_NAME');
    g_row.anw_beschreibung := utl_apex.get_value(g_page_values, 'ANW_BESCHREIBUNG');
    g_row.anw_aktiv := coalesce(utl_apex.get_value(g_page_values, 'ANW_AKTIV'), 'N');
    g_row.anw_sortierung := utl_apex.get_value(g_page_values, 'ANW_SORTIERUNG');
  end copy_values;
  
  
  procedure validate_admin_anw
  as
  begin
    copy_values;
  end validate_admin_anw;
   
   
  procedure handle_admin_anw
  as
  begin
    copy_values;
    case 
    when utl_apex.inserting then
      bl_anw_pkg.create_anwendung(g_row);
    when utl_apex.updating then
      bl_anw_pkg.alter_anwendung(g_row);
    when utl_apex.deleting then
      bl_anw_pkg.drop_anwendung(g_row);
    else
      null;
    end case;  
  end handle_admin_anw;

end ui_admin_anw_pkg;

/
