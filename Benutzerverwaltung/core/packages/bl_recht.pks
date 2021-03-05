create or replace package bl_recht
  authid definer
as
  /* Geschaeftslogik zur Verwaltung von Benutzerrechten und Rollen.
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
    p_ben_anr_id in bv_benutzer.ben_anr_id%type,
    p_ben_nachname in bv_benutzer.ben_nachname%type,
    p_ben_email in bv_benutzer.ben_email%type,
    p_ben_telefon in bv_benutzer.ben_telefon%type);


  /* Funktion zur Bestimmung, ob ein zu uebergebender Benutzer ein
   * Anwendungsrecht besitzt oder nicht.
   * %param  p_ben_ad  AD-(LDAP-)-Name des angemeldeten Benutzers (APP_USER)
   * %param  p_rec_id  Anwendungsrecht
   * %param  p_anw_id  Bezeichnung der Anwendung (optional, default: APP_ALIAS)
   * %return Flag, das anzeigt, ob der Benutzer ueber das Recht verfuegt (C_TRUE) oder nicht (C_FALSE).
   * %raises Es werden keine Fehler geworfen, wird ein nicht vorhandenes
   *         Recht oder ein nicht vorhandener Benutzer geprueft,
   *         liefert die Funktion NULL
   * %usage  Die Funktion wird nicht direkt genutzt, sondern den APEX-Anwendungen
   *         ueber das Wrapper-Package {%link BV_RECHT_PKG} zur Verfuegung gestellt.
   */
  function benutzer_hat_recht(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_rec_id in bv_recht.rec_id%type,
    p_anw_id in bv_anwendung.anw_id%type)
    return bv_utils.flag_type;


  /* Funktion zur Bestimmung, welche Rolle ein zu uebergebender Benutzer konkret zugewiesen bekommen hat.
   * Liefert bv_utils.C_FALSE, wenn die Rolle nicht direkt zugewiesen wurde, die zugewiesene Rolle die abgefragte Rolle aber beinhaltet.
   * %param  p_ben_ad  AD-(LDAP-)-Name des angemeldeten Benutzers (APP_USER)
   * %param  p_rec_id  Anwendungsrecht
   * %param  p_anw_id  Bezeichnung der Anwendung (optional, default: APP_ALIAS)
   * %return true, falls der Benutzer diese Rolle zugewiesen bekam, false ansonsten
   * %raises Keine, wird ein nicht vorhandenes Recht geprueft, liefert die Funktion NULL
   * %usage  Die Funktion wird nicht direkt genutzt, sondern den APEX-Anwendungen
   *         ueber das Wrapper-Package {%link BV_RECHT_PKG} zur Verfuegung gestellt.
   */
  function benutzer_ist(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_rol_id in bv_rolle.rol_id%type,
    p_anw_id in bv_anwendung.anw_id%type)
    return bv_utils.flag_type;


  /* Funktion zur Ausgabe einer Tabelle von Anwendungsnamen, die durch den angemeldeten Benutzer administriert werden
   * %param  p_ben_ad  AD-(LDAP-)-Name des angemeldeten Benutzers (APP_USER)
   * %param  p_anw_id  Bezeichnung der Anwendung (optional, default: APP_ALIAS)
   * %return Eine liste von Anwendungsnamen
   * %usage Die Funktion wird intern verwendet, um auf der APEX-Anwendung BV
   *        ein Auswahlmenue zu fuellen, das dem angemeldeten Benutzer eine Auswahl
   *        aller Anwendungen gibt, die durch ihn administriert werden duerfen.
   */
  function get_admin_anw(
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_anw_id in bv_anwendung.anw_id%type)
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
    p_row in bv_benutzer_recht%rowtype);
    

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
    p_ben_id in bv_benutzer.ben_id%type,
    p_rec_id in bv_rolle.rol_id%type,
    p_anw_id in bv_anwendung.anw_id%type);


  /* Prozedur zur Zuweisung einer Rolle an einen Benutzer
   * %param p_row Zeile der Tabelle {%link BV_BENUTZER_RECHT Tabelle der Benutzerrechte}
   * %usage Die Prozedur legt ein Benutzerrecht fuer einen Benutzer an. Sie erwartet
   *        einen Record vom Typ der Tabelle {%link BV_BENUTZER_ROLLE Tabelle der Benutzerrollen},
   *        legt eine entsprechende Zeile neu an und aktualisiert die Materialized View
   *        {%link BV_BENUTZER_RECHTE Materialized View zur Darstellung der aktuell
   *        zugewiesenen Benutzerrechte}
   */
  procedure rolle_zuweisen(
    p_row in bv_benutzer_rolle%rowtype);


  /* Prozedur zur Aktualisierung einer Rolle eines Benutzers
   * %param p_row Zeile der Tabelle {%link BV_BENUTZER_RECHT Tabelle der Benutzerrechte}
   * %usage Die Prozedur aktualisiert eine eines Benutzer an. Sie erwartet
   *        einen Record vom Typ der Tabelle {%link BV_BENUTZER_ROLLE Tabelle der Benutzerrollen},
   *        aktualisiert die Zeile und anschließend die Materialized View
   *        {%link BV_BENUTZER_RECHTE Materialized View zur Darstellung der aktuell
   *        zugewiesenen Benutzerrechte}
   */
  procedure rolle_aktualisieren(
    p_row in bv_benutzer_rolle%rowtype);


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
    p_ben_id in bv_benutzer.ben_id%type,
    p_rol_id in bv_rolle.rol_id%type,
    p_anw_id in bv_anwendung.anw_id%type);

  procedure rolle_entziehen(
    p_row in bv_benutzer_rolle%rowtype);

  /* Prozedur zur Aktualisierung der Materialized View {%link BV_BENUTZER_RECHTE
   *        Materialized View zur Darstellung der aktuell zugewiesenen Benutzerrechte}
   * %usage Die Prozedur wird lediglich intern verwendet und sollte nicht direkt
   *        aufgerufen werden.
   */
  procedure refresh_mv;
    
  
  /** Methode zur Verwaltung von Rollen
   * %param  p_row  Zeile der Tabelle BV_ROLLE
   * %usage  Wird verwendet, um eine Rolle anzulegen oder zu aendern.
   */
  procedure validiere_rolle(
    p_row in out nocopy bv_rolle%rowtype);
    
  procedure merge_rolle(
    p_row in out nocopy bv_rolle%rowtype);
    
  /** Ueberladung mit expliziten Parametern
   */
  procedure merge_rolle(
    p_rol_id in bv_rolle.rol_id%type,
    p_rol_anw_id in bv_rolle.rol_anw_id%type,
    p_rol_name in bv_rolle.rol_name%type,
    p_rol_beschreibung in bv_rolle.rol_beschreibung%type,
    p_rol_aktiv in bv_rolle.rol_aktiv%type,
    p_rol_sortierung in bv_rolle.rol_sortierung%type default null);
    
  /** Methode zum Loeschen einer Rolle
   * %param  p_row  Zeile der Tabelle BV_ROLLE
   */
  procedure loesche_rolle(
    p_row in bv_rolle%rowtype);
  
  
  /** Methode zur Verwaltung von Rechten
   * %param  p_row  Zeile der Tabelle BV_RECHT
   * %usage  Wird verwendet, um eine Rolle anzulegen oder zu aendern.
   */
  procedure merge_recht(
    p_row in out nocopy bv_recht%rowtype);
  
  /** Methode validiert ein Recht
   */
  procedure validiere_recht(
    p_row in out nocopy bv_recht%rowtype);
    
  /** Ueberladung mit expliziten Parametern
   */
  procedure merge_recht(
    p_rec_id in bv_recht.rec_id%type,
    p_rec_anw_id in bv_recht.rec_anw_id%type,
    p_rec_name in bv_recht.rec_name%type,
    p_rec_beschreibung in bv_recht.rec_beschreibung%type,
    p_rec_aktiv in bv_recht.rec_aktiv%type,
    p_rec_sortierung in bv_recht.rec_sortierung%type default null);
    
  /** Methode zum Loeschen eines Rechts
   * %param  p_row  Zeile der Tabelle BV_ROLLE
   */
  procedure loesche_recht(
    p_row in bv_recht%rowtype);
    
  
  /** Methode zur Zuweisung von Rechten zu Rollen
   * %param  p_row  Zeile der Tabelle BV_ROLLE_RECHT
   * %usage  Wird verwendet, um eine Rolle anzulegen oder zu aendern.
   */
  procedure merge_rolle_recht(
    p_row in out nocopy bv_rolle_recht%rowtype);
    
  /** Ueberladung mit expliziten Parametern
   */
  procedure merge_rolle_recht(
    p_rre_rol_id in bv_rolle_recht.rre_rol_id%type,
    p_rre_rec_id in bv_rolle_recht.rre_rec_id%type,
    p_rre_anw_id in bv_rolle_recht.rre_anw_id%type,
    p_rre_gueltig_ab in bv_rolle_recht.rre_gueltig_ab%type default null,
    p_rre_gueltig_bis in bv_rolle_recht.rre_gueltig_bis%type default null);
    
  /** Methode zum Loeschen einer Rechtezuordnung
   * %param  p_row  Zeile der Tabelle BV_ROLLE
   */
  procedure loesche_rolle_recht(
    p_row in bv_rolle_recht%rowtype);
    
  
  /** Methode zur Verwaltung von Rollenhierarchien
   * %param  p_row  Zeile der Tabelle BV_ROLLE_ROLLE
   * %usage  Wird verwendet, um eine Rolle anzulegen oder zu aendern.
   * %raises UTL_ITEM_IS_REQUIRED
   *         - Errorcode ROL_ID_MISSING, falls p_row.ROL_ID ist
   *         - Errorcode ROL_NAME_MISSING, falls p_row.ROL_NAME NULL ist
   *         - Errorcode ROL_ANW_ID_MISSING, falls p_row.ROL_ANW_ID ist
   *         BV_INVALID_BOOLEAN, falls nicht entweder bv_utils.C_TRUE oder bv_utils.C_FALSE fuer p_row.rol_aktiv uebergeben wurde
   *         INVALID_SQL_NAME, falls p_row.ROL_ID nicht den Oracle Namenskonventionen fuer einfache SQL Bezeichner entspricht
   *         BV_OBJECT_MISSING, falls p_row.ROL_ANW_ID nicht in BV_ANWENDUNG existiert
   */
  procedure validiere_rolle_rolle(
    p_row in bv_rolle_rolle%rowtype);    
  
  /** Methode erwartet eine einfache Rollenhierarchie (nur eine untergeordnete Rolle)
   * %param  p_row  Zeile der Tabelle BV_ROLLE_ROLLE
   * %usage  Wird verwendet, um einfache Rollenhierarchien aufzubauen
   */
  procedure merge_rolle_rolle(
    p_row in bv_rolle_rolle%rowtype);    
  
  /** Methode erwartet eine komplexe Rollenhierarchie (evtl. mehrere untergeordnete Rollen)
   * %param  p_row       Zeile der Tabelle BV_ROLLE_ROLLE
   * %param  p_rol_list  Liste der zuzuordnenden Rollen
   * %usage  Wird verwendet, um komplexe Rollenhierarchien aufzubauen
   */
  procedure merge_rolle_rolle(
    p_row in bv_rolle_rolle%rowtype,
    p_rol_list in char_table);
    
  /** Ueberladung mit expliziten Parametern, nur für Importzwecke
   */
  procedure merge_rolle_rolle(
    p_rro_rol_id in bv_rolle_rolle.rro_rol_id%type,
    p_rro_parent_rol_id in bv_rolle_rolle.rro_parent_rol_id%type,
    p_rro_anw_id in bv_rolle_rolle.rro_anw_id%type);
    
  /** Methode zum Loeschen einer Rollenhierarchie
   * %param  p_row  Zeile der Tabelle BV_ROLLE
   * %usage  Wird verwendet, um alle Eintraege einer Rollenhierarchie zu entfernen
   */
  procedure loesche_rolle_rolle(
    p_row in bv_rolle_rolle%rowtype);
    
    
  /** Methode zum Loeschen aller Rollen und Rechte einer Anwendung
   * %param  p_anw_id  ID der Anwendung, fuer die alle Rollen und Rechte geloescht werden sollen
   * %usage  Wird aus BL_ANW aufgerufen, wenn eine Anwendung geloescht werden soll
   */
  procedure loesche_anwendung_rollen(
    p_anw_id in bv_anwendung.anw_id%type);
    
  
  /** Methode uebernimmt eine Liste von Rollenzuordnungen und fuegt sie entsprechend
   *  der Vorgaben des Verfahrens EINFACHE_HIERARCHIE in die Basistabellen ein
   * %param  p_anw_id          ID der Anwedung, fuer die Rollenberechtigungen eingetragen werden sollen
   * %param  p_rol_hierarchie  Liste der Rollen, die hierarchisch angeordnet werden sollen
   * %usage  Stellt einen Weg zur Verfuegung, in einem Aufruf eine komplette, einfache Rollenhierarchie zu verwalten
   */
  procedure einfache_rollen_hierarchie(
    p_anw_id in bv_anwendung.anw_id%type,
    p_rol_hierarchie in char_table);
    
  
  /** Methode uebernimmt eine Liste von Rollenzuordnungen und fuegt sie entsprechend
   *  der Vorgaben des Verfahrens KOMPLEXE_HIERARCHIE in die Basistabellen ein
   * %param  p_anw_id             ID der Anwedung, fuer die Rollenberechtigungen eingetragen werden sollen
   * %param  p_rro_parent_rol_id  Liste der Rollen, die hierarchisch vorgesetzt angeordnet werden sollen
   * %param  p_rro_child_rol_id   Liste der Rollen, die hierarchisch untergeordnet werden sollen
   * %usage  Stellt einen Weg zur Verfuegung, in einem Aufruf eine komplette, komplexe Rollenhierarchie zu verwalten
   */
  procedure komplexe_rollen_hierarchie(
    p_anw_id in bv_anwendung.anw_id%type,
    p_rro_parent_rol_id in bv_rolle.rol_id%type,
    p_rro_child_rol_id in varchar2);

end bl_recht;
/
