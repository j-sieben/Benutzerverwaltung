create or replace editionable package bl_anw 
  authid definer
as

  /** Geschaeftslogik zur Verwaltung von Anwendungen.
   * %bl
   * Das Package implementiert die Geschaeftsregeln zur Verwaltung von Anwendungen
   * und stellt diese den UI-Packages zur Verfuegung.
   */
   
  /** Methoden zur Verwaltung von Anwendungsarten
   */
  procedure validiere_anwendung_art(
    p_row in out nocopy bv_anwendung_art%rowtype);
    
  procedure merge_anwendung_art(
    p_row in out nocopy bv_anwendung_art%rowtype);
    
  procedure merge_anwendung_art(
    p_aar_id bv_anwendung_art.aar_id%type,
    p_aar_name bv_anwendung_art.aar_name%type,
    p_aar_beschreibung bv_anwendung_art.aar_beschreibung%type,
    p_aar_aktiv bv_anwendung_art.aar_aktiv%type default null,
    p_aar_sortierung bv_anwendung_art.aar_sortierung%type default null);
    
  procedure loesche_anwendung_art(
    p_row in bv_anwendung_art%rowtype);

  /** Methoden zur Verwaltung von Anwendungen
   */
  /** Validierung der Daten einer Anwendung
   * %raises UTL_ITEM_IS_REQUIRED
   *         - ANW_ID_MISSING, falls p_row.ANW_ID NULL ist
   *         - Errorcode ANW_AAR_ID_MISSING, falls p_row.ANW_AAR_ID NULL ist
   *         - Errorcode ANW_APEX_ALIAS_MISSING, falls p_row.ANW_APEX_ALIAS NULL ist
   *         BV_OBJECT_MISSING, falls p_row.ANW_ID nicht als APEX-Anwendung mit entsprechendem Alias existiert
   *         INVALID_SCHEMA, falls p_row.ANW_SCHEMA nicht existiert
   *         BV_INVALID_BOOLEAN, falls nicht entweder bv_utils.C_TRUE oder bv_utils.C_FALSE fuer p_row.anw_aktiv uebergeben wurde
   */
  procedure validiere_anwendung(
    p_row in out nocopy  bv_anwendung%rowtype);
    
  /**
   * Prozedur zum Einfuegen einer neuen Anwendung
   * %param  p_row  Zeile der Tabelle BV_ANWENDUNG
   * %usage  Die Prozedur wird voUI-Packages aufgerufen.<br>
   *         Die Prozedur fuegt eine Anwendung in die Tabelle BV_ANWENDUNG ein und
   *         legt folgende weitere Einstellungen fest:
   *         {*} Anwendungsreferenz Es wird eine Referenz der Anwendung auf sich selbst angelegt, um
   *             mindestens die Rechte dieser Anwendung in den Rechte-Views anzuzeigen
   *         {*} Anwendungsrecht Es wird ein Recht APP_<Alias der Anwendung> angelegt, dass die
   *             Administration der Rechte fuer diese Anwendung erlaubt.
   *         {*} Rollen Bei einfachen und komplexen Hierarchien wird eine Rolle mit einer
   *             1:1-Zuweisung auf dieses Anwendungsrecht erstellt (In diesen
   *             Anwendungsarten enstpricht ein Recht einer Rolle)
   *         {*} Rechte-Views Die Prozedur veranlasst die (asynchrone) Erstellung der Rechte-Views
   *             {%link CREATE_ANW_VIEWS Erzeugung der Rechte-Views}
   */
  procedure merge_anwendung(
    p_row in out nocopy bv_anwendung%rowtype);

  /**
   * Prozedur zum Aktualisierung einer Anwendung
   * %param  p_anww_id           Eindeutige ID der Anwendung
   * %param  p_anw_apex_alias    Alias der Anwendung
   * %param  p_anw_schema        Workspace-Schema der Anwendung
   * %param  p_anw_aar_id        Anwendungsart, Referenz auf BV_ANWENDUNG_ART
   * %param  p_anw_name          Name der Anwendung
   * %param  p_anw_beschreibung  Beschreibung der Anwendung
   * %param  p_anw_aktiv         Flag, das anzeigt, ob die Anwendung aktuell verwaltet wird
   * %param  p_anw_sortierung    Sortierung der Anwendung zur Darstellung auf der Oberflaeche
   * %usage  Ueberladung mit expliziten Parametern
   */
  procedure merge_anwendung(
    p_anw_id in bv_anwendung.anw_id%type,
    p_anw_apex_alias bv_anwendung.anw_apex_alias%type,
    p_anw_schema bv_anwendung.anw_schema%type,
    p_anw_aar_id bv_anwendung.anw_aar_id%type,
    p_anw_name bv_anwendung.anw_name%type,
    p_anw_beschreibung bv_anwendung.anw_beschreibung%type,
    p_anw_aktiv bv_anwendung.anw_aktiv%type,
    p_anw_sortierung bv_anwendung.anw_sortierung%type);

  /**
   * Prozedur zum Loeschen einer Anwendung
   * %param  p_row  Zeile der Tabelle BV_ANWENDUNG
   * %usage  Die Prozedur wird vom Trigger TRG_UI_ADMIN_ANW_IOT aufgerufen, wenn
   *         eine update-Anweisung auf die View ausgefuehrt wird.<br>
   *         Beim Loeschen einer Anwendung werden die zugehoerigen Rechte, Rollen
   *         und die Zuweisung dieser Rollen entfernt, ebenso wie die Stammdaten,
   *         bestehend aus Anwendungsrollen, -rechten etc.
   */
  procedure loesche_anwendung(
    p_row bv_anwendung%rowtype);

  /** Prozedur zur Erstellung der Rechte-Views
   * %param  p_anw_id  Technische ID der Anwendung (APP_ALIAS)
   * %usage  Die Prozedur erwartet eine Anwendungs-ID und erstellt folgende Views:
   *         {*} #APP_ALIAS#_BV_BENUTZER_RECHTE Zentrale View, die fuer eine Anwendung
   *             (oder genauer: Einer Gruppe von Anwendungsreferenzen) alle zugeordneten
   *             Rechte darstellt. Diese View enthaelt alle Rechte aller Benutzer auf dieser
   *             oder den durch diese Anwendung referenzierten Anwendungen.
   *         {*} <b>#APP_ALIAS#_BV_BENUTZER Liste der Benutzer, die fuer diese
   *             Anwendung Rechte besitzen.
   *         {*} #APP_ALIAS#_BV_RECHT Liste der Rechte dieser Anwendung.
   *         {*} #APP_ALIAS#_BV_ROLLE Liste der Rollen dieser Anwendung.
   *         Zusaetzlich wird dem Eigentuemer der Anwendung ein select- und references-Recht
   *         auf diese Views eingeraeumt. Anschließend erteilt die Prozedur ein
   *         execute-Recht auf das Package {%link BV_BENUTZER_RECHT}, um der Anwendung
   *         die einfache Pruefung eines Benutzerrechts zu ermoeglichen.
   */
  procedure create_anw_views(
    p_anw_id in varchar2);

  /** Prozedur zum Loeschen der Rechte-Views
   * %param  p_anw_id Technische ID der Anwendung (APP_ALIAS)
   * %usage  Die Prozedur entfernt die Rechte-Views und entzieht das execute-Recht
   *         auf das Package {%link BV_BENUTZER_RECHT} vom Eigentuemer der Anwendung.
   */
  procedure drop_anw_views(
    p_anw_id in varchar2);
    
    
  /** Methode zur Verwaltung von Anwendungsreferenzen
   * %param  p_anw_id       Die zu referenzierende Anwendung
   * %param  p_anw_id_list  Liste von ANwendungsreferenzen
   * %usage  Anwendungsreferenzen erstellen eine Hierarchie von Anwendungen, fuer die
   *         Berechtigungskonzepte verwaltet werden sollen.
   */
  procedure merge_anwendung_referenzen(
    p_anw_id  bv_anwendung.anw_id%type,
    p_anw_id_list varchar2);
    
    
  /** Methode zum Entfernen von Anwendungsreferenzen
   * %param  p_anw_id       Die zu referenzierende Anwendung
   * %usage  Wird verwendet, um alle Anwendungsreferenzen auf eine Anwendung zu entfernen
   */
  procedure loesche_anwendung_referenzen(
    p_anw_id  bv_anwendung.anw_id%type);

end bl_anw;
/
