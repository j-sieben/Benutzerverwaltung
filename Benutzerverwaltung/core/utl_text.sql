--@init.sql

alter session set current_schema=&INSTALL_USER.;

begin
  execute immediate 'create or replace type char_table as table of varchar2(4000)';
exception
  when others then 
    dbms_output.put_line('&s1.CHAR_TABLE exists already.');
end;
/
show errors

create or replace package utl_text
  authid definer
as
  function clob_to_blob(
    p_clob in clob)
    return blob;
    
  procedure download_blob(
    p_blob in out nocopy blob,
    p_file_name in varchar2);
    
  procedure download_clob(
    p_clob in clob,
    p_file_name in varchar2);
    
  function not_empty(
    p_text in varchar2)
    return boolean;

  function append(
    p_text in varchar2,
    p_chunk in varchar2,
    p_delimiter in varchar2 default null,
    p_before in varchar2 default 'N')
    return varchar2;

  procedure append(
    p_text in out nocopy varchar2,
    p_chunk in varchar2,
    p_delimiter in varchar2 default null,
    p_before in varchar2 default 'N');

  function concatenate(
    p_chunks in char_table,
    p_delimiter in varchar2 default ':',
    p_ignore_nulls in boolean default true)
    return varchar2;

  procedure concatenate(
    p_text in out nocopy varchar2,
    p_chunks in char_table,
    p_delimiter in varchar2 default ':',
    p_ignore_nulls in boolean default true);


  procedure bulk_replace(
    p_text in out nocopy varchar2,
    p_chunks in char_table);

  function bulk_replace(
    p_text in varchar2,
    p_chunks in char_table)
    return varchar2;

  function string_to_table(
    p_string in varchar2,
    p_delimiter in varchar2 default ':')
    return char_table
    pipelined;
    
  function contains(
    p_string in varchar2,
    p_pattern in varchar2,
    p_delimiter in varchar2 default ',')
    return number;
    
  procedure merge(
    p_string in out nocopy varchar2,
    p_pattern in varchar2,
    p_delimiter in varchar2 default ',');
    
  function merge(
    p_string in varchar2,
    p_pattern in varchar2,
    p_delimiter in varchar2 default ',')
    return varchar2;

end utl_text;
/
show errors

create or replace package body utl_text
as
  function clob_to_blob(
    p_clob in clob)
    return blob
  as
    l_blob blob;
    l_lang_context  integer := dbms_lob.DEFAULT_LANG_CTX;
    l_warning       integer := dbms_lob.WARN_INCONVERTIBLE_CHAR;
    l_dest_offset   integer := 1;
    l_source_offset integer := 1;
  begin    
    dbms_lob.createtemporary(l_blob, true, dbms_lob.call);
      dbms_lob.converttoblob (
        dest_lob => l_blob,
        src_clob => p_clob,
        amount => dbms_lob.LOBMAXSIZE,
        dest_offset => l_dest_offset,
        src_offset => l_source_offset,
        blob_csid => dbms_lob.DEFAULT_CSID,
        lang_context => l_lang_context,
        warning => l_warning
      );
      
    return l_blob;
  end clob_to_blob;
  

  procedure download_blob(
    p_blob in out nocopy blob,
    p_file_name in varchar2)
  as
  begin
    htp.init;
    owa_util.mime_header('application/octet-stream', FALSE, 'UTF-8');
    htp.p('Content-length: ' || dbms_lob.getlength(p_blob));
    htp.p('Content-Disposition: inline; filename="' || p_file_name || '"');
    owa_util.http_header_close;
    wpg_docload.download_file(p_blob);
    apex_application.stop_apex_engine;
  exception when others then
    htp.p('error: ' || sqlerrm);
    apex_application.stop_apex_engine;
  end download_blob;


  procedure download_clob(
    p_clob in clob,
    p_file_name in varchar2)
  as
    l_blob blob;
  begin
    l_blob := clob_to_blob(p_clob);
    download_blob(l_blob, p_file_name);

  end download_clob;
  
  
  function not_empty(
    p_text in varchar2)
    return boolean
  as
  begin
    return length(trim(p_text)) > 0;
  end not_empty;


  function append(
    p_text in varchar2,
    p_chunk in varchar2,
    p_delimiter in varchar2 default null,
    p_before in varchar2 default 'N')
    return varchar2
  as
    l_result varchar2(32767);
  begin
    if not_empty(p_chunk) then
      if p_before = 'Y' then
        l_result := p_text || case when p_text is not null then p_delimiter end || p_chunk;
      else
        l_result := p_text || p_chunk || p_delimiter;
      end if;
    end if;
    return l_result;
  end append;


  procedure append(
    p_text in out nocopy varchar2,
    p_chunk in varchar2,
    p_delimiter in varchar2 default null,
    p_before in varchar2 default 'N')
  as
  begin
    p_text := append(p_text, p_chunk, p_delimiter, p_before);
  end append;


  function concatenate(
    p_chunks in char_table,
    p_delimiter in varchar2 default ':',
    p_ignore_nulls in boolean default true)
    return varchar2
  as
    l_result varchar2(32767);
  begin
    for i in p_chunks.first .. p_chunks.last loop
      if (not_empty(p_chunks(i)) and p_ignore_nulls) or (not(p_ignore_nulls)) then
        append(
          p_text => l_result,
          p_chunk => p_chunks(i),
          p_delimiter => p_delimiter
        );
      end if;
    end loop;
    return trim(p_delimiter from l_result);
  end concatenate;


  procedure concatenate(
    p_text in out nocopy varchar2,
    p_chunks in char_table,
    p_delimiter in varchar2 default ':',
    p_ignore_nulls in boolean default true)
  as
  begin
    p_text := concatenate(p_chunks, p_delimiter, p_ignore_nulls);
  end concatenate;


  procedure bulk_replace(
    p_text in out nocopy varchar2,
    p_chunks in char_table)
  as
  begin
    for i in p_chunks.first .. p_chunks.last loop
      if mod(i, 2) = 1 then
        p_text := replace(p_text, p_chunks(i), p_chunks(i+1));
      end if;
    end loop;
  end bulk_replace;


  function bulk_replace(
    p_text in varchar2,
    p_chunks in char_table)
    return varchar2
  as
    l_result varchar2(32767);
  begin
    l_result := p_text;
    bulk_replace(l_result, p_chunks);
    return l_result;
  end bulk_replace;


  function string_to_table(
    p_string in varchar2,
    p_delimiter in varchar2 default ':')
    return char_table
    pipelined
  as
    l_chunk varchar2(32767);
    l_delimiter varchar2(30);
  begin
    l_delimiter := '\' || p_delimiter;
    for i in 1 .. regexp_count(p_string, l_delimiter) + 1 loop
      l_chunk := regexp_substr(p_string, '[^' || l_delimiter || ']+', 1, i);
      pipe row (l_chunk);
    end loop;
    return;
  end string_to_table;
  
  
  function contains(
    p_string in varchar2,
    p_pattern in varchar2,
    p_delimiter in varchar2 default ',')
    return number
  as
    l_result number := 0;
  begin
    if instr(p_delimiter || p_string || p_delimiter, p_delimiter || p_pattern || p_delimiter) > 0 then
      l_result := 1;
    end if;
    return l_result;
  end contains;
  
  
  procedure merge(
    p_string in out nocopy varchar2,
    p_pattern in varchar2,
    p_delimiter in varchar2 default ',')
  as
  begin
    p_string := utl_text.merge(p_string, p_pattern, p_delimiter);
  end merge;
  
    
  function merge(
    p_string in varchar2,
    p_pattern in varchar2,
    p_delimiter in varchar2 default ',')
    return varchar2
  as
    l_result varchar2(32767);
    l_chunk varchar2(32767);
  begin
    l_result := p_string;
    if p_pattern is not null then
      for i in 1 .. regexp_count(p_pattern, '\' || p_delimiter) + 1 loop
        l_chunk := regexp_substr(p_pattern, '[^\' || p_delimiter || ']+', 1, i);
        l_result := trim(p_delimiter from replace(p_delimiter || l_result, p_delimiter || l_chunk) || p_delimiter || l_chunk);
      end loop;
    end if;
    return l_result;
  end merge;

end utl_text;
/

show errors
