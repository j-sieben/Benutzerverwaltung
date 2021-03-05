create or replace editionable view bv_ui_benutzer_main as 
select ben.ben_id,
       ben.ben_ad,
       ben.ben_stz,
       anr.anr_name,
       tit.tit_name,
       ben.ben_vorname,
       ben.ben_nachname,
       ben.ben_email,
       ben.ben_telefon,
       case when sysdate between ben.ben_gueltig_ab and ben.ben_gueltig_bis
       then 'Ja'
       else 'Nein' end ben_aktiv
  from dl_bv_benutzer ben
  join dl_bv_anrede anr
    on ben.ben_anr_id = anr.anr_id
  left join dl_bv_titel tit
    on ben.ben_tit_id = tit.tit_id;

comment on column bv_ui_benutzer_main.ben_id is 'Primaerschluessel';
comment on column bv_ui_benutzer_main.ben_ad is 'Active Directory DN';
comment on column bv_ui_benutzer_main.ben_stz is 'Stellenzeichen';
comment on column bv_ui_benutzer_main.anr_name is 'Anrede des Benutzers';
comment on column bv_ui_benutzer_main.tit_name is 'Titel des Benutzers';
comment on column bv_ui_benutzer_main.ben_vorname is 'Vorname des Benutzers';
comment on column bv_ui_benutzer_main.ben_nachname is 'Nachname des Benutzers';
comment on column bv_ui_benutzer_main.ben_email is 'EMail-Adresse des Benutzers';
comment on column bv_ui_benutzer_main.ben_telefon is 'Telefnonnumer des Benutzers';
comment on column bv_ui_benutzer_main.ben_aktiv is 'Darstellug Ja|Nein, ob Benutzer aktiv ist oder nicht';
comment on table bv_ui_benutzer_main  is 'UI-Wrapper der Seite BENUTZER_MAIN um BV_BENUTZER, Darstellung mit aufgeloesten Lookup-Tabellen';
