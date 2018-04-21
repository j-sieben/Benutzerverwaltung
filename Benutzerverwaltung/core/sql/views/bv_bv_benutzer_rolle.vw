create or replace view bv_bv_benutzer_rolle as
select ben.ben_id, ben.ben_ad, bro.bro_rol_id
  from bv_benutzer_rolle bro
  join bv_benutzer ben on bro.bro_ben_id = ben.ben_id
 where sysdate between bro.bro_gueltig_von and bro.bro_gueltig_bis
   and bro.bro_anw_id = 'BV';
