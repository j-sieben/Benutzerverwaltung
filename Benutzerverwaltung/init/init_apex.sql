set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit

set termout off
col sys_user new_val SYS_USER format a30
col install_user new_val INSTALL_USER format a30
col apex_user new_val APEX_USER format a30
col apex_ws new_val APEX_WS format a30
col app_alias new_val APP_ALIAS format a30
col app_id new_val APP_ID format a30
col apex_version new_val APEX_VERSION format a30
col default_language new_val DEFAULT_LANGUAGE format a30


select upper('&1.') install_user, pit.get_default_language default_language
  from dual;

select '20_2' apex_version
  from dual;
   
select workspace apex_ws, 
       upper('&3.') app_alias, 
       '&4.' app_id
  from apex_workspaces
 where workspace = upper('&2.');
 
define APEX_DIR=&INSTALL_DIR.apex/&APEX_VERSION./
 

@init/settings.sql

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "
set termout on