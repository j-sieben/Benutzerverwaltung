--------------------------------------------------------
--  DDL for Package BV_RECHT_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "BV_RECHT_PKG" 
  authid definer
as
  /* Schnittstelle zu Anwendungsprogrammen
   * Dieses Package enthaelt lediglich Wrapper um andere Funktionalitaet
   * und dient dazu, anderen Programmen die Arbeit mit der Benutzerverwaltung
   * zu vereinfachen.
   */


  /* Funktion zur Bestimmung, ob der aktuell angemeldete Benutzer ein
   * Anwendungsrecht besitzt oder nicht.
   * %param p_rec_id Anwendungsrecht
   * %param p_anw_id Bezeichnung der Anwendung (optional, default: APP_ALIAS)
   * %return true, falls der Benutzer das Recht besitzt, false ansonsten
   * %raises Es werden keine Fehler geworfen, wird ein nicht vorhandenes
   *         Recht geprueft, liefert die Funktion NULL
   * %usage Die Funktion wird in Authorisierungsprozessen verwendet,
   *        um ein gegebenes Recht zu pruefen und damit Ressourcen der
   *        APEX-Anwendung freizugeben
   */
  function aktueller_benutzer_hat_recht(
    p_rec_id in bv_recht.rec_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return boolean;


  /* Funktion zur Bestimmung, welche Rolle der angemeldete Benutzer konkret
   * zugewiesen bekommen hat. Liefert 'N', wenn die Rolle nicht direkt zugewiesen
   * wurde, die zugewiesene Rolle die abgefragte Rolle aber beinhaltet.
   * %param p_rec_id Anwendungsrecht
   * %param p_anw_id Bezeichnung der Anwendung (optional, default: APP_ALIAS)
   * %return true, falls der Benutzer diese Rolle zugewiesen bekam, false ansonsten
   * %raises Es werden keine Fehler geworfen, wird ein nicht vorhandenes
   *         Recht geprueft, liefert die Funktion NULL
   * %usage Die Funktion wird in Authorisierungsprozessen verwendet,
   *        um ein gegebenes Recht zu pruefen und damit Ressourcen der
   *        APEX-Anwendung freizugeben
   */
  function aktueller_benutzer_ist(
    p_rol_id in bv_rolle.rol_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return boolean;


  /* Funktion zur Bestimmung, ob ein zu uebergebender Benutzer ein
   * Anwendungsrecht besitzt oder nicht.
   * %param p_ben_ad AD-(LDAP-)-Name des angemeldeten Benutzers (APP_USER)
   * %param p_rec_id Anwendungsrecht
   * %param p_anw_id Bezeichnung der Anwendung (optional, default: APP_ALIAS)
   * %raises Es werden keine Fehler geworfen, wird ein nicht vorhandenes
   *         Recht oder ein nicht vorhandener Benutzer geprueft,
   *         liefert die Funktion NULL
   * %usage Die Funktion wird in Authorisierungsprozessen verwendet,
   *        um ein gegebenes Recht zu pruefen und damit Ressourcen der
   *        APEX-Anwendung freizugeben. Die Variante mit explizitem Benutzer
   *        dient dazu, Administrationsanwendungen zu realisieren, wird aber
   *        normalerweise nicht benoetigt.
   */
  function benutzer_hat_recht(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_rec_id in bv_recht.rec_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return boolean;


  /* Funktion zur Bestimmung, welche Rolle ein zu uebergebender Benutzer konkret
   * zugewiesen bekommen hat. Liefert 'N', wenn die Rolle nicht direkt zugewiesen
   * wurde, die zugewiesene Rolle die abgefragte Rolle aber beinhaltet.
   * %param p_rec_id Anwendungsrecht
   * %param p_anw_id Bezeichnung der Anwendung (optional, default: APP_ALIAS)
   * %return true, falls der Benutzer diese Rolle zugewiesen bekam, false ansonsten
   * %raises Es werden keine Fehler geworfen, wird ein nicht vorhandenes
   *         Recht geprueft, liefert die Funktion NULL
   * %usage Die Funktion wird in Authorisierungsprozessen verwendet,
   *        um ein gegebenes Recht zu pruefen und damit Ressourcen der
   *        APEX-Anwendung freizugeben. Die Variante mit explizitem Benutzer
   *        dient dazu, Administrationsanwendungen zu realisieren, wird aber
   *        normalerweise nicht benoetigt.
   */
  function benutzer_ist(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_rol_id in bv_rolle.rol_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return boolean;

end bv_recht_pkg;

/
