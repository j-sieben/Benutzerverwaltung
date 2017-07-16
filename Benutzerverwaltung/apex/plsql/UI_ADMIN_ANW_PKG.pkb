--------------------------------------------------------
--  DDL for Package Body UI_ADMIN_ANW_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "UI_ADMIN_ANW_PKG" 
as

  g_row bv_anwendung%rowtype;  
  
  procedure copy_values
  as
  begin
    g_row.anw_id := v('ANW_ID');
    g_row.anw_apex_alias := v('ANW_APEX_ALIAS');
    g_row.anw_schema := v('ANW_SCHEMA');
    g_row.anw_aar_id := v('ANW_AAR_ID');
    g_row.anw_name := v('ANW_NAME');
    g_row.anw_beschreibung := v('ANW_BESCHREIBUNG');
    g_row.anw_aktiv := v('ANW_AKTIV');
    g_row.anw_sortierung := v('ANW_SORTIERUNG');
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
