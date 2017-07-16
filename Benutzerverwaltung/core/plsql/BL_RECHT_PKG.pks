--------------------------------------------------------
--  DDL for Package BL_RECHT_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "BL_RECHT_PKG" 
  authid definer
as
  /* Geschaeftslogik zur Verwaltung von Benutzerrechten.
   * %bl
   * Das Package implementiert die Geschaeftsregeln zur Verwaltung von Benutzerrechten
   * und stellt diese den UI-Packages zur Verfuegung. Der Begriff <i>Recht</i>
   * umfasst in diesem Zusammenhang auch die administrativen Strukturen, die
   * verwendet werden, um die Rechtevergabe zu vereinfachen, wie Rollen und
   * Rollenhierarchien.
   */

  /* Interne Prozedur zur initialen Anlage eines Super-Administrators
   * %param p_ben_ad AD-Name des Benutzers
   * %param p_ben_stz Stellenzeichen des Benutzers
   * %param p_anr_id Anrede-ID des Benutzers,
   * %param p_ben_nachname Nachname des Benutzers
   * %param p_ben_email EMail-Adresse des Benutzers
   * %param p_ben_telefon Telefon des Benutzers
   * %usage Die Prozedur wid ausschließlich ueber einen Skript aufgerufen und
   *        nicht ueber die Oberflaeche. Der Benutzer muss initial angelegt werden,
   *        um die Benutzerverwaltung bedienbar zu machen.
   */
  procedure create_super_admin(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_ben_stz in bv_benutzer.ben_stz%type,
    p_anr_id in bv_anrede.anr_id%type,
    p_ben_nachname in bv_benutzer.ben_nachname%type,
    p_ben_email in bv_benutzer.ben_email%type,
    p_ben_telefon in bv_benutzer.ben_telefon%type);


  /* Funktion zur Bestimmung, ob der aktuell angemeldete Benutzer ein
   * Anwendungsrecht besitzt oder nicht.
   * %param p_rec_id Anwendungsrecht
   * %param p_anw_id Bezeichnung der Anwendung (optional, default: APP_ALIAS)
   * %return true, falls der Benutzer das Recht besitzt, false ansonsten
   * %raises Es werden keine Fehler geworfen, wird ein nicht vorhandenes
   *         Recht geprueft, liefert die Funktion NULL
   * %usage Die Funktion wird nicht direkt genutzt, sondern den APEX-Anwendungen
   *        ueber das Wrapper-Package {%link BV_RECHT_PKG} zur Verfuegung gestellt.
   */
  function aktueller_benutzer_hat_recht(
    p_rec_id in bv_recht.rec_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return varchar2;


  /* Funktion zur Bestimmung, welche Rolle der angemeldete Benutzer konkret
   * zugewiesen bekommen hat. Liefert 'N', wenn die Rolle nicht direkt zugewiesen
   * wurde, die zugewiesene Rolle die abgefragte Rolle aber beinhaltet.
   * %param p_rec_id Anwendungsrecht
   * %param p_anw_id Bezeichnung der Anwendung (optional, default: APP_ALIAS)
   * %return true, falls der Benutzer diese Rolle zugewiesen bekam, false ansonsten
   * %raises Es werden keine Fehler geworfen, wird ein nicht vorhandenes
   *         Recht geprueft, liefert die Funktion NULL
   * %usage Die Funktion wird nicht direkt genutzt, sondern den APEX-Anwendungen
   *        ueber das Wrapper-Package {%link BV_RECHT_PKG} zur Verfuegung gestellt.
   */
  function aktueller_benutzer_ist(
    p_rol_id in bv_rolle.rol_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return varchar2;


  /* Funktion zur Bestimmung, ob ein zu uebergebender Benutzer ein
   * Anwendungsrecht besitzt oder nicht.
   * %param p_ben_ad AD-(LDAP-)-Name des angemeldeten Benutzers (APP_USER)
   * %param p_rec_id Anwendungsrecht
   * %param p_anw_id Bezeichnung der Anwendung (optional, default: APP_ALIAS)
   * %raises Es werden keine Fehler geworfen, wird ein nicht vorhandenes
   *         Recht oder ein nicht vorhandener Benutzer geprueft,
   *         liefert die Funktion NULL
   * %usage Die Funktion wird nicht direkt genutzt, sondern den APEX-Anwendungen
   *        ueber das Wrapper-Package {%link BV_RECHT_PKG} zur Verfuegung gestellt.
   */
  function benutzer_hat_recht(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_rec_id in bv_recht.rec_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return varchar2;


  /* Funktion zur Bestimmung, welche Rolle ein zu uebergebender Benutzer konkret
   * zugewiesen bekommen hat. Liefert 'N', wenn die Rolle nicht direkt zugewiesen
   * wurde, die zugewiesene Rolle die abgefragte Rolle aber beinhaltet.
   * %param p_rec_id Anwendungsrecht
   * %param p_anw_id Bezeichnung der Anwendung (optional, default: APP_ALIAS)
   * %return true, falls der Benutzer diese Rolle zugewiesen bekam, false ansonsten
   * %raises Es werden keine Fehler geworfen, wird ein nicht vorhandenes
   *         Recht geprueft, liefert die Funktion NULL
   * %usage Die Funktion wird nicht direkt genutzt, sondern den APEX-Anwendungen
   *        ueber das Wrapper-Package {%link BV_RECHT_PKG} zur Verfuegung gestellt.
   */
  function benutzer_ist(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_rol_id in bv_rolle.rol_id%type,
    p_anw_id in bv_anwendung.anw_id%type default null)
    return varchar2;


  /* Funktion zur Ausgabe einer Tabelle von Anwendungsnamen, die durch den angemeldeten
   * Benutzer administriert werden
   * %return Eine liste von Anwendungsnamen
   * %usage Die Funktion wird intern verwendet, um auf der APEX-Anwendung BV
   *        ein Auswahlmenue zu fuellen, das dem angemeldeten Benutzer eine Auswahl
   *        aller Anwendungen gibt, die durch ihn administriert werden duerfen.
   */
  function get_admin_anw
    return char_table
    pipelined;

  /* Prozedur zur Zuweisung eines Benutzerrechts an einen Benutzer
   * %param p_row Zeile der Tabelle {%link BV_BENUTZER_RECHT Tabelle der Benutzerrechte}
   * %usage Die Prozedur legt ein Benutzerrecht fuer einen Benutzer an. Sie erwartet
   *        einen Record vom Typ der Tabelle {%link BV_BENUTZER_RECHT Tabelle der Benutzerrechte},
   *        legt eine entsprechende Zeile neu an und aktualisiert die Materialized View
   *        {%link BV_BENUTZER_RECHTE Materialized View zur Darstellung der aktuell
   *        zugewiesenen Benutzerrechte}
   */
  procedure recht_zuweisen(
    p_row bv_benutzer_recht%rowtype);

  /* Prozedur zum Entziehen eines Benutzerrechts
   * %param p_ben_id Technische ID des Benutzers
   * %param p_rec_id Technische ID des Rechts
   * %param p_anw_id Technische ID der Anwendung
   * %usage Die Prozedur loescht eine Zeile aus der Tabelle {%link BV_BENUTZER_RECHT
   *        Tabelle der Benutzerrechte} und aktualisiert die Materialized View
   *        {%link BV_BENUTZER_RECHTE Materialized View zur Darstellung der aktuell
   *        zugewiesenen Benutzerrechte}
   */
  procedure recht_entziehen(
    p_ben_id bv_benutzer.ben_id%type,
    p_rec_id bv_rolle.rol_id%type,
    p_anw_id bv_anwendung.anw_id%type);


  /* Prozedur zur Zuweisung einer Rolle an einen Benutzer
   * %param p_row Zeile der Tabelle {%link BV_BENUTZER_RECHT Tabelle der Benutzerrechte}
   * %usage Die Prozedur legt ein Benutzerrecht fuer einen Benutzer an. Sie erwartet
   *        einen Record vom Typ der Tabelle {%link BV_BENUTZER_ROLLE Tabelle der Benutzerrollen},
   *        legt eine entsprechende Zeile neu an und aktualisiert die Materialized View
   *        {%link BV_BENUTZER_RECHTE Materialized View zur Darstellung der aktuell
   *        zugewiesenen Benutzerrechte}
   */
  procedure rolle_zuweisen(
    p_row bv_benutzer_rolle%rowtype);


  /* Prozedur zur Aktualisierung einer Rolle eines Benutzers
   * %param p_row Zeile der Tabelle {%link BV_BENUTZER_RECHT Tabelle der Benutzerrechte}
   * %usage Die Prozedur aktualisiert eine eines Benutzer an. Sie erwartet
   *        einen Record vom Typ der Tabelle {%link BV_BENUTZER_ROLLE Tabelle der Benutzerrollen},
   *        aktualisiert die Zeile und anschließend die Materialized View
   *        {%link BV_BENUTZER_RECHTE Materialized View zur Darstellung der aktuell
   *        zugewiesenen Benutzerrechte}
   */
  procedure rolle_aktualisieren(
    p_row bv_benutzer_rolle%rowtype);


  /* Prozedur zum Entziehen einer Rolle von einem Benutzer
   * %param p_ben_id Technische ID des Benutzers
   * %param p_rol_id Technische ID der Rolle
   * %param p_anw_id Technische ID der Anwendung
   * %usage Die Prozedur loescht eine Zeile aus der Tabelle {%link BV_BENUTZER_ROLLE
   *        Tabelle der Benutzerrollen} und aktualisiert die Materialized View
   *        {%link BV_BENUTZER_RECHTE Materialized View zur Darstellung der aktuell
   *        zugewiesenen Benutzerrechte}
   */
  procedure rolle_entziehen(
    p_ben_id bv_benutzer.ben_id%type,
    p_rol_id bv_rolle.rol_id%type,
    p_anw_id bv_anwendung.anw_id%type);
    
  procedure rolle_entziehen(
    p_row bv_benutzer_rolle%rowtype);

  /* Prozedur zur Aktualisierung der Materialized View {%link BV_BENUTZER_RECHTE
   *        Materialized View zur Darstellung der aktuell zugewiesenen Benutzerrechte}
   * %usage Die Prozedur wird lediglich intern verwendet und sollte nicht direkt
   *        aufgerufen werden.
   */
  procedure refresh_mv;

end bl_recht_pkg;

/
