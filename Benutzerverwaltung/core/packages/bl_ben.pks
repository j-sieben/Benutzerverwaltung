create or replace package bl_ben
  authid definer
as

  /** Methoden zur Verwaltung einer Anrede 
   */
  procedure validiere_anrede(
    p_row in out nocopy bv_anrede%rowtype);
    
  procedure merge_anrede(
    p_row in out nocopy bv_anrede%rowtype);
    
  procedure merge_anrede(
    p_anr_id bv_anrede.anr_id%type,
    p_anr_name bv_anrede.anr_name%type,
    p_anr_beschreibung bv_anrede.anr_beschreibung%type,
    p_anr_aktiv bv_anrede.anr_aktiv%type default null,
    p_anr_sortierung bv_anrede.anr_sortierung%type default null);
    
  procedure loesche_anrede(
    p_row in bv_anrede%rowtype);

  /** Methoden zur Verwaltung eines Titels
   */
  procedure validiere_titel(
    p_row in out nocopy bv_titel%rowtype);
    
  procedure merge_titel(
    p_row in out nocopy bv_titel%rowtype);
    
  procedure merge_titel(
    p_tit_id bv_titel.tit_id%type,
    p_tit_name bv_titel.tit_name%type,
    p_tit_beschreibung bv_titel.tit_beschreibung%type,
    p_tit_aktiv bv_titel.tit_aktiv%type default null,
    p_tit_sortierung bv_titel.tit_sortierung%type default null);
    
  procedure loesche_titel(
    p_row in bv_titel%rowtype);
    

  /** Methoden zur Verwaltung von Anwendungsbenutzern
   */
  /** Methode validiert einen Benutzer
   * %throws msg.PARAM_MISSING, Error Codes
   *         - BEN_EMAIL_MISSING, falls p_row.ben_email NULL ist
   *         - BEN_NACHNAME_MISSING, falls p_row.ben_nachname NULL ist
   *         - BEN_GUELTIG_BIS_MISSING, falls p_row.ben_gueltig_bis NULL ist
   */
  procedure validiere_benutzer(
    p_row in out nocopy bv_benutzer%rowtype);
  
  
  procedure merge_benutzer(
    p_row in out nocopy bv_benutzer%rowtype);
    
  procedure merge_benutzer(
    p_ben_id in out nocopy bv_benutzer.ben_id%type,
    p_ben_ad in bv_benutzer.ben_ad%type,
    p_ben_stz in bv_benutzer.ben_stz%type,
    p_ben_anr_id in bv_benutzer.ben_anr_id%type default null,
    p_ben_tit_id in bv_benutzer.ben_tit_id%type default null,
    p_ben_vorname in bv_benutzer.ben_vorname%type default null,
    p_ben_nachname in bv_benutzer.ben_nachname%type,
    p_ben_email in bv_benutzer.ben_email%type,
    p_ben_telefon in bv_benutzer.ben_telefon%type,
    p_ben_gueltig_ab in bv_benutzer.ben_gueltig_ab%type default null,
    p_ben_gueltig_bis in bv_benutzer.ben_gueltig_bis%type default null);
    
  procedure loesche_benutzer(
    p_row in out nocopy bv_benutzer%rowtype);

end bl_ben;
/