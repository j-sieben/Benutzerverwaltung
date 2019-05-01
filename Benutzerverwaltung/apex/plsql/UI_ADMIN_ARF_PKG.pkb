create or replace package body ui_admin_arf_pkg
as

  procedure insert_anwendung_referenz(
    p_arf_anw_id bv_anwendung.anw_id%type,
    p_arf_anw_id_list varchar2 default null)
  as
    l_ref_anw_id_list varchar2(4000);
  begin
    l_ref_anw_id_list := p_arf_anw_id || ':' || p_arf_anw_id_list;
    insert into bv_anwendung_referenz
    select distinct p_arf_anw_id, column_value
      from table(bv_utils.string_to_table(l_ref_anw_id_list))
     where column_value is not null;
  end insert_anwendung_referenz;

  procedure update_anwendung_referenz(
    p_arf_anw_id bv_anwendung.anw_id%type,
    p_arf_anw_id_list varchar2)
  as
    l_ref_anw_id_list varchar2(4000);
  begin
    l_ref_anw_id_list := p_arf_anw_id || ':' || p_arf_anw_id_list;
    -- Alte Eintraege entfernen
    delete from bv_anwendung_referenz
     where arf_anw_id = p_arf_anw_id;
    insert into bv_anwendung_referenz(arf_anw_id, arf_referenz_anw_id)
    select distinct p_arf_anw_id, column_value
      from table(bv_utils.string_to_table(l_ref_anw_id_list))
     where column_value is not null;
  end update_anwendung_referenz;

  procedure delete_anwendung_referenz(
    p_arf_anw_id bv_anwendung.anw_id%type)
  as
  begin
    delete from bv_anwendung_referenz
     where arf_anw_id = p_arf_anw_id;
    insert into bv_anwendung_referenz(arf_anw_id, arf_referenz_anw_id)
    select distinct p_arf_anw_id, column_value
      from table(bv_utils.string_to_table(p_arf_anw_id));
  end delete_anwendung_referenz;

end ui_admin_arf_pkg;
/