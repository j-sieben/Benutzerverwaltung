set verify off
set echo off
set feedback off
set lines 120
set pages 9999
set serveroutput on size unlimited
whenever sqlerror exit
clear screen

col install_user new_val INSTALL_USER format a10
col apex_ws new_val APEX_WS format a10
col apex_alias new_val APEX_ALIAS format a10
col app_id new_val APP_ID format a10

select upper('&1.') install_user, 
       upper('&2.') apex_ws, 
       upper('&3.') apex_alias, 
       '&4.' app_id
  from dual;

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "
