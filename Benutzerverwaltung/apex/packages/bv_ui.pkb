create or replace package body bv_ui
as
  g_page_values utl_apex.page_value_t;
  g_admin_aar_row bv_anwendung_art%rowtype;
  g_admin_anr_row bv_anrede%rowtype;
  g_admin_anw_row bv_anwendung%rowtype;  
  g_admin_arf_row bv_ui_admin_arf%rowtype;
  g_admin_rec_row bv_recht%rowtype;
  g_admin_rol_row bv_rolle%rowtype;
  g_admin_tit_row bv_titel%rowtype;
  g_edit_ben_row bv_benutzer%rowtype;
  g_edit_ben_rolle_row bv_benutzer_rolle%rowtype;
  
  /* Hilfsmethoden */
  procedure copy_admin_aar
  as
  begin
    pit.enter_detailed('copy_admin_aar');
  
    g_page_values := utl_apex.get_page_values('ADMIN_AAR_IG');
    g_admin_aar_row.aar_id := utl_apex.get(g_page_values, 'aar_id');
    g_admin_aar_row.aar_name := utl_apex.get(g_page_values, 'aar_name');
    g_admin_aar_row.aar_beschreibung := utl_apex.get(g_page_values, 'aar_beschreibung');
    g_admin_aar_row.aar_aktiv := utl_apex.get(g_page_values, 'aar_aktiv');
    g_admin_aar_row.aar_sortierung := to_number(utl_apex.get(g_page_values, 'aar_sortierung'), 'fm9999999999990d99999999');
  
    pit.leave_detailed;
  end copy_admin_aar;
  
  
  procedure copy_admin_anr
  as
  begin
    pit.enter_detailed('copy_admin_anr');
  
    g_page_values := utl_apex.get_page_values('ADMIN_ANR_IG');
    g_admin_anr_row.anr_id := utl_apex.get(g_page_values, 'anr_id');
    g_admin_anr_row.anr_name := utl_apex.get(g_page_values, 'anr_name');
    g_admin_anr_row.anr_beschreibung := utl_apex.get(g_page_values, 'anr_beschreibung');
    g_admin_anr_row.anr_aktiv := utl_apex.get(g_page_values, 'anr_aktiv');
    g_admin_anr_row.anr_sortierung := to_number(utl_apex.get(g_page_values, 'anr_sortierung'), 'fm9999999999990d99999999');
  
    pit.leave_detailed;
  end copy_admin_anr;
    
  procedure copy_admin_anw
  as
  begin
    pit.enter_detailed('copy_admin_anw');
  
    g_page_values := utl_apex.get_page_values('ADMIN_ANW_IG');
    g_admin_anw_row.anw_id := upper(dbms_assert.simple_sql_name(utl_apex.get(g_page_values, 'anw_id')));
    g_admin_anw_row.anw_apex_alias := coalesce(upper(utl_apex.get(g_page_values, 'anw_apex_alias')), g_admin_anw_row.anw_id);
    g_admin_anw_row.anw_schema := upper(dbms_assert.schema_name(utl_apex.get(g_page_values, 'anw_schema')));
    g_admin_anw_row.anw_aar_id := utl_apex.get(g_page_values, 'anw_aar_id');
    g_admin_anw_row.anw_name := utl_apex.get(g_page_values, 'anw_name');
    g_admin_anw_row.anw_beschreibung := utl_apex.get(g_page_values, 'anw_beschreibung');
    g_admin_anw_row.anw_aktiv := coalesce(utl_apex.get(g_page_values, 'anw_aktiv'), 'N');
    g_admin_anw_row.anw_sortierung := utl_apex.get(g_page_values, 'anw_sortierung');
  
    pit.leave_detailed;
  end copy_admin_anw;
  
  
  procedure copy_admin_arf
  as
  begin
    pit.enter_detailed('copy_admin_arf');
  
    g_page_values := utl_apex.get_page_values('TODO');
    g_admin_arf_row.arf_anw_id := utl_apex.get(g_page_values, 'arf_anw_id');
    g_admin_arf_row.arf_anw_id_list := utl_apex.get(g_page_values, 'arf_anw_id_list');
  
    pit.leave_detailed;
  end copy_admin_arf;
  
  
  procedure copy_admin_rec
  as
  begin
    pit.enter_detailed('copy_admin_rec');
  
    g_page_values := utl_apex.get_page_values('ADMIN_REC_IG');
    g_admin_rec_row.rec_id := utl_apex.get(g_page_values, 'rec_id');
    g_admin_rec_row.rec_anw_id := utl_apex.get_value('P50_REC_ANW_ID');
    g_admin_rec_row.rec_name := utl_apex.get(g_page_values, 'rec_name');
    g_admin_rec_row.rec_beschreibung := utl_apex.get(g_page_values, 'rec_beschreibung');
    g_admin_rec_row.rec_aktiv := utl_apex.get(g_page_values, 'rec_aktiv');
    g_admin_rec_row.rec_sortierung := to_number(utl_apex.get(g_page_values, 'rec_sortierung'), 'fm9999999999990d99999999');
  
    pit.leave_detailed;
  end copy_admin_rec;
  
  
  procedure copy_admin_rol
  as
  begin
    pit.enter_detailed('copy_edit_ben_rollen');
  
    g_page_values := utl_apex.get_page_values('ADMIN_ROL_IG');
    g_admin_rol_row.rol_id := utl_apex.get(g_page_values, 'rol_id');
    g_admin_rol_row.rol_anw_id := utl_apex.get_value('P55_ROL_ANW_ID');
    g_admin_rol_row.rol_name := utl_apex.get(g_page_values, 'rol_name');
    g_admin_rol_row.rol_beschreibung := utl_apex.get(g_page_values, 'rol_beschreibung');
    g_admin_rol_row.rol_aktiv := utl_apex.get(g_page_values, 'rol_aktiv');
    g_admin_rol_row.rol_sortierung := utl_apex.get(g_page_values, 'rol_sortierung');
  
    pit.leave_detailed;
  end copy_admin_rol;
  
  
  procedure copy_admin_tit
  as
  begin
    pit.enter_detailed('copy_admin_tit');
  
    g_page_values := utl_apex.get_page_values('ADMIN_TIT_IG');
    g_admin_tit_row.tit_id := utl_apex.get(g_page_values, 'tit_id');
    g_admin_tit_row.tit_name := utl_apex.get(g_page_values, 'tit_name');
    g_admin_tit_row.tit_beschreibung := utl_apex.get(g_page_values, 'tit_beschreibung');
    g_admin_tit_row.tit_aktiv := utl_apex.get(g_page_values, 'tit_aktiv');
    g_admin_tit_row.tit_sortierung := to_number(utl_apex.get(g_page_values, 'tit_sortierung'), 'fm9999999999990d99999999');
  
    pit.leave_detailed;
  end copy_admin_tit;
  
  
  procedure copy_edit_ben
  as
    l_date_format varchar2(100 byte) := utl_apex.get_default_date_format;
  begin
    pit.enter_detailed('copy_edit_ben');
  
    g_page_values := utl_apex.get_page_values('TODO');
    g_edit_ben_row.ben_id := upper(utl_apex.get(g_page_values, 'ben_id'));
    g_edit_ben_row.ben_ad := coalesce(upper(utl_apex.get(g_page_values, 'ben_ad')), g_edit_ben_row.ben_id);
    g_edit_ben_row.ben_stz := upper(utl_apex.get(g_page_values, 'ben_stz'));
    g_edit_ben_row.ben_anr_id := utl_apex.get(g_page_values, 'ben_anr_id');
    g_edit_ben_row.ben_tit_id := utl_apex.get(g_page_values, 'ben_tit_id');
    g_edit_ben_row.ben_vorname := utl_apex.get(g_page_values, 'ben_vorname');
    g_edit_ben_row.ben_nachname := utl_apex.get(g_page_values, 'ben_nachname');
    g_edit_ben_row.ben_email := utl_apex.get(g_page_values, 'ben_email');
    g_edit_ben_row.ben_telefon := utl_apex.get(g_page_values, 'ben_telefon');
    g_edit_ben_row.ben_gueltig_ab := to_date(utl_apex.get(g_page_values, 'ben_gueltig_ab'), l_date_format);
    g_edit_ben_row.ben_gueltig_bis := to_date(utl_apex.get(g_page_values, 'ben_gueltig_bis'), l_date_format);
  
    pit.leave_detailed;
  end copy_edit_ben;
  
  
  procedure copy_edit_ben_rollen
  as
    l_date_format varchar2(100 byte) := utl_apex.get_default_date_format;
  begin
    g_page_values := utl_apex.get_page_values('TODO');
    g_edit_ben_rolle_row.bro_ben_id := upper(utl_apex.get(g_page_values, 'bro_ben_id'));
    g_edit_ben_rolle_row.bro_anw_id := upper(utl_apex.get(g_page_values, 'bro_anw_id'));
    g_edit_ben_rolle_row.bro_rol_id := upper(utl_apex.get(g_page_values, 'bro_rol_id'));
    g_edit_ben_rolle_row.bro_gueltig_ab := to_date(utl_apex.get(g_page_values, 'bro_gueltig_ab'), l_date_format);
    g_edit_ben_rolle_row.bro_gueltig_bis := to_date(utl_apex.get(g_page_values, 'bro_gueltig_bis'), l_date_format);
  
    pit.leave_detailed;
  end copy_edit_ben_rollen;
  
  
  /* INTERFACE */
  /* Autorisierung */  
  function benutzer_hat_recht(
    p_rec_id in bv_recht.rec_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return boolean
  as
  begin
    return bv_recht_pkg.benutzer_hat_recht(
             p_ben_ad => utl_apex.get_user, 
             p_rec_id => p_rec_id, 
             p_anw_id => coalesce(p_anw_id, utl_apex.get_application_alias));
  end benutzer_hat_recht;
  
  
  function validiere_admin_aar
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    -- copy_admin_aar;
    -- validation logic goes here. If it exists, uncomment COPY function
    
    pit.leave_mandatory;
    return true;
  end validiere_admin_aar;
  
  
  procedure verarbeite_admin_aar
  as
  begin
    pit.enter_mandatory;
    
    copy_admin_aar;
    case when utl_apex.inserting or utl_apex.updating then
      bl_anw.merge_anwendung_art(g_admin_aar_row);
    else
      bl_anw.loesche_anwendung_art(g_admin_aar_row);
    end case;
    
    pit.leave_mandatory;
  end verarbeite_admin_aar;
  
  function validiere_admin_anr
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    -- copy_admin_anr;
    -- validation logic goes here. If it exists, uncomment COPY function
    
    pit.leave_mandatory;
    return true;
  end validiere_admin_anr;
  
  
  procedure verarbeite_admin_anr
  as
  begin
    pit.enter_mandatory;
    
    copy_admin_anr;
    case when utl_apex.inserting or utl_apex.updating then
      bl_ben.merge_anrede(g_admin_anr_row);
    else
      bl_ben.loesche_anrede(g_admin_anr_row);
    end case;
    
    pit.leave_mandatory;
  end verarbeite_admin_anr;
  
  
  function validiere_admin_anw
    return boolean
  as
  begin
    copy_admin_anw;
    bl_anw.validiere_anwendung(g_admin_anw_row);
    
    return true;
  end validiere_admin_anw;
  
   
  procedure verarbeite_admin_anw
  as
  begin
    copy_admin_anw;
    case 
    when utl_apex.inserting or utl_apex.updating then
      bl_anw.merge_anwendung(g_admin_anw_row);
    when utl_apex.deleting then
      bl_anw.loesche_anwendung(g_admin_anw_row);
    else
      null;
    end case;  
  end verarbeite_admin_anw;
  
  
  function validiere_admin_arf
    return boolean
  as
  begin
    --copy_admin_arf;
    return true;
  end validiere_admin_arf;
  
   
  procedure verarbeite_admin_arf
  as
  begin
    pit.enter_mandatory;
    
    copy_admin_anw;
    case 
    when utl_apex.inserting or utl_apex.updating then
      bl_anw.merge_anwendung_referenzen(
        p_anw_id => g_admin_arf_row.arf_anw_id,
        p_anw_id_list => g_admin_arf_row.arf_anw_id_list);
    when utl_apex.deleting then
      bl_anw.loesche_anwendung_referenzen(
        p_anw_id => g_admin_arf_row.arf_anw_id);
    else
      null;
    end case;  
    
    pit.leave_mandatory;
  end verarbeite_admin_arf;
  
  
  function validiere_admin_rec
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    -- copy_admin_rec;
    -- validation logic goes here. If it exists, uncomment COPY function
    
    pit.leave_mandatory;
    return true;
  end validiere_admin_rec;
  
  
  procedure verarbeite_admin_rec
  as
  begin
    pit.enter_mandatory;
    
    copy_admin_rec;
    case when utl_apex.inserting or utl_apex.updating then
      bl_recht.merge_recht(g_admin_rec_row);
    else
      bl_recht.loesche_recht(g_admin_rec_row);
    end case;
    
    pit.leave_mandatory;
  end verarbeite_admin_rec;
  
   
  function validiere_admin_rol
    return boolean
  as
  begin
    -- copy_admin_rol;
    return null;
  end validiere_admin_rol;
  
  
  procedure verarbeite_admin_rol
  as
    l_row bv_anwendung%rowtype;
  begin
    pit.enter_mandatory;
    
    copy_admin_rol;
    case 
    when utl_apex.inserting or utl_apex.updating then
      bl_recht.merge_rolle(g_admin_rol_row);
    when utl_apex.deleting then
      bl_recht.loesche_rolle(g_admin_rol_row);
    else
      raise_application_error(-20000, apex_lang.message('UNKNOWN_REQUEST', v('REQUEST')));
    end case;
    
    pit.leave_mandatory;
  end verarbeite_admin_rol;
  
  
  
  function validiere_admin_tit
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    -- copy_admin_tit;
    -- validation logic goes here. If it exists, uncomment COPY function
    
    pit.leave_mandatory;
    return true;
  end validiere_admin_tit;
  
  
  procedure verarbeite_admin_tit
  as
  begin
    pit.enter_mandatory;
    
    copy_admin_tit;
    case when utl_apex.inserting or utl_apex.updating then
      bl_ben.merge_titel(g_admin_tit_row);
    else
      bl_ben.loesche_titel(g_admin_tit_row);
    end case;
    
    pit.leave_mandatory;
  end verarbeite_admin_tit;
  
  
  function validiere_edit_ben
    return boolean
  as
  begin
    copy_edit_ben;
    
    pit.start_message_collection;
    bl_ben.validiere_benutzer(g_edit_ben_row);
    pit.start_message_collection;
    
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR then
      utl_apex.handle_bulk_errors(char_table(
        'BEN_EMAIL_MISSING', 'BEN_EMAIL',
        'BEN_NACHNAME_MISSING', 'BEN_NACHNAME',
        'BEN_GUELTIG_BIS_MISSING', 'BEN_GUELTIG_BIS'));
  end validiere_edit_ben;
  
  
  procedure verarbeite_edit_ben
  as
  begin
    copy_edit_ben;
    
    case
    when utl_apex.inserting or utl_apex.updating then
      bl_ben.merge_benutzer(g_edit_ben_row);
    when utl_apex.deleting then
      bl_ben.loesche_benutzer(g_edit_ben_row);
    else
      null;
    end case;  
  end verarbeite_edit_ben;
  
  
  procedure verarbeite_edit_ben_rollen
  as
  begin
    copy_edit_ben_rollen;
    
    case
    when utl_apex.inserting or utl_apex.updating then
      bl_recht.rolle_zuweisen(g_edit_ben_rolle_row);
    when utl_apex.deleting then
      bl_recht.rolle_entziehen(g_edit_ben_rolle_row);
    else
      null;
    end case;  
  end verarbeite_edit_ben_rollen;
  
  
  function get_hierarchie_url
    return varchar2
  as
    l_anw_id bv_anwendung.anw_id%type := v('P55_ROL_ANW_ID');
    l_url varchar2(1000);
  begin
    l_url := 'f?p=' || v('APP_ALIAS') || ':#PAGE#:' || v('SESSION') || '::::P#PAGE_NO#_ANW_ID:' || l_anw_id;
    
    select case anw_aar_id
           when bv_utils.C_AAR_HIER_EINFACH then apex_util.prepare_url(replace(replace(l_url, '#PAGE#', 'ADMIN_EINFACHE_ROL'), '#PAGE_NO#', '56'))
           when bv_utils.C_AAR_HIER_KOMPLEX then apex_util.prepare_url(replace(replace(l_url, '#PAGE#', 'ADMIN_KOMPLEXE_ROL'), '#PAGE_NO#', '57'))
           else null end
      into l_url
      from bv_anwendung
     where anw_id = l_anw_id;
    
    return l_url;
  end get_hierarchie_url;
  
  /** Verwaltung der Anwendungsseite AMDIN_EINFACHE_ROL */
  function validiere_admin_einfache_rol
    return boolean
  as
  begin
    return true;
  end validiere_admin_einfache_rol;
  
    
  procedure verarbeite_admin_einfache_rol
  as
  begin
    null;
  end verarbeite_admin_einfache_rol;

end bv_ui;
/
