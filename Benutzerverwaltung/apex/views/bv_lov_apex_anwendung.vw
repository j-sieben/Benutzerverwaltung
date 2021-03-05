create or replace editionable view bv_lov_apex_anwendung as 
select application_name || ' (' || alias || ')' d, alias r
  from apex_applications
  left join dl_bv_anwendung
    on alias = anw_id
 where alias is not null
   and anw_id is null  -- AntiJoin, zeigt nur Anwendungen mit Alias, die noch nicht in der BV hinterlegt sind
 order by application_name;

comment on table bv_lov_apex_anwendung  is 'LOV-View aller verfügbarer APEX-Anwendungen des Workspaces';
comment on column bv_lov_apex_anwendung.d is 'Display-Wert des LOV';
comment on column bv_lov_apex_anwendung.r is 'Return-Wert des LOV';