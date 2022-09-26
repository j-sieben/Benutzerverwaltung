create or replace package body bv_ui
as
  
  g_rol_list char_table;
  
  /* Hilfsmethoden */
  function copy_admin_aar
    return dl_bv_anwendung_art%rowtype
  as
    l_row dl_bv_anwendung_art%rowtype;
  begin
    pit.enter_detailed('copy_admin_aar');
  
    l_row.aar_id := utl_apex.get_string('aar_id');
    l_row.aar_name := utl_apex.get_string('aar_name');
    l_row.aar_beschreibung := utl_apex.get_string('aar_beschreibung');
    l_row.aar_aktiv := utl_apex.get_string('aar_aktiv');
    l_row.aar_sortierung := utl_apex.get_number('aar_sortierung');
  
    pit.leave_detailed;
    return l_row;
  end copy_admin_aar;
  
  
  function copy_admin_anr
    return dl_bv_anrede%rowtype
  as
    l_row dl_bv_anwendung_art%rowtype;
  begin
    pit.enter_detailed('copy_admin_anr');
    
    l_row.aar_id := utl_apex.get_string('aar_id');
    l_row.aar_name := utl_apex.get_string('aar_name');
    l_row.aar_beschreibung := utl_apex.get_string('aar_beschreibung');
    l_row.aar_aktiv := utl_apex.get_string('aar_aktiv');
    l_row.aar_sortierung := utl_apex.get_number('aar_sortierung');
  
    pit.leave_detailed;
    return l_row;
  end copy_admin_anr;
  
  function copy_admin_anw
    return dl_bv_anwendung%rowtype
  as
    l_row dl_bv_anwendung%rowtype;
  begin
    pit.enter_detailed('copy_admin_anw');      
    
    l_row.anw_id := utl_apex.get_string('anw_id');
    l_row.anw_apex_alias := utl_apex.get_string('anw_apex_alias');
    l_row.anw_schema := utl_apex.get_string('anw_schema');
    l_row.anw_aar_id := utl_apex.get_string('anw_aar_id');
    l_row.anw_name := utl_apex.get_string('anw_name');
    l_row.anw_beschreibung := utl_apex.get_string('anw_beschreibung');
    l_row.anw_aktiv := utl_apex.get_string('anw_aktiv');
    l_row.anw_sortierung := utl_apex.get_number('anw_sortierung');     

    pit.leave_detailed;
    return l_row;
  end copy_admin_anw; 
  
  
  function copy_admin_arf
    return bv_ui_admin_arf%rowtype
  as
    l_row bv_ui_admin_arf%rowtype;
  begin
    pit.enter_detailed('copy_admin_arf');
  
    l_row.arf_anw_id := utl_apex.get_string('arf_anw_id');
    l_row.arf_anw_id_list := utl_apex.get_string('arf_anw_id_list');
  
    pit.leave_detailed;
    return l_row;
  end copy_admin_arf;
  
  
  function copy_admin_rec
   return dl_bv_recht%rowtype
  as
    l_row dl_bv_recht%rowtype;
  begin
    pit.enter_detailed('copy_admin_rec');
  
    l_row.rec_id := utl_apex.get_string('rec_id');
    l_row.rec_anw_id := utl_apex.get_string('rec_anw_id');
    l_row.rec_name := utl_apex.get_string('rec_name');
    l_row.rec_beschreibung := utl_apex.get_string('rec_beschreibung');
    l_row.rec_aktiv := utl_apex.get_string('rec_aktiv');
    l_row.rec_sortierung := utl_apex.get_number('rec_sortierung');
  
    pit.leave_detailed;
    return l_row;
  end copy_admin_rec;
  
  
  function copy_admin_rol
    return dl_bv_rolle%rowtype
  as
    l_row dl_bv_rolle%rowtype;
  begin
    pit.enter_detailed('copy_admin_rol');
  
    l_row.rol_id := utl_apex.get_string('rol_id');
    l_row.rol_anw_id := utl_apex.get_string('rol_anw_id');
    l_row.rol_name := utl_apex.get_string('rol_name');
    l_row.rol_beschreibung := utl_apex.get_string('rol_beschreibung');
    l_row.rol_aktiv := utl_apex.get_string('rol_aktiv');
    l_row.rol_sortierung := utl_apex.get_string('rol_sortierung');
  
    pit.leave_detailed;
    return l_row;
  end copy_admin_rol;
  
  
  function copy_admin_tit
    return dl_bv_titel%rowtype
  as
    l_row dl_bv_titel%rowtype;
  begin
    pit.enter_detailed('copy_admin_tit');
  
    l_row.tit_id := utl_apex.get_string('tit_id');
    l_row.tit_name := utl_apex.get_string('tit_name');
    l_row.tit_beschreibung := utl_apex.get_string('tit_beschreibung');
    l_row.tit_aktiv := utl_apex.get_string('tit_aktiv');
    l_row.tit_sortierung := utl_apex.get_number('tit_sortierung');
  
    pit.leave_detailed;
    return l_row;
  end copy_admin_tit;
  
    
  function copy_edit_anw
    return dl_bv_anwendung%rowtype
  as
    l_row dl_bv_anwendung%rowtype;
  begin
    pit.enter_detailed('copy_edit_anw');
  
    l_row.anw_id := utl_apex.get_string('anw_id');
    l_row.anw_apex_alias := utl_apex.get_string('anw_apex_alias');
    l_row.anw_schema := utl_apex.get_string('anw_schema');
    l_row.anw_aar_id := utl_apex.get_string('anw_aar_id');
    l_row.anw_name := utl_apex.get_string('anw_name');
    l_row.anw_beschreibung := utl_apex.get_string('anw_beschreibung');
    l_row.anw_aktiv := utl_apex.get_string('anw_aktiv');
    l_row.anw_sortierung := utl_apex.get_number('anw_sortierung');
    
    -- Liste der zugeordneten Rollen uebernehmen und als CHAR_TABLE casten
    utl_text.string_to_table(utl_apex.get_string('rol_rol_list'), g_rol_list);
  
    pit.leave_detailed;
    return l_row;
  end copy_edit_anw;
  
  
  function copy_edit_ben
    return dl_bv_benutzer%rowtype
  as
    l_row dl_bv_benutzer%rowtype;
  begin
    pit.enter_detailed('copy_edit_ben');
  
    l_row.ben_id := utl_apex.get_number('ben_id');
    l_row.ben_ad := upper(utl_apex.get_string('ben_ad'));
    l_row.ben_stz := upper(utl_apex.get_string('ben_stz'));
    l_row.ben_anr_id := utl_apex.get_string('ben_anr_id');
    l_row.ben_tit_id := utl_apex.get_string('ben_tit_id');
    l_row.ben_vorname := utl_apex.get_string('ben_vorname');
    l_row.ben_nachname := utl_apex.get_string('ben_nachname');
    l_row.ben_email := utl_apex.get_string('ben_email');
    l_row.ben_telefon := utl_apex.get_string('ben_telefon');
    l_row.ben_gueltig_ab := utl_apex.get_date('ben_gueltig_ab');
    l_row.ben_gueltig_bis := utl_apex.get_date('ben_gueltig_bis');
  
    pit.leave_detailed;
    return l_row;
  end copy_edit_ben;
  
  
  function copy_edit_ben_rollen
    return dl_bv_benutzer_rolle%rowtype
  as
    l_row dl_bv_benutzer_rolle%rowtype;
  begin
    pit.enter_detailed('copy_edit_ben_rollen');
  
    l_row.bro_ben_id := coalesce(upper(utl_apex.get_string('bro_ben_id')), utl_apex.get_string('ben_id'));
    l_row.bro_anw_id := upper(utl_apex.get_string('bro_anw_id'));
    l_row.bro_rol_id := upper(utl_apex.get_string('bro_rol_id'));
    l_row.bro_gueltig_ab := utl_apex.get_date('bro_gueltig_ab');
    l_row.bro_gueltig_bis := utl_apex.get_date('bro_gueltig_bis');
  
    pit.leave_detailed;
    return l_row;
  end copy_edit_ben_rollen;
  
  
  function copy_edit_einfaache_rol
    return dl_bv_rolle_rolle%rowtype
  as  
    l_row dl_bv_rolle_rolle%rowtype;
  begin
    pit.enter_detailed('copy_edit_einfaache_rol');
  
    l_row.rro_anw_id := utl_apex.get_string('anw_id');
    
    utl_text.string_to_table(utl_apex.get_string('rol_rol_list'), g_rol_list);
  
    pit.leave_detailed;
    return l_row;
  end copy_edit_einfaache_rol;
  
  
  function copy_edit_rol
    return dl_bv_rolle%rowtype
  as
    l_row dl_bv_rolle%rowtype;
  begin
    pit.enter_detailed('copy_edit_rol');
  
    l_row.rol_id := utl_apex.get_string('rol_id');
    l_row.rol_anw_id := utl_apex.get_string('rol_anw_id');
    l_row.rol_name := utl_apex.get_string('rol_name');
    l_row.rol_beschreibung := utl_apex.get_string('rol_beschreibung');
    l_row.rol_aktiv := utl_apex.get_string('rol_aktiv');
    l_row.rol_sortierung := utl_apex.get_string('rol_sortierung');
  
    pit.leave_detailed;
    return l_row;
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
    l_row dl_bv_anwendung_art%rowtype;
  begin
    pit.enter_mandatory;
    
    -- l_row := copy_admin_aar;
    -- validation logic goes here. If it exists, uncomment COPY function
    
    pit.leave_mandatory;
    return true;
  end validiere_admin_aar;
  
  
  procedure verarbeite_admin_aar
  as
    l_row dl_bv_anwendung_art%rowtype;
  begin
    pit.enter_mandatory;
    
    l_row := copy_admin_aar;
    case when utl_apex.inserting or utl_apex.updating then
      bl_anw.merge_anwendung_art(l_row);
    else
      bl_anw.loesche_anwendung_art(l_row);
    end case;
    
    pit.leave_mandatory;
  end verarbeite_admin_aar;
  
  function validiere_admin_anr
    return boolean
  as
    l_row dl_bv_anwendung_art%rowtype;
  begin
    pit.enter_mandatory;
    
    -- l_row := copy_admin_anr;
    -- validation logic goes here. If it exists, uncomment COPY function
    
    pit.leave_mandatory;
    return true;
  end validiere_admin_anr;
  
  
  procedure verarbeite_admin_anr
  as
    l_row dl_bv_anwendung_art%rowtype;
  begin
    pit.enter_mandatory;
    
    l_row := copy_admin_anr;
    case when utl_apex.inserting or utl_apex.updating then
      bl_ben.merge_anrede(l_row);
    else
      bl_ben.loesche_anrede(l_row);
    end case;
    
    pit.leave_mandatory;
  end verarbeite_admin_anr;
  
  
  function validiere_admin_arf
    return boolean
  as
    l_row bv_ui_admin_arf%rowtype;
  begin
    --l_row := copy_admin_arf;
    return true;
  end validiere_admin_arf;
  
    
  function validiere_admin_anw
    return boolean 
  as
    l_row dl_bv_anwendung%rowtype;
  begin    
    pit.enter_mandatory;
    
    l_row := copy_admin_anw;       

    pit.start_message_collection;    
    bl_anw.validiere_anwendung(l_row);    
    pit.stop_message_collection;
    
    pit.leave_mandatory;
    return true;
  exception
    when msg.PIT_BULK_ERROR_ERR or msg.PIT_BULK_FATAL_ERR then
      utl_apex.handle_bulk_errors(char_table(
        'ERROR_CODE', 'ASSIGNED_ITEM'));
      return true;
  end validiere_admin_anw;
  

  procedure verarbeite_admin_anw
  as
    l_row dl_bv_anwendung%rowtype;
  begin
    pit.enter_mandatory;

    l_row := copy_admin_anw;

    if utl_apex.inserting or utl_apex.updating then  
      bl_anw.merge_anwendung(l_row);
    else
      bl_anw.loesche_anwendung(l_row);
    end if;

    pit.leave_mandatory;
  end verarbeite_admin_anw;
  
   
  procedure verarbeite_admin_arf
  as
    l_row bv_ui_admin_arf%rowtype;
  begin
    pit.enter_mandatory;
    
    l_row := copy_admin_arf;
    case 
    when utl_apex.inserting or utl_apex.updating then
      bl_anw.merge_anwendung_referenzen(
        p_anw_id => l_row.arf_anw_id,
        p_anw_id_list => l_row.arf_anw_id_list);
    when utl_apex.deleting then
      bl_anw.loesche_anwendung_referenzen(
        p_anw_id => l_row.arf_anw_id);
    else
      null;
    end case;  
    
    pit.leave_mandatory;
  end verarbeite_admin_arf;
  
  
  function validiere_admin_rec
    return boolean
  as
    l_row dl_bv_recht%rowtype;
  begin
    pit.enter_mandatory;
    
    -- l_row := copy_admin_rec;
    -- validation logic goes here. If it exists, uncomment COPY function
    
    pit.leave_mandatory;
    return true;
  end validiere_admin_rec;
  
  
  procedure verarbeite_admin_rec
  as
    l_row dl_bv_recht%rowtype;
  begin
    pit.enter_mandatory;
    
    l_row := copy_admin_rec;
    case when utl_apex.inserting or utl_apex.updating then
      bl_recht.merge_recht(l_row);
    else
      bl_recht.loesche_recht(l_row);
    end case;
    
    pit.leave_mandatory;
  end verarbeite_admin_rec;
  
   
  function validiere_admin_rol
    return boolean
  as
    l_row dl_bv_rolle%rowtype;
  begin
    -- l_row := copy_admin_rol;
    return null;
  end validiere_admin_rol;
  
  
  procedure verarbeite_admin_rol
  as
    l_row dl_bv_rolle%rowtype;
  begin
    pit.enter_mandatory;
    
    l_row := copy_admin_rol;
    case 
    when utl_apex.inserting or utl_apex.updating then
      bl_recht.merge_rolle(l_row);
    when utl_apex.deleting then
      bl_recht.loesche_rolle(l_row);
    else
      raise_application_error(-20000, apex_lang.message('UNKNOWN_REQUEST', v('REQUEST')));
    end case;
    
    pit.leave_mandatory;
  end verarbeite_admin_rol;
  
  
  
  function validiere_admin_tit
    return boolean
  as
    l_row dl_bv_titel%rowtype;
  begin
    pit.enter_mandatory;
    
    -- l_row := copy_admin_tit;
    -- validation logic goes here. If it exists, uncomment COPY function
    
    pit.leave_mandatory;
    return true;
  end validiere_admin_tit;
  
  
  procedure verarbeite_admin_tit
  as
    l_row dl_bv_titel%rowtype;
  begin
    pit.enter_mandatory;
    
    l_row := copy_admin_tit;
    case when utl_apex.inserting or utl_apex.updating then
      bl_ben.merge_titel(l_row);
    else
      bl_ben.loesche_titel(l_row);
    end case;
    
    pit.leave_mandatory;
  end verarbeite_admin_tit;
  
  
  procedure belege_edit_anw
  as
    l_row dl_bv_anwendung%rowtype;
  begin
    pit.enter_mandatory;
    
    l_row := copy_edit_anw;
    
    select coalesce(l_row.anw_name, logo_text),
           coalesce(l_row.anw_sortierung, 
                     (select max(trunc(anw_sortierung, -1)) + 10
                        from dl_bv_anwendung))
      into l_row.anw_name, l_row.anw_sortierung
      from apex_applications
     where alias = l_row.anw_id;
     
    utl_apex.set_value('P41_ANW_APEX_ALIAS', l_row.anw_id);
    utl_apex.set_value('P41_ANW_NAME', l_row.anw_name);
    utl_apex.set_value('P41_ANW_SORTIERUNG', l_row.anw_sortierung);
    
    pit.leave_mandatory;
  end belege_edit_anw;
  
  
  function validiere_edit_anw
    return boolean
  as
    l_row dl_bv_anwendung%rowtype;
  begin
    l_row :=copy_edit_anw;
    
    pit.start_message_collection;
    bl_anw.validiere_anwendung(l_row);
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
    l_row dl_bv_anwendung%rowtype;
  begin
    pit.enter_mandatory;
    
    l_row := copy_edit_anw;
    case 
    when utl_apex.inserting or utl_apex.updating then
      bl_anw.merge_anwendung(l_row);
    
      bl_recht.einfache_rollen_hierarchie(
        p_anw_id => l_row.anw_id,
        p_rol_hierarchie => g_rol_list);
        
    when utl_apex.deleting then
      bl_anw.loesche_anwendung(l_row);
    else
      null;
    end case;
    
    pit.leave_mandatory;
  end verarbeite_edit_anw;
  
  
  function validiere_edit_ben
    return boolean
  as
    l_row dl_bv_benutzer%rowtype;
  begin
    pit.enter_mandatory;
    
    l_row := copy_edit_ben;
    
    pit.start_message_collection;
    bl_ben.validiere_benutzer(l_row);
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
    l_row dl_bv_benutzer%rowtype;
  begin
    pit.enter_mandatory;
    
    l_row := copy_edit_ben;
    
    case
    when utl_apex.inserting or utl_apex.updating then
      bl_ben.merge_benutzer(l_row);
    when utl_apex.deleting then
      bl_ben.loesche_benutzer(l_row);
    else
      null;
    end case;  
    
    pit.leave_mandatory;
  end verarbeite_edit_ben;
  
  
  procedure verarbeite_edit_ben_rollen
  as
    l_row dl_bv_benutzer_rolle%rowtype;
  begin
    pit.enter_mandatory;
    
    l_row := copy_edit_ben_rollen;
    
    case
    when utl_apex.inserting or utl_apex.updating then
      bl_recht.rolle_zuweisen(l_row);
    when utl_apex.deleting then
      bl_recht.rolle_entziehen(l_row);
    else
      null;
    end case;  
    
    pit.leave_mandatory;
  end verarbeite_edit_ben_rollen;
  
  /** Verwaltung der Anwendungsseite EDIT_EINFACHE_ROL */
  function validiere_edit_einfache_rol
    return boolean
  as 
    l_rol dl_bv_rolle_rolle%rowtype;
  begin
    pit.enter_mandatory;
    
    --l_row := copy_edit_einfaache_rol;
    
    pit.leave_mandatory;
    return true;
  end validiere_edit_einfache_rol;
    
    
  procedure verarbeite_edit_einfache_rol
  as
    l_row dl_bv_rolle_rolle%rowtype;
  begin
    pit.enter_mandatory;
    
    l_row := copy_edit_einfaache_rol;
    
    bl_recht.merge_rolle_rolle(
      p_row => l_row,
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
    l_row dl_bv_rolle%rowtype;
  begin
    pit.enter_mandatory;
    
    l_row := copy_edit_rol;
    
    pit.start_message_collection;
    bl_recht.validiere_rolle(l_row);
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
    l_row dl_bv_rolle%rowtype;
  begin
    pit.enter_mandatory;
    
    l_row := copy_edit_rol;
    
    case
    when utl_apex.inserting or utl_apex.updating then
      bl_recht.merge_rolle(l_row);
    when utl_apex.deleting then
      bl_recht.loesche_rolle(l_row);
    else
      null;
    end case;  
    
    pit.leave_mandatory;
  end verarbeite_edit_rol;

end bv_ui;
/
