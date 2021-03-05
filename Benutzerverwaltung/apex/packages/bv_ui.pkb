create or replace package body bv_ui
as
  g_page_values utl_apex.page_value_t;
  g_admin_aar_row dl_bv_anwendung_art%rowtype;
  g_admin_anr_row dl_bv_anrede%rowtype;
  g_edit_anw_row dl_bv_anwendung%rowtype;  
  g_admin_arf_row bv_ui_admin_arf%rowtype;
  g_admin_rec_row dl_bv_recht%rowtype;
  g_admin_rol_row dl_bv_rolle%rowtype;
  g_admin_tit_row dl_bv_titel%rowtype;
  g_edit_ben_row dl_bv_benutzer%rowtype;
  g_edit_ben_rolle_row dl_bv_benutzer_rolle%rowtype;
  g_edit_einfache_rol dl_bv_rolle_rolle%rowtype;
  g_edit_komplexe_rol bv_ui_edit_komplexe_rol%rowtype;
  g_edit_rol_row dl_bv_rolle%rowtype;
  
  g_rol_list char_table;
  
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
    pit.enter_detailed('copy_admin_rol');
  
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
  
    
  procedure copy_edit_anw
  as
  begin
    pit.enter_detailed('copy_edit_anw');
  
    g_page_values := utl_apex.get_page_values('EDIT_ANW_FORM');
    g_edit_anw_row.anw_id := utl_apex.get(g_page_values, 'anw_id');
    g_edit_anw_row.anw_apex_alias := utl_apex.get(g_page_values, 'anw_apex_alias');
    g_edit_anw_row.anw_schema := utl_apex.get(g_page_values, 'anw_schema');
    g_edit_anw_row.anw_aar_id := utl_apex.get(g_page_values, 'anw_aar_id');
    g_edit_anw_row.anw_name := utl_apex.get(g_page_values, 'anw_name');
    g_edit_anw_row.anw_beschreibung := utl_apex.get(g_page_values, 'anw_beschreibung');
    g_edit_anw_row.anw_aktiv := utl_apex.get(g_page_values, 'anw_aktiv');
    g_edit_anw_row.anw_sortierung := to_number(utl_apex.get(g_page_values, 'anw_sortierung'), 'fm99990');
    
    -- Liste der zugeordneten Rollen uebernehmen und als CHAR_TABLE casten
    utl_text.string_to_table(utl_apex.get(g_page_values, 'rol_rol_list'), g_rol_list);
  
    pit.leave_detailed;
  end copy_edit_anw;
  
  
  procedure copy_edit_ben
  as
    l_date_format varchar2(100 byte) := utl_apex.get_default_date_format;
  begin
    pit.enter_detailed('copy_edit_ben');
  
    g_page_values := utl_apex.get_page_values('EDIT_BEN_FORM');
    g_edit_ben_row.ben_id := to_number(utl_apex.get(g_page_values, 'ben_id'), 'fm9999999999990d99999999');
    g_edit_ben_row.ben_ad := upper(utl_apex.get(g_page_values, 'ben_ad'));
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
    pit.enter_detailed('copy_edit_ben_rollen');
  
    g_page_values := utl_apex.get_page_values('EDIT_BEN_IG');
    g_edit_ben_rolle_row.bro_ben_id := coalesce(upper(utl_apex.get(g_page_values, 'bro_ben_id')), utl_apex.get_number('ben_id'));
    g_edit_ben_rolle_row.bro_anw_id := upper(utl_apex.get(g_page_values, 'bro_anw_id'));
    g_edit_ben_rolle_row.bro_rol_id := upper(utl_apex.get(g_page_values, 'bro_rol_id'));
    g_edit_ben_rolle_row.bro_gueltig_ab := to_date(utl_apex.get(g_page_values, 'bro_gueltig_ab'), l_date_format);
    g_edit_ben_rolle_row.bro_gueltig_bis := to_date(utl_apex.get(g_page_values, 'bro_gueltig_bis'), l_date_format);
  
    pit.leave_detailed;
  end copy_edit_ben_rollen;
  
  
  procedure copy_edit_einfaache_rol
  as
  begin
    pit.enter_detailed('copy_edit_einfaache_rol');
  
    g_page_values := utl_apex.get_page_values('EDIT_EINFACHE_ROL_FORM');
    g_edit_einfache_rol.rro_anw_id := utl_apex.get(g_page_values, 'anw_id');
    
    utl_text.string_to_table(utl_apex.get(g_page_values, 'rol_rol_list'), g_rol_list);
  
    pit.leave_detailed;
  end copy_edit_einfaache_rol;
  
  
  procedure copy_edit_rol
  as
  begin
    pit.enter_detailed('copy_edit_rol');
  
    g_page_values := utl_apex.get_page_values('EDIT_ROL_FORM');
    g_edit_rol_row.rol_id := utl_apex.get(g_page_values, 'rol_id');
    g_edit_rol_row.rol_anw_id := utl_apex.get(g_page_values, 'rol_anw_id');
    g_edit_rol_row.rol_name := utl_apex.get(g_page_values, 'rol_name');
    g_edit_rol_row.rol_beschreibung := utl_apex.get(g_page_values, 'rol_beschreibung');
    g_edit_rol_row.rol_aktiv := utl_apex.get(g_page_values, 'rol_aktiv');
    g_edit_rol_row.rol_sortierung := utl_apex.get(g_page_values, 'rol_sortierung');
  
    pit.leave_detailed;
  end copy_edit_rol;
  
  
  /* INTERFACE */
  /* Autorisierung */  
  function benutzer_hat_recht(
    p_rec_id in dl_bv_recht.rec_id%type,
    p_anw_id in dl_bv_anwendung.anw_id%type default null)
    return boolean
  as
  begin
    return bv_recht_pkg.benutzer_hat_recht(
             p_ben_ad => utl_apex.get_user, 
             p_rec_id => p_rec_id, 
             p_anw_id => coalesce(p_anw_id, utl_apex.get_application_alias));
  end benutzer_hat_recht;
  
  
  function ist_komplexe_hierarchie(
    p_anw_id in dl_bv_anwendung.anw_id%type)
    return boolean
  as
    l_result pls_integer;
  begin
    pit.enter_mandatory;
    
    select count(*)
      into l_result
      from dl_bv_anwendung
     where anw_aar_id = bv_utils.C_AAR_HIER_KOMPLEX
       and anw_id = p_anw_id;
       
    pit.leave_mandatory;
    return l_result > 0;
  end ist_komplexe_hierarchie;
  
  
  function get_max_datum
    return date
  as
  begin
    return bv_utils.C_MAX_DATE;
  end get_max_datum;
  
  
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
    
    copy_admin_arf;
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
    l_row dl_bv_anwendung%rowtype;
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
  
  
  procedure belege_edit_anw
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_anw;
    
    select coalesce(g_edit_anw_row.anw_name, logo_text),
           coalesce(g_edit_anw_row.anw_sortierung, 
                     (select max(trunc(anw_sortierung, -1)) + 10
                        from dl_bv_anwendung))
      into g_edit_anw_row.anw_name, g_edit_anw_row.anw_sortierung
      from apex_applications
     where alias = g_edit_anw_row.anw_id;
     
    utl_apex.set_value('P41_ANW_APEX_ALIAS', g_edit_anw_row.anw_id);
    utl_apex.set_value('P41_ANW_NAME', g_edit_anw_row.anw_name);
    utl_apex.set_value('P41_ANW_SORTIERUNG', g_edit_anw_row.anw_sortierung);
    
    pit.leave_mandatory;
  end;
  
  
  function validiere_edit_anw
    return boolean
  as
  begin
    copy_edit_anw;
    
    pit.start_message_collection;
    bl_anw.validiere_anwendung(g_edit_anw_row);
    pit.stop_message_collection;
    
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
      utl_apex.handle_bulk_errors(char_table(
        'ANW_AAR_ID_MISSING', 'anw_aar_id',
        'ANW_APEX_ALIAS_MISSING', 'anw_apex_alias',
        'INVALID_SQL_NAME', 'anw_id',
        'INVALID_SCHEMA', 'anw_schema'));
    
      pit.leave_mandatory;
      return true;
  end validiere_edit_anw;
  
   
  procedure verarbeite_edit_anw
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_anw;
    case 
    when utl_apex.inserting or utl_apex.updating then
      bl_anw.merge_anwendung(g_edit_anw_row);
    
      bl_recht.einfache_rollen_hierarchie(
        p_anw_id => g_edit_anw_row.anw_id,
        p_rol_hierarchie => g_rol_list);
        
    when utl_apex.deleting then
      bl_anw.loesche_anwendung(g_edit_anw_row);
    else
      null;
    end case;
    
    pit.leave_mandatory;
  end verarbeite_edit_anw;
  
  
  function validiere_edit_ben
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_ben;
    
    pit.start_message_collection;
    bl_ben.validiere_benutzer(g_edit_ben_row);
    pit.stop_message_collection;
    
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
      utl_apex.handle_bulk_errors(char_table(
        'ben_anr_id_missing', 'ben_anr_id',
        'ben_ad_missing', 'ben_ad',
        'ben_email_missing', 'ben_email',
        'ben_nachname_missing', 'ben_nachname',
        'ben_gueltig_bis_missing', 'ben_gueltig_bis',
        'bv_invalid_date_period', 'ben_gueltig_ab',
        'bv_invalid_valid_from', 'ben_gueltig_ab'));
        
      pit.leave_mandatory;
      return true;
  end validiere_edit_ben;
  
  
  procedure verarbeite_edit_ben
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_ben;
    
    case
    when utl_apex.inserting or utl_apex.updating then
      bl_ben.merge_benutzer(g_edit_ben_row);
    when utl_apex.deleting then
      bl_ben.loesche_benutzer(g_edit_ben_row);
    else
      null;
    end case;  
    
    pit.leave_mandatory;
  end verarbeite_edit_ben;
  
  
  procedure verarbeite_edit_ben_rollen
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_ben_rollen;
    
    case
    when utl_apex.inserting or utl_apex.updating then
      bl_recht.rolle_zuweisen(g_edit_ben_rolle_row);
    when utl_apex.deleting then
      bl_recht.rolle_entziehen(g_edit_ben_rolle_row);
    else
      null;
    end case;  
    
    pit.leave_mandatory;
  end verarbeite_edit_ben_rollen;
  
  /** Verwaltung der Anwendungsseite EDIT_EINFACHE_ROL */
  function validiere_edit_einfache_rol
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_einfaache_rol;
    
    pit.leave_mandatory;
    return true;
  end validiere_edit_einfache_rol;
    
    
  procedure verarbeite_edit_einfache_rol
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_einfaache_rol;
    
    bl_recht.merge_rolle_rolle(
      p_row => g_edit_einfache_rol,
      p_rol_list => g_rol_list);
    
    pit.leave_mandatory;
  end verarbeite_edit_einfache_rol;
  
  
  /** Verwaltung der Anwendungsseite EDIT_KOMPLEXE_ROL */
  function validiere_edit_komplexe_rol
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    pit.leave_mandatory;
    return true;
  end validiere_edit_komplexe_rol;

    
  procedure verarbeite_edit_komplexe_rol
  as
  begin
    pit.enter_mandatory;
    
    null;
    
    pit.leave_mandatory;
  end verarbeite_edit_komplexe_rol;
  
  
  function validiere_edit_rol
    return boolean
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_rol;
    
    pit.start_message_collection;
    bl_recht.validiere_rolle(g_edit_rol_row);
    pit.stop_message_collection;
    
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
      utl_apex.handle_bulk_errors(char_table(
        'ROL_ID_MISSING', 'P56_ROL_ID',
        'ROL_NAME_MISSING', 'P56_ROL_NAME',
        'INVALID_SQL_NAME', 'P56_ROL_ID',
        'ROL_ANW_ID_MISSING', 'P56_ROL_ANW_ID'));
        
      pit.leave_mandatory;
      return true;
  end validiere_edit_rol;
  
  
  procedure verarbeite_edit_rol
  as
  begin
    pit.enter_mandatory;
    
    copy_edit_rol;
    
    case
    when utl_apex.inserting or utl_apex.updating then
      bl_recht.merge_rolle(g_edit_rol_row);
    when utl_apex.deleting then
      bl_recht.loesche_rolle(g_edit_rol_row);
    else
      null;
    end case;  
    
    pit.leave_mandatory;
  end verarbeite_edit_rol;

end bv_ui;
/
