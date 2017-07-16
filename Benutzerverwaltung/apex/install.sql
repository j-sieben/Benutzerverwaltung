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
prompt &s1.Create view LOV_ANWENDUNG
@&view_dir.LOV_ANWENDUNG.vw

prompt &s1.Create view LOV_ANWENDUNG_ADMIN
@&view_dir.LOV_ANWENDUNG_ADMIN.vw

prompt &s1.Create view LOV_ANWENDUNG_ROLLE
@&view_dir.LOV_ANWENDUNG_ROLLE.vw

prompt &s1.Create view LOV_BENUTZER
@&view_dir.LOV_BENUTZER.vw

prompt &s1.Create view LOV_ROLLE
@&view_dir.LOV_ROLLE.vw

prompt &s1.Create view LOV_SCHEMA
@&view_dir.LOV_SCHEMA.vw

prompt &s1.Create view UI_ADMIN_AAR
@&view_dir.UI_ADMIN_AAR.vw

prompt &s1.Create view UI_ADMIN_ANR
@&view_dir.UI_ADMIN_ANR.vw

prompt &s1.Create view UI_ADMIN_ANW
@&view_dir.UI_ADMIN_ANW.vw

prompt &s1.Create view UI_ADMIN_ARF
@&view_dir.UI_ADMIN_ARF.vw

prompt &s1.Create view UI_ADMIN_BEN_DETAIL
@&view_dir.UI_ADMIN_BEN_DETAIL.vw

prompt &s1.Create view UI_ADMIN_BEN_MAIN
@&view_dir.UI_ADMIN_BEN_MAIN.vw

prompt &s1.Create view UI_ADMIN_BEN_ROL_MAIN
@&view_dir.UI_ADMIN_BEN_ROL_MAIN.vw

prompt &s1.Create view UI_ADMIN_EINFACHE_ROL_SHUTTLE
@&view_dir.UI_ADMIN_EINFACHE_ROL_SHUTTLE.vw

prompt &s1.Create view UI_ADMIN_KOMPLEXE_ROL_MAIN
@&view_dir.UI_ADMIN_KOMPLEXE_ROL_MAIN.vw

prompt &s1.Create view UI_ADMIN_REC
@&view_dir.UI_ADMIN_REC.vw

prompt &s1.Create view UI_ADMIN_ROL
@&view_dir.UI_ADMIN_ROL.vw

prompt &s1.Create view UI_ADMIN_TIT
@&view_dir.UI_ADMIN_TIT.vw

prompt &s1.Create view UI_BENUTZER_MAIN
@&view_dir.UI_BENUTZER_MAIN.vw

prompt &h3.Create PACKAGES
prompt &s1.Create package UI_ADMIN_ANW_PKG
@&plsql_dir.UI_ADMIN_ANW_PKG.pks
show errors

prompt &s1.Create package UI_ADMIN_ARF_PKG
@&plsql_dir.UI_ADMIN_ARF_PKG.pks
show errors

prompt &s1.Create package UI_ADMIN_BEN_PKG
@&plsql_dir.UI_ADMIN_BEN_PKG.pks
show errors

prompt &s1.Create package UI_ADMIN_ROL_PKG
@&plsql_dir.UI_ADMIN_ROL_PKG.pks
show errors

prompt &s1.Create package Body UI_ADMIN_ANW_PKG
@&plsql_dir.UI_ADMIN_ANW_PKG.pkb
show errors

prompt &s1.Create package Body UI_ADMIN_ARF_PKG
@&plsql_dir.UI_ADMIN_ARF_PKG.pkb
show errors

prompt &s1.Create package Body UI_ADMIN_BEN_PKG
@&plsql_dir.UI_ADMIN_BEN_PKG.pkb
show errors

prompt &s1.Create package Body UI_ADMIN_ROL_PKG
@&plsql_dir.UI_ADMIN_ROL_PKG.pkb
show errors


set serveroutput on
prompt &h3.Install APEX application
prompt &s1.Prepare APEX import
@&apex_dir.prepare_apex_import.sql

prompt &s1.Install application
@&apex_dir.sct.sql

-- After APEX installation, reset output settings
set define on
set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit
alter session set current_schema=&INSTALL_USER.;

prompt &h3.Recompiling SCT_ADMIN to prepare SCT rules import
alter package sct_admin compile package;

prompt &s1.Import SCT rules
@&apex_dir.merge_rule_sct_admin_export_rule.sql
@&apex_dir.merge_rule_sct_admin_main.sql
@&apex_dir.merge_rule_sct_copy_rulegroup.sql