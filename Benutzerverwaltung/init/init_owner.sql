set verify off
set serveroutput on
set echo off
set feedback off
set lines 120
set pages 9999
whenever sqlerror exit
clear screen

set termout off
col apex_user new_val APEX_USER format a30
col default_language new_val DEFAULT_LANGUAGE format a30

select upper('&1.') apex_user, pit.get_default_language default_language
  from dual;

@init/settings.sql

define section="********************************************************************************"
define h1="*** "
define h2="**  "
define h3="*   "
define s1=".    - "
set termout on