create or replace editionable view  bv_ui_admin_ben_main as 
select ben_id,
       ben_ad,
       ben_stz,
       anr_name ben_anr_id,
       tit_name ben_tit_id,
       ben_vorname,
       ben_nachname,
       ben_email,
       ben_telefon,
       ben_gueltig_ab,
       ben_gueltig_bis
  from dl_bv_benutzer
  join dl_bv_anrede
    on ben_anr_id = anr_id
  left join dl_bv_titel
    on ben_tit_id = tit_id;

comment on column  bv_ui_admin_ben_main.ben_id is 'Primaerschluessel';
comment on column  bv_ui_admin_ben_main.ben_ad is 'Active Directory DN';
comment on column  bv_ui_admin_ben_main.ben_stz is 'Stellenzeichen';
comment on column  bv_ui_admin_ben_main.ben_anr_id is 'Referenz auf BV_ANREDE';
comment on column  bv_ui_admin_ben_main.ben_tit_id is 'Referenz auf BV_TITEL';
comment on column  bv_ui_admin_ben_main.ben_vorname is 'Vorname des Benutzers';
comment on column  bv_ui_admin_ben_main.ben_nachname is 'Nachname des Benutzers';
comment on column  bv_ui_admin_ben_main.ben_email is 'EMail-Adresse des Benutzers';
comment on column  bv_ui_admin_ben_main.ben_telefon is 'Telefnonnumer des Benutzers';
comment on column  bv_ui_admin_ben_main.ben_gueltig_ab is 'Benutzer gueltig von';
comment on column  bv_ui_admin_ben_main.ben_gueltig_bis is 'Benutzer gueltig von';
comment on table  bv_ui_admin_ben_main  is 'UI-Wrapper der Seite BEN_ADMIN fuer Tabelle BV_BENUTZER';
