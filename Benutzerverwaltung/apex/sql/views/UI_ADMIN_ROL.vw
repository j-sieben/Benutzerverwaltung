--------------------------------------------------------
--  DDL for View UI_ADMIN_ROL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE VIEW "UI_ADMIN_ROL" ("ROL_ID", "ROL_ANW_ID", "ROL_NAME", "ROL_BESCHREIBUNG", "ROL_AKTIV", "ROL_SORTIERUNG") AS 
  select rol_id,
       rol_anw_id,
       rol_name,
       rol_beschreibung,
       rol_aktiv,
       rol_sortierung
  from bv_rolle;

   COMMENT ON TABLE "UI_ADMIN_ROL"  IS 'UI-Wrapper der Seite ADMIN_ROL fuer Tabelle BV_ROLLE'
;
