create or replace editionable view bv_lov_benutzer as 
  select ben_nachname || ', ' || ben_vorname || ' (' || ben_ad || ')' d, ben_id r,
       case when sysdate between ben_gueltig_ab and ben_gueltig_bis then &C_TRUE. else &C_FALSE. end ben_aktiv
  from bv_benutzer;

comment on column bv_lov_benutzer.d is 'Display-Wert des LOV';
comment on column bv_lov_benutzer.r is 'Return-Wert des LOV';
comment on column bv_lov_benutzer.ben_aktiv is 'Flag, das anzeigt, ob der Eintrag aktuell genutzt wird.';
comment on table bv_lov_benutzer  is 'LOV-View der Tabelle BV_BENUTZER';
