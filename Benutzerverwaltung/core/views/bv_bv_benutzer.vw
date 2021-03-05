create or replace view bv_bv_benutzer as
select /*+ no_merge (p) */ ben.ben_id, ben.ben_ad, ben.ben_stz,
       anr.anr_name ben_anrede, tit.tit_name ben_titel,
       ben.ben_vorname, ben_nachname,
       ben.ben_email, ben.ben_telefon
  from bv_benutzer ben
  join bv_anrede anr on ben.ben_anr_id = anr.anr_id
  left join bv_titel tit on ben.ben_tit_id = tit.tit_id
 where exists (
       select null
         from bv_benutzer_rechte bre
        where bre.ben_id = bre.ben_id
          and bre.anw_id = 'BV');
