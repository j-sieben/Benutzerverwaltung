declare
  object_does_not_exist exception;
  pragma exception_init(object_does_not_exist, -4043);
  table_does_not_exist exception;
  pragma exception_init(table_does_not_exist, -942);
  sequence_does_not_exist exception;
  pragma exception_init(sequence_does_not_exist, -2289);
  synonym_does_not_exist exception;
  pragma exception_init(synonym_does_not_exist, -1434);
  cursor loesche_object_cur is
          select object_name name, object_type type
            from user_objects
           where object_name in (
                 '', -- Typen
                 'BV_RECHT', 'BL_RECHT', 'BL_ANW', 'BL_BEN', 'BV_RECHT_PKG', 'BV_UTILS', -- Packages
                 'BV_BV_BENUTZER', 'BV_BV_BENUTZER_RECHTE', 
                 'BV_BV_BENUTZER_ROLLE', 'BV_BV_RECHT', 'BV_BV_ROLLE', -- Views
                 'BV_ANREDE', 'BV_ANWENDUNG', 'BV_ANWENDUNG_ART',
                 'BV_ANWENDUNG_REFERENZ', 'BV_BENUTZER',
                 'BV_BENUTZER_RECHT', 'BV_BENUTZER_RECHTE', 'BV_BENUTZER_ROLLE',
                 'BV_RECHT', 'BV_ROLLE', 'BV_ROLLE_RECHT', 'BV_ROLLE_ROLLE', 'BV_TITEL', -- Tabellen
                 '',  -- Synonyme
                 'BV_SEQ', -- Sequenzen
                 'BV_BENUTZER_RECHTE' -- Materialized View
                 )
             and object_type not like '%BODY'
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