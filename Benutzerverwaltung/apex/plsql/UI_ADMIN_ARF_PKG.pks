--------------------------------------------------------
--  DDL for Package UI_ADMIN_ARF_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "UI_ADMIN_ARF_PKG" 
  authid definer
as
  /* Das Package verwaltet die UI-Views UI_ADMIN_ARF*
   * %ui
   * UI-Packages folgen der Konvention, eine
   * {*} insert
   * {*} update
   * {*} delete
   * -Metode anzubieten, die den entsprechenden SQL-Anweisungen entsprechen.
   * Ein Instead-Of-Trigger kann auf die View angelegt worden sein, um die
   * Spaltenwerte zu sammeln und als Record der Prozedur zu uebergeben.
   * Dies ist jedoch nicht erforderlich, entweder ist die View eine einfache
   * View und der Trigger daher nicht erforderlich, oder es wird kein Standard
   * APEX-Prozess fuer die DML-Operation verwendet, sondern eine dieser Prozeduren
   * direkt aus der APEX-Anwendung aufgerufen.
   */

  /*
   * Prozedur zum Einfuegen einer neuen Anwendungsreferenz
   * %param p_arf_anw_id Primaerschluessel: Anwendungs-ID
   * %param p_arf_anw_id_list ":"-separierte Liste der referenzierten Anwendungs-IDs
   * %usage Die Prozedur wird direkt von der APEX-Seite ADMIN_ARF aufgerufen, weil
            die View eine Gruppenfunktion enthaelt.<br>
   *        Die Prozedur fuegt fuer jede rerefenzierte Anwendung aus P_ARF_ANW_ID_LIST
   *        eine Anwendungsrefernz in die Tabelle BV_ANWENDUNG_REFERENZ ein
   */
  procedure insert_anwendung_referenz(
    p_arf_anw_id bv_anwendung.anw_id%type,
    p_arf_anw_id_list varchar2 default null);

  /*
   * Prozedur zur Aktualisierung von Anwendungsreferenzen
   * %param p_arf_anw_id Primaerschluessel: Anwendungs-ID
   * %param p_arf_anw_id_list ":"-separierte Liste der referenzierten Anwendungs-IDs
   * %usage Die Prozedur wird direkt von der APEX-Seite ADMIN_ARF aufgerufen, weil
            die View eine Gruppenfunktion enthaelt.<br>
   *        Die Prozedur loescht die bestehenden Anwendungsreferenzen und
   *        fuegt fuer jede rerefenzierte Anwendung aus P_ARF_ANW_ID_LIST
   *        eine Anwendungsrefernz in die Tabelle BV_ANWENDUNG_REFERENZ ein
   */
  procedure update_anwendung_referenz(
    p_arf_anw_id bv_anwendung.anw_id%type,
    p_arf_anw_id_list varchar2);

  /*
   * Prozedur zur Aktualisierung von Anwendungsreferenzen
   * %param p_arf_anw_id Primaerschluessel: Anwendungs-ID
   * %param p_arf_anw_id_list ":"-separierte Liste der referenzierten Anwendungs-IDs
   * %usage Die Prozedur wird direkt von der APEX-Seite ADMIN_ARF aufgerufen, weil
            die View eine Gruppenfunktion enthaelt.<br>
   *        Die Prozedur loescht die bestehenden Anwendungsreferenzen
   */
  procedure delete_anwendung_referenz(
    p_arf_anw_id bv_anwendung.anw_id%type);

end ui_admin_arf_pkg;

/
