
begin
  if '&INSTALL_USER.' != '&APEX_USER.' then
    execute immediate 'revoke &1. on &INSTALL_USER..&2. from &APEX_USER.';
    dbms_output.put_line('&s1.Grant &1. on &2. revoked from &APEX_USER.');
  end if;
exception
  when others then 
    null; -- grant does not exist, silently ignore
end;
/

alter session set current_schema=&APEX_USER.;

begin
  if '&INSTALL_USER.' != '&APEX_USER.' then
    execute immediate 'drop synonym &2.';
    dbms_output.put_line('&s1.Synonym &2. for &INSTALL_USER..&2. at &APEX_USER. dropped');
  end if;
exception
  when others then 
    null; -- synonym does not exist, silently ignore
end;
/

alter session set current_schema=&INSTALL_USER.;