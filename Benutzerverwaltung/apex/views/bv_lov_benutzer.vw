create or replace editionable view bv_lov_benutzer as
with params as(
       select bv_utils.c_true g_true,
              bv_utils.c_false g_false
         from dual)
select /*+ no_merge (p) */ ben_nachname || ', ' || ben_vorname || ' (' || ben_ad || ')' d, ben_id r,
       case when sysdate between ben_gueltig_ab and ben_gueltig_bis then g_true else g_false end ben_aktiv
  from dl_bv_benutzer
 cross join params p;

comment on column bv_lov_benutzer.d is 'Display-Wert des LOV';
comment on column bv_lov_benutzer.r is 'Return-Wert des LOV';
comment on column bv_lov_benutzer.ben_aktiv is 'Flag, das anzeigt, ob der Eintrag aktuell genutzt wird.';
comment on table bv_lov_benutzer  is 'LOV-View der Tabelle BV_BENUTZER';
