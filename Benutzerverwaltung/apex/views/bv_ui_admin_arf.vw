create or replace editionable view  bv_ui_admin_arf as 
select arf_anw_id,
       listagg(arf_referenz_anw_id, ':') within group (order by arf_anw_id) arf_anw_id_list
  from bv_anwendung_referenz
 where arf_referenz_anw_id != arf_anw_id
 group by arf_anw_id;

comment on column  bv_ui_admin_arf.arf_anw_id is 'Primaerschluessel, Referenz auf BV_ANWENDUNG, Anwendung, die eine Referenz auf andere Anwendungen hat';
comment on column  bv_ui_admin_arf.arf_anw_id_list is ':-separierte Liste der Anwendungen, die durch ARF_ANW_ID referenziert werden. Gruppierung.';
comment on table  bv_ui_admin_arf  is 'UI-Wrapper der Seite ADMIN_ARF fuer Tabelle BV_ANWENDUNG_REFERENZ. Aggregierende View, DML direkt ueber UI_ADMIN_ARF_PKG.';
