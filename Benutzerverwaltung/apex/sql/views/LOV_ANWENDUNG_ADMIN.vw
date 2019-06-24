CREATE OR REPLACE EDITIONABLE VIEW "LOV_ANWENDUNG_ADMIN" ("D", "R") AS 
select anw_name d, anw_id r
  from bv_anwendung anw
  join table(bl_recht_pkg.get_admin_anw(v('APP_USER'), '&APEX_ALIAS.')) rec
    on anw.anw_id = rec.column_value
 where anw.anw_aktiv = 'Y'
 order by anw_name;

COMMENT ON COLUMN "LOV_ANWENDUNG_ADMIN"."D" IS 'Display-Wert des LOV';
COMMENT ON COLUMN "LOV_ANWENDUNG_ADMIN"."R" IS 'Return-Wert des LOV';
COMMENT ON TABLE "LOV_ANWENDUNG_ADMIN"  IS 'LOV-View aller Anwendungen, die durch den aktuell angemeldeten Benutzer administriert werden duerfen';
