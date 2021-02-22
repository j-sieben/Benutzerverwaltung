declare
  cursor missing_object_cur is  
    select object_name, count(*)
      from all_objects
     where object_type in ('PACKAGE', 'SYNONYM')
       and object_name in ('UTL_APEX', 'UTL_TEXT')
     group by object_name
    having count(*) = 0;
  l_msg varchar2(200) := '&s1.Installation prerequisites checked succesfully.';
  l_has_errors boolean := false;
begin
  for obj in missing_object_cur loop 
    l_has_errors := true;
    l_msg := 'Installation of ' || obj.object_name || ' is required to install BV. It is available on GitHub.';
    dbms_output.put_line(l_msg);
  end loop;
  if l_has_errors then
    raise_application_error(-20000, 'Required objects missing, installation aborted.');
  end if;
  dbms_output.put_line(l_msg);
end;
/
