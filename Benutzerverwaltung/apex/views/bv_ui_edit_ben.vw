create or replace editionable view bv_ui_edit_ben as 
select ben_id,
       ben_ad,
       ben_stz,
       ben_anr_id,
       ben_tit_id,
       ben_vorname,
       ben_nachname,
       ben_email,
       ben_telefon,
       ben_gueltig_ab,
       ben_gueltig_bis
  from dl_bv_benutzer ben;

comment on column  bv_ui_edit_ben.ben_id is 'Primaerschluessel';
comment on column  bv_ui_edit_ben.ben_ad is 'Active Directory DN';
comment on column  bv_ui_edit_ben.ben_stz is 'Stellenzeichen';
comment on column  bv_ui_edit_ben.ben_anr_id is 'Referenz auf BV_ANREDE';
comment on column  bv_ui_edit_ben.ben_tit_id is 'Referenz auf BV_TITEL';
comment on column  bv_ui_edit_ben.ben_vorname is 'Vorname des Benutzers';
comment on column  bv_ui_edit_ben.ben_nachname is 'Nachname des Benutzers';
comment on column  bv_ui_edit_ben.ben_email is 'EMail-Adresse des Benutzers';
comment on column  bv_ui_edit_ben.ben_telefon is 'Telefnonnumer des Benutzers';
comment on column  bv_ui_edit_ben.ben_gueltig_ab is 'Benutzer gueltig von';
comment on column  bv_ui_edit_ben.ben_gueltig_bis is 'Benutzer gueltig von';
comment on table  bv_ui_edit_ben  is 'UI-Wrapper der Seite EDIT_BEN fuer Tabelle BV_BENUTZER';
