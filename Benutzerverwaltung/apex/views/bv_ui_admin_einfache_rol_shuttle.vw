create or replace editionable view  bv_ui_admin_einfache_rol_shuttle as 
  select rro_anw_id,
        substr(sys_connect_by_path(rro_rol_id, ':'), 2) rol_rol_shuttle
   from bv_rolle_rolle rro
   join bv_anwendung anw on rro.rro_anw_id = anw.anw_id
  where connect_by_isleaf = 1
    and anw.anw_aar_id = 'HIERARCHIE_EINFACH'
  start with rro_rol_id = rro_parent_rol_id
connect by nocycle prior rro_rol_id = rro_parent_rol_id and prior rro_anw_id = rro_anw_id
  order siblings by rro_rol_id;

comment on column  bv_ui_admin_einfache_rol_shuttle.rro_anw_id is 'Primaerschluessel, Referenz auf Tabelle BV_ANWENDUNG';
comment on column  bv_ui_admin_einfache_rol_shuttle.rol_rol_shuttle is 'Liste der Rollen, die dieser Anwendung zugeordnet werden. Sortierung entscheidet ueber hierarchische Organisation.';
comment on table  bv_ui_admin_einfache_rol_shuttle  is 'UI-Wrapper der Seite ADMIN_EINFACHE_ROL fuer Tabelle BV_ROLLE_ROLLE. Hierarchische View, DML direkt ueber UI_ADMIN_EINFACHE_ROL_PKG';
