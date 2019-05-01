define sql_dir=core/sql/
define seq_dir=&sql_dir./sequences/
define table_dir=&sql_dir./tables/
define type_dir=&sql_dir./types/
define view_dir=&sql_dir./views/
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

prompt &s1.Create view SCT_BL_PAGE_TARGETS
@&view_dir.sct_bl_page_targets.vw


prompt &h3.Create SCT messages
@core/create_messages.sql


prompt &h3.Create packages
prompt &s1.Create package BV_UTILS
@&plsql_dir.\BV_UTILS.pks
show errors

prompt &s1.Create package UTL_APEX
@&plsql_dir.\UTL_APEX.pks
show errors

prompt &s1.Create package BL_ANW_PKG
@&plsql_dir.\BL_ANW_PKG.pks
show errors

prompt &s1.Create package BL_RECHT_PKG
@&plsql_dir.\BL_RECHT_PKG.pks
show errors

prompt &s1.Create package BV_RECHT_PKG
@&plsql_dir.\BV_RECHT_PKG.pks
show errors

prompt &s1.Create package body BV_UTILS
@&plsql_dir.\BV_UTILS.pkb
show errors

prompt &s1.Create package body UTL_APEX
@&plsql_dir.\UTL_APEX.pkb
show errors

prompt &s1.Create package body BL_ANW_PKG
@&plsql_dir.\BL_ANW_PKG.pkb
show errors

prompt &s1.Create package body BL_RECHT_PKG
@&plsql_dir.\BL_RECHT_PKG.pkb
show errors

prompt &s1.Create package body BV_RECHT_PKG
@&plsql_dir.\BV_RECHT_PKG.pkb
show errors

prompt &h3.Create base action types
@core/merge_base_action_types.sql
