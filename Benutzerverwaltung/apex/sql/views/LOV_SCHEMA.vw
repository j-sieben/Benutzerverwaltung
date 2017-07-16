--------------------------------------------------------
--  DDL for View LOV_SCHEMA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "LOV_SCHEMA" ("D", "R") AS 
  select username d, username r
  from all_users
 where username not in (
       'SYS', 'SYSTEM', 'ANONYMOUS', 'MDSYS', 'XDB', 'XS$NULL', 'OUTLN', 'CTXSYS', 'FLOWS_FILES')
   and username not like 'APEX_0%'
 order by d;

   COMMENT ON TABLE "LOV_SCHEMA"  IS 'LOV-View der View ALL_USERS, Liste aller Schemata der Datenbank, ohne Eintragungen einer Blacklist'
;
