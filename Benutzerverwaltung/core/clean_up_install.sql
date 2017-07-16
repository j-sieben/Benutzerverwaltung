declare
  object_does_not_exist exception;
  pragma exception_init(object_does_not_exist, -4043);
  table_does_not_exist exception;
  pragma exception_init(table_does_not_exist, -942);
  sequence_does_not_exist exception;
  pragma exception_init(sequence_does_not_exist, -2289);
  synonym_does_not_exist exception;
  pragma exception_init(synonym_does_not_exist, -1434);
  cursor delete_object_cur is
          select object_name name, object_type type
            from all_objects
           where (object_name in (
                 '', -- Typen
                 'SCT_ADMIN', 'SCT_CONST', -- Packages
                 'SCT_BL_RULES', 'SCT_BL_PAGE_TARGETS', -- Views
                 'SCT_RULE_ACTION', 'SCT_RULE', 'SCT_PAGE_ITEM', 'SCT_PAGE_ITEM_TYPE', 
                 'SCT_ACTION_TYPE', 'SCT_RULE_GROUP',   -- Tabellen
                 '',  -- Synonyme
                 'SCT_SEQ' -- Sequenzen
                 )
                 or object_name like 'SCT_RULES_GROUP%')
             and object_type not like '%BODY'
             and owner = upper('&INSTALL_USER.')
           order by object_type, object_name;
  cursor message_cur is
    select pms_name, pms_pml_name
      from pit_message
     where pms_name like 'SCT%'
       and pms_id is not null;
begin
  for obj in delete_object_cur loop
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
  
  for msg in message_cur loop
    pit_admin.remove_message(msg.pms_name, msg.pms_pml_name);
    dbms_output.put_line('&s1.Message ' || msg.pms_name || ' deleted.');
  end loop;
  commit;
  dbms_session.reset_package;
  pit_admin.create_message_package;
end;
/