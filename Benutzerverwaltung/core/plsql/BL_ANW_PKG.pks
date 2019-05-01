--------------------------------------------------------
--  DDL for Package BL_ANW_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "BL_ANW_PKG" 
  authid definer
as
  /* Geschaeftslogik zur Verwaltung von Anwendungen.
   * %bl
   * Das Package implementiert die Geschaeftsregeln zur Verwaltung von Anwendungen
   * und stellt diese den UI-Packages zur Verfuegung.
   */

  /*
   * Prozedur zum Einfuegen einer neuen Anwendung
   * %param p_row Zeile der Tabelle BV_ANWENDUNG
   * %usage Die Prozedur wird voUI-Packages aufgerufen.<br>
   *        Die Prozedur fuegt eine Anwendung in die Tabelle BV_ANWENDUNG ein und
   *        legt folgende weitere Einstellungen fest:
   *        {*} Anwendungsreferenz Es wird eine Referenz der Anwendung auf sich selbst angelegt, um
   *            mindestens die Rechte dieser Anwendung in den Rechte-Views anzuzeigen
   *        {*} Anwendungsrecht Es wird ein Recht APP_<Alias der Anwendung> angelegt, dass die
   *            Administration der Rechte fuer diese Anwendung erlaubt.
   *        {*} Rollen Bei einfachen und komplexen Hierarchien wird eine Rolle mit einer
   *            1:1-Zuweisung auf dieses Anwendungsrecht erstellt (In diesen
   *            Anwendungsarten enstpricht ein Recht einer Rolle)
   *        {*} Rechte-Views Die Prozedur veranlasst die (asynchrone) Erstellung der Rechte-Views
   *            {%link CREATE_ANW_VIEWS Erzeugung der Rechte-Views}
   */
  procedure create_anwendung(
    p_row bv_anwendung%rowtype);

  /*
   * Prozedur zum Aktualisierung einer Anwendung
   * %param p_row Zeile der View UI_ADMIN_ANW
   * %usage Die Prozedur wird vom Trigger TRG_UI_ADMIN_ANW_IOT aufgerufen, wenn
   *        eine update-Anweisung auf die View ausgefuehrt wird.<br>
   *        Derzeit aktualisiert die Prozedur lediglich die Parameter
   *        {*} Anwendungsart (ANW_AAR_ID)
   *        {*} Anwendungsname (ANW_NAME)
   *        {*} Anwednungsbeschreibung (ANW_BESCHREIBUNG)
   *        {*} Aktivitaetsflag (ANW_AKTIV)
   *        {*} Sortierung der Anwendung (ANW_SORTIERUNG)
   */
  procedure alter_anwendung(
    p_row bv_anwendung%rowtype);

  /*
   * Prozedur zum Aktualisierung einer Anwendung
   * %param p_row Zeile der View UI_ADMIN_ANW
   * %usage Die Prozedur wird vom Trigger TRG_UI_ADMIN_ANW_IOT aufgerufen, wenn
   *        eine update-Anweisung auf die View ausgefuehrt wird.<br>
   *        Beim Loeschen einer Anwendung werden die zugehoerigen Rechte, Rollen
   *        und die Zuweisung dieser Rollen entfernt, ebenso wie die Stammdaten,
   *        bestehend aus Anwendungsrollen, -rechten etc.
   */
  procedure drop_anwendung(
    p_row bv_anwendung%rowtype);

  /* Prozedur zur Erstellung der Rechte-Views
   * %param p_anw_id Technische ID der Anwendung (APP_ALIAS)
   * %usage Die Prozedur erwartet eine Anwendungs-ID und erstellt folgende Views:
   *        {*} #APP_ALIAS#_BV_BENUTZER_RECHTE Zentrale View, die fuer eine Anwendung
   *            (oder genauer: Einer Gruppe von Anwendungsreferenzen) alle zugeordneten
   *            Rechte darstellt. Diese View enthaelt alle Rechte aller Benutzer auf dieser
   *            oder den durch diese Anwendung referenzierten Anwendungen.
   *        {*} <b>#APP_ALIAS#_BV_BENUTZER Liste der Benutzer, die fuer diese
   *            Anwendung Rechte besitzen.
   *        {*} #APP_ALIAS#_BV_RECHT Liste der Rechte dieser Anwendung.
   *        {*} #APP_ALIAS#_BV_ROLLE Liste der Rollen dieser Anwendung.
   *        Zusaetzlich wird dem Eigentuemer der Anwendung ein select- und references-Recht
   *        auf diese Views eingeraeumt. Anschließend erteilt die Prozedur ein
   *        execute-Recht auf das Package {%link BV_BENUTZER_RECHT}, um der Anwendung
   *        die einfache Pruefung eines Benutzerrechts zu ermoeglichen.
   */
  procedure create_anw_views(
    p_anw_id in varchar2);

  /* Prozedur zum Loeschen der Rechte-Views
   * %param p_anw_id Technische ID der Anwendung (APP_ALIAS)
   * %usage Die Prozedur entfernt die Rechte-Views und entzieht das execute-Recht
   *        auf das Package {%link BV_BENUTZER_RECHT} vom Eigentuemer der Anwendung.
   */
  procedure drop_anw_views(
    p_anw_id in varchar2);
    
  
  procedure merge_rolle(
    p_row in bv_rolle%rowtype);
    
    
  procedure delete_rolle(
    p_row in bv_rolle%rowtype);
  
  
  procedure merge_recht(
    p_row in bv_recht%rowtype);
    
  
  procedure delete_recht(
    p_row in bv_recht%rowtype);
    
    
  procedure merge_rolle_recht(
    p_row in bv_rolle_recht%rowtype);
    
    
  procedure delete_rolle_recht(
    p_row in bv_rolle_recht%rowtype);
    
  
  procedure merge_rolle_rolle(
    p_row in bv_rolle_rolle%rowtype);
    
  
  procedure delete_rolle_rolle(
    p_row in bv_rolle_rolle%rowtype);
    
  
  procedure einfache_rollen_hierarchie(
    p_anw_id in bv_anwendung.anw_id%type,
    p_rol_hierarchie in varchar2);

end bl_anw_pkg;

/
