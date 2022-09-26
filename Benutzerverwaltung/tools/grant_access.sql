-- 1: Provilege to grant
-- 2: Object to grant a privilege to
-- Will only be executed if INSTALL_USER is not APEX_USER
begin
  if user != '&APEX_USER.' then
    dbms_output.put_line('&s1.Granting &1. on &2. to &APEX_USER.');
    execute immediate 'grant &1. on &2. to &APEX_USER.';
  end if;
exception
  when others then
    dbms_output.put_line('&s1.Object &2. does not exist.');
end;
/
