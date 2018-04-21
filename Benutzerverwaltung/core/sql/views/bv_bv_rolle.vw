create or replace view bv_bv_rolle as
select rol_id, rol_name, rol_beschreibung, rol_aktiv, rol_sortierung
  from bv_rolle
 where rol_anw_id = 'BV';
