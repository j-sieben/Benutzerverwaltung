create or replace editionable view bv_lov_edit_einfache_rol as 
with params as(
       select utl_apex.get_value('anw_id') g_anw_id,
              bv_utils.C_TRUE g_true
         from dual)
select /*+ no_merge (p) */
       rol_name d, rol_id r
  from dl_bv_rolle
  join params p
    on rol_anw_id = g_anw_id
 where rol_aktiv = g_true;

comment on table bv_lov_edit_einfache_rol  is 'Alle Rollen der gewaehlten Anwendung';
comment on column bv_lov_edit_einfache_rol.d is 'Display-Wert des LOV';
comment on column bv_lov_edit_einfache_rol.r is 'Return-Wert des LOV';