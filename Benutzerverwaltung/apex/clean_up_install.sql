declare
  object_does_not_exist exception;
  pragma exception_init(object_does_not_exist, -4043);
  table_does_not_exist exception;
  pragma exception_init(table_does_not_exist, -942);
  sequence_does_not_exist exception;
  pragma exception_init(sequence_does_not_exist, -2282);
  synonym_does_not_exist exception;
  pragma exception_init(synonym_does_not_exist, -1434);
  cursor loesche_object_cur is
          select object_name name, object_type type
            from all_objects
           where object_name in (
                 '', -- Typen
                 'BV_UI_ADMIN_ANW', 'BV_UI_ADMIN_ARF', 'BV_UI_ADMIN_BEN', 'BV_UI_ADMIN_ROL', -- Packages
                 'BV_LOV_ANREDE', 'BV_LOV_ANWENDUNG', 'BV_LOV_ANWENDUNG_ART', 'BV_LOV_ANWENDUNG_ADMIN', 'BV_LOV_ANWENDUNG_ROLLE', 'BV_LOV_BENUTZER',
                 'BV_LOV_ROLLE', 'BV_LOV_SCHEMA', 'BV_LOV_TITEL', 'BV_UI_ADMIN_AAR', 'BV_UI_ADMIN_ANR',
                 'BV_UI_ADMIN_ANW', 'BV_UI_ADMIN_ARF', 'BV_UI_EDIT_BEN', 'BV_UI_EDIT_BEN_ROLLEN', 'BV_UI_ADMIN_BEN_MAIN',
                 'BV_UI_ADMIN_BEN_ROL_MAIN', 'BV_UI_ADMIN_EINFACHE_ROL_SHUTTLE', 'BV_UI_ADMIN_KOMPLEXE_ROL_MAIN',
                 'BV_UI_ADMIN_REC', 'BV_UI_ADMIN_ROL', 'BV_UI_ADMIN_TIT', 'BV_UI_BENUTZER_MAIN',-- Views
                 '',   -- Tabellen
                 '',  -- Synonyme
                 '' -- Sequenzen
                 )
             and object_type not like '%BODY'
             and owner = upper('&INSTALL_USER.')
           order by object_type, object_name;
begin
  for obj in loesche_object_cur loop
    begin
      execute immediate 'drop ' || obj.type || ' ' || obj.name ||
                        case obj.type 
                        when 'TYPE' then ' force' 
                        when 'TABLE' then ' cascade constraints' 
                        end;
     dbms_output.put_line('&s1.' || initcap(obj.type) || ' ' || obj.name || ' deleted.');
    
    exception
      when object_does_not_exist or table_does_not_exist or sequence_does_not_exist or synonym_does_not_exist then
        dbms_output.put_line('&s1.' || obj.type || ' ' || obj.name || ' does not exist.');
      when others then
        raise;
    end;
  end loop;
  
end;
/


prompt &h3.Checking whether app still exists.

declare
  l_app_id number;
  l_ws number;
  c_app_alias constant varchar2(30 byte) := 'SCT_ADMIN';  
begin
  select application_id, workspace_id
    into l_app_id, l_ws
    from apex_applications
   where alias = c_app_alias
     and owner = '&INSTALL_USER.';
   
  dbms_output.put_line('&s1.Remove existing application ' || c_app_alias);
  wwv_flow_api.set_security_group_id(l_ws);
  wwv_flow_api.remove_flow(l_app_id);
exception
  when others then
    dbms_output.put_line('&s1.Application ' || c_app_alias || ' does not exist');
end;
 /