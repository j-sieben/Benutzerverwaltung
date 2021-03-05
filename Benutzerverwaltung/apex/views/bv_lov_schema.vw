create or replace editionable view bv_lov_schema as 
select username d, username r
  from all_users
 where username not in (
       'SYS', 'SYSTEM', 'ANONYMOUS', 'MDSYS', 'XDB', 'XS$NULL', 'OUTLN', 'CTXSYS', 'FLOWS_FILES')
   and username not like 'APEX_0%'
   and oracle_maintained = 'N'
 order by d;

comment on table bv_lov_schema  is 'LOV-View der View ALL_USERS, Liste aller Schemata der Datenbank, ohne Eintragungen einer Blacklist';
