@init/set_folders core

prompt &h3.Check installation prerequisites
@&install_dir.check_prerequisites.sql

prompt &h3.Remove existing installation
@&install_dir.clean_up_install.sql

prompt &h3.Create messages
@&msg_dir.MessageGroup_BV.sql

prompt &h3.Create sequences
@&tool_dir.check_has_sequence bv_seq

prompt &h3.Install Tables
@&tool_dir.check_has_table bv_anrede
@&tool_dir.check_has_table bv_titel
@&tool_dir.check_has_table bv_anwendung_art
@&tool_dir.check_has_table bv_anwendung
@&tool_dir.check_has_table bv_anwendung_referenz
@&tool_dir.check_has_table bv_benutzer
@&tool_dir.check_has_table bv_recht
@&tool_dir.check_has_table bv_rolle
@&tool_dir.check_has_table bv_rolle_rolle
@&tool_dir.check_has_table bv_rolle_recht
@&tool_dir.check_has_table bv_benutzer_recht
@&tool_dir.check_has_table bv_benutzer_rolle

prompt &h3.Install Materialized Views
@&mv_dir.bv_benutzer_rechte.mv

prompt &h3.Install Views
@&tool_dir.install_view bv_bv_benutzer_rechte
@&tool_dir.install_view bv_bv_benutzer_rolle
@&tool_dir.install_view bv_bv_benutzer
@&tool_dir.install_view bv_bv_recht
@&tool_dir.install_view bv_bv_rolle

prompt &h3.Create package specifications
@&tool_dir.install_package_spec bv_utils
@&tool_dir.install_package_spec bl_anw
@&tool_dir.install_package_spec bl_ben
@&tool_dir.install_package_spec bl_recht
@&tool_dir.install_package_spec bv_recht_pkg

prompt &h3.Create package bodies
@&tool_dir.install_package_body bv_utils
@&tool_dir.install_package_body bl_anw
@&tool_dir.install_package_body bl_ben
@&tool_dir.install_package_body bl_recht
@&tool_dir.install_package_body bv_recht_pkg

prompt &h3.Load initial data
@&script_dir.initial_data.sql

prompt &h3. Grant privileges to &APEX_USER.
@&script_dir.grant_object_privileges.sql