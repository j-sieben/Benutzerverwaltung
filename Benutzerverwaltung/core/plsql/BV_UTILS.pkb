create or replace package body bv_utils
as
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
