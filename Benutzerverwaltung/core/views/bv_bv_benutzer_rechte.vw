create or replace view bv_bv_benutzer_rechte as
select anw.anw_id, anw.anw_apex_alias, ben.ben_id, ben.ben_ad, bre.rec_id
  from bv_benutzer ben
  join bv_benutzer_rechte bre on ben.ben_id = bre.ben_id
  join bv_anwendung_referenz arf on bre.anw_id = arf.arf_referenz_anw_id
  join bv_anwendung anw on arf.arf_referenz_anw_id = anw.anw_id
 where arf.arf_anw_id = 'BV';
