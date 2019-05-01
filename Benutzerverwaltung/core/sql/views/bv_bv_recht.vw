create or replace view bv_bv_recht as
select rec_id, rec_name, rec_beschreibung, rec_aktiv, rec_sortierung
  from bv_recht
 where rec_anw_id = 'BV';
