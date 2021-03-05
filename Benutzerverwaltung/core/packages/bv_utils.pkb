create or replace package body bv_utils
as
  
  function C_TRUE 
    return flag_type
  as
  begin
    return &C_TRUE.;
  end C_TRUE;
  
    
  function C_FALSE
    return flag_type
  as
  begin
    return &C_FALSE.;
  end C_FALSE;
  
  
  function C_MAX_DATE
    return date
  as
  begin
    return &MAX_DATE.;
  end C_MAX_DATE;
  

  function C_AAR_HIER_EINFACH
    return bv_anwendung_art.aar_id%type
  as
  begin
    return 'HIERARCHIE_EINFACH';
  end C_AAR_HIER_EINFACH;
    
  function C_AAR_HIER_KOMPLEX
    return bv_anwendung_art.aar_id%type
  as
  begin
    return 'HIERARCHIE_KOMPLEX';
  end C_AAR_HIER_KOMPLEX;
  
  
  function harmonize_sql_name(
    p_name in varchar2)
    return varchar2
  as
    l_name ora_name_type;
  begin
    l_name := upper(substr(replace(replace(p_name, '"'), ' ', '_'), 1, 128));
    l_name := dbms_assert.simple_sql_name(l_name);
    return l_name;
  exception
    when dbms_assert.INVALID_SQL_NAME then
      pit.error(
        p_message_name => msg.PIT_PASS_MESSAGE, 
        p_msg_args => msg_args(substr(sqlerrm, 12)),
        p_error_code => 'INVALID_SQL_NAME');
      return p_name;
  end harmonize_sql_name;
  
  
  function to_bool(
    p_value in varchar2)
    return flag_type
  as
    l_result flag_type;
  begin
    if p_value in ('1', 'Y', 'J') then
      l_result := C_TRUE;
    else
      l_result := C_FALSE;
    end if;
    return l_result;
  end to_bool;
  
  
  procedure submit_job(
    p_action in varchar2)
  as
    l_job_id binary_integer;
    pragma autonomous_transaction;
    job_exists exception;
    pragma exception_init(job_exists, -27477);
  begin
    dbms_scheduler.create_job (
      job_name => 'BV_UTILS_JOB',
      job_type => 'PLSQL_BLOCK',
      job_action => p_action,
      enabled => true,
      auto_drop => true,
      comments => 'Run once job');
    commit;
  exception
    when job_exists then
      null;
  end submit_job;


  function string_to_table(
    p_string in varchar2,
    p_delimiter in varchar2 default ':')
    return char_table
    pipelined
  as
    raw_list wwv_flow_global.vc_arr2;
  begin
    raw_list := apex_util.string_to_table(p_string, p_delimiter);
    for l_replacement_count in 1 .. raw_list.count
    loop
      pipe row(raw_list(l_replacement_count));
    end loop;
  end string_to_table;

end bv_utils;
/
