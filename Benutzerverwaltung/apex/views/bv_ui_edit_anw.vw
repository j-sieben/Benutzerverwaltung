create or replace editionable view bv_ui_edit_anw as 
with params as (
       select utl_apex.get_value('anw_id') g_anw_id
         from dual),
     rollen_liste as(
        select rro_anw_id,
               substr(sys_connect_by_path(rro_rol_id, ':'), 2) rol_rol_list
          from dl_bv_rolle_rolle rro
          join dl_bv_anwendung anw
            on rro.rro_anw_id = anw.anw_id
         where connect_by_isleaf = 1
           and anw.anw_aar_id = 'HIERARCHIE_EINFACH'
         start with rro_rol_id = rro_parent_rol_id
       connect by nocycle prior rro_rol_id = rro_parent_rol_id and prior rro_anw_id = rro_anw_id
         order siblings by rro_rol_id)
select /*+ no_merge params(p) */
       anw_id,
       anw_apex_alias,
       anw_schema,
       anw_aar_id,
       anw_name,
       anw_beschreibung,
       anw_aktiv,
       anw_sortierung,
       rol_rol_list
  from dl_bv_anwendung
  join params p
    on anw_id = g_anw_id
  left join rollen_liste
    on rro_anw_id = g_anw_id;

comment on column  bv_ui_edit_anw.anw_id is 'Primaerschluessel, entspricht im Regelfall dem APEX-Alias';
comment on column  bv_ui_edit_anw.anw_apex_alias is 'Eindeutiges APEX-Alias, entspricht im Regelfall der ID';
comment on column  bv_ui_edit_anw.anw_schema is 'Schema, das die Daten dieser Anwendung enthält';
comment on column  bv_ui_edit_anw.anw_aar_id is 'Referenz auf BV_ANWENDUNG_ART';
comment on column  bv_ui_edit_anw.anw_name is 'Anwendungsname, wie er auf der Oberfläche angezeigt wird';
comment on column  bv_ui_edit_anw.anw_beschreibung is 'Beschreibung der Anwendung';
comment on column  bv_ui_edit_anw.anw_aktiv is 'Flag, das anzeigt, ob der Datensatz aktuell genutzt wird';
comment on column  bv_ui_edit_anw.anw_sortierung is 'Sortierkriterium';
comment on column  bv_ui_edit_anw.rol_rol_list is 'Liste der hierarchisch zugeordneten Rollen';
comment on table  bv_ui_edit_anw  is 'UI-Wrapper der Seite EDIT_anw fuer Tabelle BV_anwUTZER';