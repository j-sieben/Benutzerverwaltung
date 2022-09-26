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
    p_rec_id in dl_bv_recht.rec_id%type,
    p_anw_id in dl_bv_anwendung.anw_id%type default null)
    return boolean;
    
  
  /** Methode ermittelt, ob die aktuell referenzierte Anwendung eine komplexe Hierarchie besitzt
   * %param  p_anw_id  ID der Anwendung, die geprueft werden soll
   * %return Flag, das anzeigt, ob die Anwendung den Typ HIERARCHIE_KOMPLEX besitzt (TRUE) oder nicht (FALSE)
   * %usage  Wird als Bedingungspruefung von der Oberflaeche aufgerufen
   */
  function ist_komplexe_hierarchie(
    p_anw_id in dl_bv_anwendung.anw_id%type)
    return boolean;
    
    
  /** Methode liefert das Maximaldatum fuer unbegrenzt gueltige Datensaetze
   */
  function get_max_datum
    return date;
    
    
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
   
  /** Verwaltung der Anwendungsseite EDIT_ANW */ 
  /** Methode belegt Anwendungselemente bei Neuanlage/Aenderung der ANW_ID */
  procedure belege_edit_anw;
  
  
  function validiere_edit_anw
    return boolean;   
   
  procedure verarbeite_edit_anw;
  
  /** Verwaltung der Anwendungsseite EDIT_BEN */ 
  function validiere_edit_ben
    return boolean;
    
  procedure verarbeite_edit_ben;
    
  procedure verarbeite_edit_ben_rollen;
  
  /** Verwaltung der Anwendungsseite ADMIN_ROL */ 
  function validiere_edit_einfache_rol
    return boolean;
    
  procedure verarbeite_edit_einfache_rol;
  
  /** Verwaltung der Anwendungsseite AMDIN_KOMPLEXE_ROL */
  function validiere_edit_komplexe_rol
    return boolean;
  
  /** Verwaltung der Anwendungsseite EDIT_ROL */ 
  function validiere_edit_rol
    return boolean;
    
  procedure verarbeite_edit_rol;
    
  procedure verarbeite_edit_komplexe_rol;
end bv_ui;
/
