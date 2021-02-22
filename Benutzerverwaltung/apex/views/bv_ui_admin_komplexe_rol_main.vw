create or replace editionable view bv_ui_admin_komplexe_rol_main as 
  select rro_anw_id,
       rro_parent_rol_id,
       listagg(rro_rol_id, ':') within group (order by rro_rol_id) rro_child_rol_id
  from bv_rolle_rolle
 group by rro_anw_id, rro_parent_rol_id;

comment on column bv_ui_admin_komplexe_rol_main.rro_anw_id is 'Primaerschluessel, Referenz auf BV_ROLLE';
comment on column bv_ui_admin_komplexe_rol_main.rro_parent_rol_id is 'Primaerschluessel, Referenz auf BV_ROLLE';
comment on column bv_ui_admin_komplexe_rol_main.rro_child_rol_id is ':-separierte Liste der Rollen, die in RRO_ANW_ID direkt inkludiert sind. Gruppierung.';
comment on table bv_ui_admin_komplexe_rol_main  is 'UI-Wrapper der Seite ADMIN_KOMPLEXE_ROL fuer Tabelle BV_ROLLE_ROLLE, Aggregierende View, DML direkt ueber UI_ADMIN_KOMPLEXE_ROL_PKG';
