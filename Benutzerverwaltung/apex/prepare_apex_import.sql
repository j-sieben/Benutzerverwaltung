alter session set current_schema=sys;

declare
  l_workspace_id number;
begin
  select workspace_id 
    into l_workspace_id
    from apex_workspaces
   where workspace = upper('&APEX_WS.');
    
  --apex_application_install.generate_application_id;
  apex_application_install.set_application_id(&APP_ID.);
  apex_application_install.set_application_alias('&APP_ALIAS.');
  apex_application_install.set_workspace_id(l_workspace_id);
  
  dbms_output.put_line('&s1.Workspace: ' || l_workspace_id);
exception 
  when no_data_found then 
    dbms_output.put_line('No workspace found named &APEX_WS.');
    raise;
end;
/