create or replace package body bv_recht_pkg
as
    
  /* Globale Variablen */
  g_app_alias bv_anwendung.anw_apex_alias%type := v('APP_ALIAS');

  /* INTERFACE */
  function benutzer_hat_recht(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_rec_id in bv_recht.rec_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return boolean
  as
    l_has_right bv_utils.flag_type;
  begin
    l_has_right := bl_recht.benutzer_hat_recht(
                     p_ben_ad => p_ben_ad, 
                     p_rec_id => p_rec_id, 
                     p_anw_id => coalesce(p_anw_id, g_app_alias));
    return l_has_right = bv_utils.c_true;
  end benutzer_hat_recht;
  
  
  function benutzer_ist(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_rol_id in bv_rolle.rol_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return boolean
  as
    l_is_user number;
  begin
    l_is_user := bl_recht.benutzer_ist(
                   p_ben_ad => p_ben_ad, 
                   p_rol_id => p_rol_id, 
                   p_anw_id => coalesce(p_anw_id, g_app_alias));
    return l_is_user = bv_utils.c_true;
  end benutzer_ist;


  function aktueller_benutzer_ist(
    p_rol_id in bv_rolle.rol_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return boolean
  as
  begin
    return benutzer_ist(
                   p_ben_ad => v('APP_USER'), 
                   p_rol_id => p_rol_id, 
                   p_anw_id => coalesce(p_anw_id, g_app_alias));
  end aktueller_benutzer_ist;

end bv_recht_pkg;
/
