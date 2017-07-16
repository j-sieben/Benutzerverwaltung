--------------------------------------------------------
--  DDL for View UI_ADMIN_EINFACHE_ROL_SHUTTLE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "UI_ADMIN_EINFACHE_ROL_SHUTTLE" ("RRO_ANW_ID", "ROL_ROL_SHUTTLE") AS 
  select rro_anw_id,
        substr(sys_connect_by_path(rro_rol_id, ':'), 2) rol_rol_shuttle
   from bv_rolle_rolle rro
   join bv_anwendung anw on rro.rro_anw_id = anw.anw_id
  where connect_by_isleaf = 1
    and anw.anw_aar_id = 'HIERARCHIE_EINFACH'
  start with rro_rol_id = rro_parent_rol_id
connect by nocycle prior rro_rol_id = rro_parent_rol_id and prior rro_anw_id = rro_anw_id
  order siblings by rro_rol_id;

   COMMENT ON COLUMN "UI_ADMIN_EINFACHE_ROL_SHUTTLE"."RRO_ANW_ID" IS 'Primaerschluessel, Referenz auf Tabelle BV_ANWENDUNG';
   COMMENT ON COLUMN "UI_ADMIN_EINFACHE_ROL_SHUTTLE"."ROL_ROL_SHUTTLE" IS 'Liste der Rollen, die dieser Anwendung zugeordnet werden. Sortierung entscheidet ueber hierarchische Organisation.';
   COMMENT ON TABLE "UI_ADMIN_EINFACHE_ROL_SHUTTLE"  IS 'UI-Wrapper der Seite ADMIN_EINFACHE_ROL fuer Tabelle BV_ROLLE_ROLLE. Hierarchische View, DML direkt ueber UI_ADMIN_EINFACHE_ROL_PKG'
;
