--------------------------------------------------------
--  DDL for Package UTILS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "UTILS" 
authid definer
as
  /* Hilfspackage fuer Uility-Funktionen */

  /* Hilfsprozedur zur Erzeugung eines asynchronen Jobs
   * %param p_action PL/SQL-Anweisung, die durch den Job ausgefuehrt werden soll
   * %usage Die Prozedur fungiert als Wrapper um das Package APEX_PLSQL_JOB und
   *        gestattet die asynchrone uebermittlung von Jobs. Durch die Bindung an
   *        das APEX-Package ist folgendes Verhalten implementiert:
   *        {*} Das Package funktioniert nur im Umfeld valider APEX-Sessions
   *        {*} Durch die Bindung an DBMS_JOB (ueber das APEX-Package) wird der
   *            Job nur dann ausgefuehrt, wenn die Seite ein COMMIT absetzt.
   */
  procedure submit_job(
    p_action in varchar2);

  /* Funktion zur Umwandlung einer Zeichenkette in eine Tabelle von Werten
   * %param p_string Zeichenkette, die entlang von p_delimiter getrennt werden soll
   * %param p_delimiter Zeichen, das als Trennzeichen fuer eine Liste von Werten
   *        verwendet werden soll. Default ":", es sind aber auch mehrere Zeichen
   *        moeglich, etwa ", " (Komma und Leerzeichen), die dann allerdings
   *        gemeinsam als Trennzeichen verwendet werden und nicht alternativ.
   * %return Varchar2(4000), als Zeilen der Objekttabelle char_table.
   * %usage Die Funktion wird als Tabellenfunktion innerhalb einer SQL-Anweisung
   *        aufgerufen, um eine Liste von Werten innerhalb der Anweisung als
   *        Tabelle zu interpretieren.<br>
   *        Beispiel:
   *        <code>
   *select column_value
   *  from table(utils.string_to_table('A:B:C');
   *        </code>
   *        liefert die Werte A, B und C als Zeilen einer Tabelle mit dem
   *        Spaltenbezeichner COLUMN_VALUE.
   */
  function string_to_table(
    p_string in varchar2,
    p_delimiter in varchar2 default ':')
    return char_table
    pipelined;

end utils;

/