define sql_dir=core/sql/
define seq_dir=&sql_dir./sequences/
define table_dir=&sql_dir./tables/
define type_dir=&sql_dir./types/
define view_dir=&sql_dir./views/
define mv_dir=&sql_dir./materialized_view/
define plsql_dir=core/plsql/

prompt &h3.Check installation prerequisites
@core/check_prerequisites.sql

prompt &h3.Remove existing installation
@core/clean_up_install.sql

prompt &h3.Setting compile flags
@core/set_compile_flags.sql


prompt &h3.Create sequences
prompt &s1.Create sequence BV_SEQ
@&seq_dir.bv_seq.seq

prompt &h3.Create tables and initial data
prompt &s1.Create table SCT_RULE_GROUP
@&table_dir.sct_rule_group.tbl

prompt &s1.Create table SCT_ACTION_TYPE
@&table_dir.sct_action_type.tbl

prompt &s1.Create table SCT_PAGE_ITEM_TYPE
@&table_dir.sct_page_item_type.tbl

prompt &s1.Create table SCT_PAGE_ITEM
@&table_dir.sct_page_item.tbl

prompt &s1.Create table SCT_RULE
@&table_dir.sct_rule.tbl

prompt &s1.Create table SCT_RULE_ACTION
@&table_dir.sct_rule_action.tbl


prompt &s1.Create view SCT_BL_RULES
@&view_dir.sct_bl_rules.vw

prompt &h3.Install Tables
@&table_dir.install_tables.sql

prompt &h3.Install Materialized Views
@&mv_dir.bv_benutzer_rechte.mv

prompt &h3.Install Views
@&view_dir.install_views.sql

prompt &h3.Setting compile flags
@core/set_compile_flags.sql

prompt &h3.Create packages
@&plsql_dir.install_packages.sql

prompt &h3.Load initial data
@core/initial_data.sql