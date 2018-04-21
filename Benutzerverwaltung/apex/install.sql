define sql_dir=apex/sql/
define seq_dir=&sql_dir.sequences/
define table_dir=&sql_dir.tables/
define type_dir=&sql_dir.types/
define view_dir=&sql_dir.views/
define plsql_dir=apex/plsql/
define apex_dir=apex/apex/


prompt &h3.Check installation prerquisites
@apex/check_prerequisites.sql

prompt &h3.Remove existing installation
@apex/clean_up_install.sql

prompt &h3.Setting compile flags
@apex/set_compile_flags.sql

prompt &h3.CREATE SEQUENCES

prompt &h3.CREATE TABLES

prompt &h3.CREATE VIEWS
@&view_dir.install_views.sql

prompt &h3.Create PACKAGES
@&plsql_dir.install_packages.sql


prompt &h3.Load initial data
@apex/initial_data.sql

set serveroutput on
prompt &h3.Install APEX application
prompt &s1.Prepare APEX import
@apex/prepare_apex_import.sql

prompt &s1.Install application
@&apex_dir.bv.sql