declare
  cursor table_cur is
    select lower(table_name) table_name
      from all_tables
     where owner = '&INSTALL_USER.'
       and table_name like 'BV%';
  cursor column_cur(p_table_name in varchar2) is
    select lower(column_name) column_name, column_id
      from all_tab_cols
     where table_name = upper(p_table_name)
       and column_name not like 'SYS%'
       and owner = '&INSTALL_USER.'
     order by column_id;
  cursor object_cur is
    select object_name
      from all_objects
     where object_type in ('PACKAGE', 'TYPE')
       and owner = '&INSTALL_USER.';
  
  c_view_template varchar2(1000) := q'^create or replace view dl_#VIEW_NAME# as 
select #COLUMN_LIST# 
  from &INSTALL_USER..#VIEW_NAME#^';
  
  l_column_list varchar2(32767);
  l_stmt varchar2(32767);
begin
  for tbl in table_cur loop
    for col in column_cur(tbl.table_name) loop
      if col.column_id > 1 then
        l_column_list := l_column_list || ', ';
      end if;
      l_column_list := l_column_list || col.column_name;
    end loop;
    
    begin
      l_stmt := replace(replace(C_VIEW_TEMPLATE, '#VIEW_NAME#', tbl.table_name), '#COLUMN_LIST#', l_column_list);
      execute immediate l_stmt;
      dbms_output.put_line('&s1.View dl_' || tbl.table_name || ' erstellt');
    exception
      when others then
        dbms_output.put_line('Fehler bei ' || l_stmt || ': ' || substr(sqlerrm, 12));
    end;
    l_column_list := null;
  end loop;
  
  for obj in object_cur loop
    execute immediate 'create or replace synonym ' || obj.object_name || ' for &INSTALL_USER..' || obj.object_name;
  end loop;
end;
/
