-- 1: Provilege to grant
-- 2: Object to grant a privilege to
-- Will only be executed if INSTALL_USER is not APEX_USER
begin
  if '&INSTALL_USER.' != '&APEX_USER.' then
    dbms_output.put_line('&s1.Granting &1. on &2. to &APEX_USER.');
    execute immediate 'grant &1. on &INSTALL_USER..&2. to &APEX_USER.';
  end if;
exception
  when others then
    dbms_output.put_line('&s1.Object &2. does not exist.');
end;
/

alter session set current_schema=&APEX_USER.;

begin
  if '&INSTALL_USER.' != '&APEX_USER.' then
    dbms_output.put_line('&s1.Create synonym &2. for &INSTALL_USER..&2. at &APEX_USER.');
    execute immediate 'create or replace synonym &2. for &INSTALL_USER..&2.';
  end if;
end;
/

alter session set current_schema=&INSTALL_USER.;