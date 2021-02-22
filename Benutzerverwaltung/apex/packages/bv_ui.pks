create or replace editionable package bv_ui 
  authid definer
as
  /* Verwaltung der APEX-Anwendung der Benutzerverwaltung
   * %ui
   */
   
  /* Methoden zur Autorisierung */
  /** Funktion zur Bestimmung, ob der aktuell angemeldete Benutzer ein
   * Anwendungsrecht besitzt oder nicht.
   * %param  p_rec_id  Anwendungsrecht
   * %param [p_anw_id] Bezeichnung der Anwendung (default: APP_ALIAS)
   * %return true, falls der Benutzer das Recht besitzt, false ansonsten
   * %raises Es werden keine Fehler geworfen, wird ein nicht vorhandenes Recht geprueft, liefert die Funktion NULL
   * %usage  Die Funktion wird in Authorisierungsprozessen verwendet, um ein gegebenes Recht zu pruefen 
   *         und damit Ressourcen der APEX-Anwendung freizugeben
   */
  function benutzer_hat_recht(
    p_rec_id in bv_recht.rec_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return boolean;
    
    
  /** Verwaltung der Anwendungsseite ADMIN_AAR */  
  function validiere_admin_aar
    return boolean;   
   
  procedure verarbeite_admin_aar;    
    
  /** Verwaltung der Anwendungsseite ADMIN_ANR */  
  function validiere_admin_anr
    return boolean;   
   
  procedure verarbeite_admin_anr;
   
  /** Verwaltung der Anwendungsseite ADMIN_ANW */  
  function validiere_admin_anw
    return boolean;   
   
  procedure verarbeite_admin_anw;
  
  /** Verwaltung der Anwendungsseite ADMIN_ARF */ 
  function validiere_admin_arf
    return boolean;
  
  procedure verarbeite_admin_arf;
  
  /** Verwaltung der Anwendungsseite ADMIN_REEC */ 
  function validiere_admin_rec
    return boolean;
  
  procedure verarbeite_admin_rec;
  
  /** Verwaltung der Anwendungsseite ADMIN_ROL */    
  function validiere_admin_rol
    return boolean;
    
  procedure verarbeite_admin_rol;
  
  /** Verwaltung der Anwendungsseite ADMIN_TIT */ 
  function validiere_admin_tit
    return boolean;
  
  procedure verarbeite_admin_tit;
  
  /** Verwaltung der Anwendungsseite ADMIN_BEN */ 
  function validiere_edit_ben
    return boolean;
    
  procedure verarbeite_edit_ben;
    
  procedure verarbeite_edit_ben_rollen;
  
  /** Verwaltung der Anwendungsseite ADMIN_ROL */  
  function get_hierarchie_url
    return varchar2;
  
  /** Verwaltung der Anwendungsseite AMDIN_EINFACHE_ROL */
  function validiere_admin_einfache_rol
    return boolean;
    
  procedure verarbeite_admin_einfache_rol;
end bv_ui;
/
