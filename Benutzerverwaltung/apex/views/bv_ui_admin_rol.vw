create or replace editionable view  bv_ui_admin_rol as
select rol_id,
       rol_anw_id,
       rol_name,
       rol_beschreibung,
       rol_aktiv,
       rol_sortierung
  from dl_bv_rolle
 where rol_anw_id = (select v('P55_ROL_ANW_ID') from dual);

comment on table  bv_ui_admin_rol  is 'UI-Wrapper der Seite ADMIN_ROL fuer Tabelle BV_ROLLE';
