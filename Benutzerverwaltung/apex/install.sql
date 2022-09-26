@init/set_folders apex

prompt &h3.Remove existing installation
@&install_dir.clean_up_install.sql

prompt &h3.Create local views for &INSTALL_USER. tables with object grants
@&script_dir.generate_data_interface.sql

prompt &h3.CREATE VIEWS
@&tool_dir.install_view bv_lov_anrede
@&tool_dir.install_view bv_lov_anwendung
@&tool_dir.install_view bv_lov_anwendung_admin
@&tool_dir.install_view bv_lov_anwendung_art
@&tool_dir.install_view bv_lov_anwendung_rolle
@&tool_dir.install_view bv_lov_apex_anwendung
@&tool_dir.install_view bv_lov_benutzer
@&tool_dir.install_view bv_lov_edit_einfache_rol
@&tool_dir.install_view bv_lov_rolle
@&tool_dir.install_view bv_lov_schema
@&tool_dir.install_view bv_lov_titel
@&tool_dir.install_view bv_ui_admin_aar
@&tool_dir.install_view bv_ui_admin_anr
@&tool_dir.install_view bv_ui_admin_anw
@&tool_dir.install_view bv_ui_admin_arf
@&tool_dir.install_view bv_ui_admin_ben_main
@&tool_dir.install_view bv_ui_admin_ben_rol_main
@&tool_dir.install_view bv_ui_admin_rec
@&tool_dir.install_view bv_ui_admin_rol
@&tool_dir.install_view bv_ui_admin_tit
@&tool_dir.install_view bv_ui_benutzer_main
@&tool_dir.install_view bv_ui_edit_anw
@&tool_dir.install_view bv_ui_edit_anw_rol
@&tool_dir.install_view bv_ui_edit_ben
@&tool_dir.install_view bv_ui_edit_ben_rollen
@&tool_dir.install_view bv_ui_edit_anw_rol
@&tool_dir.install_view bv_ui_edit_komplexe_rol
@&tool_dir.install_view bv_ui_edit_rol

prompt &h3.Create PACKAGES
@&tool_dir.install_package_spec bv_ui

prompt &h3.Create PACKAGE BODIES
@&tool_dir.install_package_body bv_ui

set serveroutput on
prompt &h3.Install APEX application
prompt &s1.Prepare APEX import
@&install_dir.prepare_apex_import.sql

prompt &s1.Install application
@&install_dir.apex/&APEX_VERSION./bv.sql

prompt &h3.Load initial data
@&script_dir.initial_data.sql