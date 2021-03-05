create or replace editionable view  bv_ui_edit_ben_rollen as
with params as(
       select utl_apex.get_user g_user,
              utl_apex.get_application_alias g_alias,
              utl_apex.get_number('P10_BEN_ID') g_ben_id
         from dual)
select /*+ no_merge (p) */
       bro_ben_id,
       bro_rol_id,
       bro_anw_id,
       bro_gueltig_ab,
       bro_gueltig_bis
  from dl_bv_benutzer_rolle
  join params p
    on bro_ben_id = g_ben_id
  join table(bl_recht.get_admin_anw(g_user, g_alias))
    on bro_anw_id = column_value
 where bro_gueltig_bis > sysdate;

comment on column  bv_ui_edit_ben_rollen.bro_ben_id is 'Primaerschluessel, Referenz auf BV_BENUTZER';
comment on column  bv_ui_edit_ben_rollen.bro_rol_id is 'Primaerschluessel, Referenz auf BV_ROLLE';
comment on column  bv_ui_edit_ben_rollen.bro_anw_id is 'Primaerschluessel, Referenz auf BV_ROLLE';
comment on column  bv_ui_edit_ben_rollen.bro_gueltig_ab is 'Festlegung eines Gueltigkeitszeitraums';
comment on column  bv_ui_edit_ben_rollen.bro_gueltig_bis is 'Festlegung eines Gueltigkeitszeitraums';
comment on table  bv_ui_edit_ben_rollen  is 'UI-Wrapper der Seite ADMIN_BEN um BV_BENUTZER_ROLLE auf alle Anwendungsrechte, die durch den angemeldeten Benutzer editiert werden duerfen';
