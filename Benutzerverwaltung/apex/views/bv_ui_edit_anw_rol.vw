create or replace editionable view  bv_ui_edit_anw_rol as 
 select rro_anw_id anw_id,
        substr(sys_connect_by_path(rro_rol_id, ':'), 2) rol_rol_list
   from dl_bv_rolle_rolle rro
   join dl_bv_anwendung anw
     on rro.rro_anw_id = anw.anw_id
  where connect_by_isleaf = 1
    and anw.anw_aar_id = 'HIERARCHIE_EINFACH'
  start with rro_rol_id = rro_parent_rol_id
connect by nocycle prior rro_rol_id = rro_parent_rol_id and prior rro_anw_id = rro_anw_id
  order siblings by rro_rol_id;

comment on column  bv_ui_edit_anw_rol.anw_id is 'Primaerschluessel, Referenz auf Tabelle BV_ANWENDUNG';
comment on column  bv_ui_edit_anw_rol.rol_rol_list is 'Liste der Rollen, die dieser Anwendung zugeordnet werden. Sortierung entscheidet ueber hierarchische Organisation.';
comment on table  bv_ui_edit_anw_rol  is 'UI-Wrapper der Seite EDIT_EINFACHE_ROL fuer Tabelle BV_ROLLE_ROLLE. Hierarchische View, DML direkt ueber UI_ADMIN_EINFACHE_ROL_PKG';
