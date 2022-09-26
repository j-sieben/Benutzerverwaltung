
begin
    execute immediate 'grant &1. on &2. to &APEX_USER.';
    dbms_output.put_line('&s1.Object privilege &1. on &2. granted.');
end;
/