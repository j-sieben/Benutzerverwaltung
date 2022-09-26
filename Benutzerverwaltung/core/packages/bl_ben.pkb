create or replace package body bl_ben
as

  procedure validiere_anrede(
    p_row in out nocopy bv_anrede%rowtype)
  as
  begin
    p_row.anr_id := dbms_assert.simple_sql_name(p_row.anr_id);
  end validiere_anrede;
  

  procedure merge_anrede(
    p_row in out nocopy bv_anrede%rowtype)
  as
  begin
    -- Initialisierung
    p_row.anr_id := upper(p_row.anr_id);
    p_row.anr_aktiv := coalesce(upper(p_row.anr_aktiv), bv_utils.C_FALSE);
    
    validiere_anrede(p_row);
    
    merge into bv_anrede t
    using (select p_row.anr_id anr_id,
                  p_row.anr_name anr_name,
                  p_row.anr_beschreibung anr_beschreibung,
                  p_row.anr_aktiv anr_aktiv,
                  p_row.anr_sortierung anr_sortierung
             from dual) s
       on (t.anr_id = s.anr_id)
     when matched then update set
          t.anr_name = s.anr_name,
          t.anr_beschreibung = s.anr_beschreibung,
          t.anr_aktiv = s.anr_aktiv,
          t.anr_sortierung = s.anr_sortierung
     when not matched then insert (anr_id, anr_name, anr_beschreibung, anr_aktiv, anr_sortierung)
          values (s.anr_id, s.anr_name, s.anr_beschreibung, s.anr_aktiv, s.anr_sortierung);
  end merge_anrede;
  
    
  procedure merge_anrede(
    p_anr_id bv_anrede.anr_id%type,
    p_anr_name bv_anrede.anr_name%type,
    p_anr_beschreibung bv_anrede.anr_beschreibung%type,
    p_anr_aktiv bv_anrede.anr_aktiv%type default null,
    p_anr_sortierung bv_anrede.anr_sortierung%type default null)
  as
    l_row bv_anrede%rowtype;
  begin
    l_row.anr_id := p_anr_id;
    l_row.anr_name := p_anr_name;
    l_row.anr_beschreibung := p_anr_beschreibung;
    l_row.anr_aktiv := p_anr_aktiv;
    l_row.anr_sortierung := p_anr_sortierung;
    
    merge_anrede(l_row);
  end merge_anrede;
  
  
  procedure loesche_anrede(
    p_row in bv_anrede%rowtype)
  as
  begin
    delete from bv_anrede
     where anr_id = p_row.anr_id;
  end loesche_anrede;  
  

  procedure validiere_titel(
    p_row in out nocopy bv_titel%rowtype)
  as
  begin
    p_row.tit_id := dbms_assert.simple_sql_name(p_row.tit_id);
  end validiere_titel;
  

  procedure merge_titel(
    p_row in out nocopy bv_titel%rowtype)
  as
  begin
    -- Initialisierung
    p_row.tit_id := upper(p_row.tit_id);
    p_row.tit_aktiv := coalesce(upper(p_row.tit_aktiv), bv_utils.C_FALSE);
    
    validiere_titel(p_row);
    
    merge into bv_titel t
    using (select p_row.tit_id tit_id,
                  p_row.tit_name tit_name,
                  p_row.tit_beschreibung tit_beschreibung,
                  p_row.tit_aktiv tit_aktiv,
                  p_row.tit_sortierung tit_sortierung
             from dual) s
       on (t.tit_id = s.tit_id)
     when matched then update set
          t.tit_name = s.tit_name,
          t.tit_beschreibung = s.tit_beschreibung,
          t.tit_aktiv = s.tit_aktiv,
          t.tit_sortierung = s.tit_sortierung
     when not matched then insert (tit_id, tit_name, tit_beschreibung, tit_aktiv, tit_sortierung)
          values (s.tit_id, s.tit_name, s.tit_beschreibung, s.tit_aktiv, s.tit_sortierung);
  end merge_titel;
  
    
  procedure merge_titel(
    p_tit_id bv_titel.tit_id%type,
    p_tit_name bv_titel.tit_name%type,
    p_tit_beschreibung bv_titel.tit_beschreibung%type,
    p_tit_aktiv bv_titel.tit_aktiv%type default null,
    p_tit_sortierung bv_titel.tit_sortierung%type default null)
  as
    l_row bv_titel%rowtype;
  begin
    l_row.tit_id := p_tit_id;
    l_row.tit_name := p_tit_name;
    l_row.tit_beschreibung := p_tit_beschreibung;
    l_row.tit_aktiv := p_tit_aktiv;
    l_row.tit_sortierung := p_tit_sortierung;
    
    merge_titel(l_row);
  end merge_titel;
  
  
  procedure loesche_titel(
    p_row in bv_titel%rowtype)
  as
  begin
    delete from bv_titel
     where tit_id = p_row.tit_id;
  end loesche_titel;
  
  
  procedure validiere_benutzer(
    p_row in out nocopy bv_benutzer%rowtype)
  as
  begin
    pit.assert_not_null(
      p_condition => p_row.ben_ad,
      p_message_name => msg.BV_ITEM_IS_REQUIRED, 
      p_error_code => 'BEN_AD_MISSING');
    pit.assert_not_null(
      p_condition => p_row.ben_anr_id,
      p_message_name => msg.BV_ITEM_IS_REQUIRED, 
      p_error_code => 'BEN_ANR_ID_MISSING');
    pit.assert_not_null(
      p_condition => p_row.ben_email,
      p_message_name => msg.BV_ITEM_IS_REQUIRED, 
      p_error_code => 'BEN_EMAIL_MISSING');
    pit.assert_not_null(
      p_condition => p_row.ben_nachname, 
      p_message_name => msg.BV_ITEM_IS_REQUIRED, 
      p_error_code => 'BEN_NACHNAME_MISSING');
    pit.assert_not_null(
      p_condition => p_row.ben_gueltig_ab, 
      p_message_name => msg.BV_ITEM_IS_REQUIRED, 
      p_error_code => 'BEN_GUELTIG_AB_MISSING');
    pit.assert_not_null(
      p_condition => p_row.ben_gueltig_bis, 
      p_message_name => msg.BV_ITEM_IS_REQUIRED, 
      p_error_code => 'BEN_GUELTIG_BIS_MISSING');
      
    pit.assert(
      p_condition => p_row.ben_gueltig_ab < p_row.ben_gueltig_bis,
      p_message_name => msg.BV_INVALID_DATE_PERIOD);
      
    if p_row.ben_id is null then
      -- Pruefungen bei Neuanlage
      pit.assert(
        p_condition => p_row.ben_gueltig_ab >= trunc(sysdate),
        p_message_name => msg.BV_INVALID_VALID_FROM);
    end if;
      
  end validiere_benutzer;
  

  procedure merge_benutzer(
    p_row in out nocopy bv_benutzer%rowtype)
  as
  begin
    pit.enter_optional(
      p_params => msg_params(
                    msg_param('p_row.ben_id', p_row.ben_id),
                    msg_param('p_row.ben_ad', p_row.ben_ad),
                    msg_param('p_row.ben_stz', p_row.ben_stz),
                    msg_param('p_row.ben_anr_id', p_row.ben_anr_id),
                    msg_param('p_row.ben_vorname', p_row.ben_vorname),
                    msg_param('p_row.ben_nachname', p_row.ben_nachname),
                    msg_param('p_row.ben_email', p_row.ben_email),
                    msg_param('p_row.ben_telefon', p_row.ben_telefon),
                    msg_param('p_row.ben_gueltig_ab', to_char(p_row.ben_gueltig_ab, 'dd.mm.yyyy')),
                    msg_param('p_row.ben_gueltig_bis', to_char(p_row.ben_gueltig_bis, 'dd.mm.yyyy'))));
    
  
    -- Initialisierung
    p_row.ben_gueltig_ab := coalesce(p_row.ben_gueltig_ab, trunc(sysdate));
    p_row.ben_gueltig_bis := coalesce(p_row.ben_gueltig_bis, bv_utils.C_MAX_DATE);
    
    validiere_benutzer(p_row);
    
    
    -- Versuche, Benutzer anhand der AD zu finden
    begin
      select ben_id
        into p_row.ben_id
        from bv_benutzer
       where ben_ad = p_row.ben_ad;
    exception
      when no_data_found then
        p_row.ben_id := coalesce(p_row.ben_id, bv_seq.nextval);
    end;
    
    merge into bv_benutzer t
    using (select p_row.ben_id ben_id, 
                  p_row.ben_ad ben_ad, 
                  p_row.ben_stz ben_stz,
                  p_row.ben_anr_id ben_anr_id,
                  p_row.ben_tit_id ben_tit_id,
                  p_row.ben_vorname ben_vorname,
                  p_row.ben_nachname ben_nachname,
                  p_row.ben_email ben_email,
                  p_row.ben_telefon ben_telefon,
                  p_row.ben_gueltig_ab ben_gueltig_ab,
                  p_row.ben_gueltig_bis ben_gueltig_bis
             from dual) s
       on (t.ben_id = s.ben_id)
     when matched then update set
          ben_ad = s.ben_ad,
          ben_stz = s.ben_stz,
          ben_anr_id = s.ben_anr_id,
          ben_tit_id = s.ben_tit_id,
          ben_vorname = s.ben_vorname,
          ben_nachname = s.ben_nachname,
          ben_telefon = s.ben_telefon,
          ben_gueltig_bis = s.ben_gueltig_bis
     when not matched then insert(ben_id, ben_ad, ben_stz, ben_anr_id, ben_tit_id, ben_vorname, ben_nachname, ben_email, ben_telefon, ben_gueltig_bis)
          values(s.ben_id, s.ben_ad, s.ben_stz, s.ben_anr_id, s.ben_tit_id, s.ben_vorname, s.ben_nachname, s.ben_email, s.ben_telefon, s.ben_gueltig_bis); 
          
    pit.leave_optional(
      p_params => msg_params(
                    msg_param('p_row.ben_id', p_row.ben_id)));
  end merge_benutzer;
  
    
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
    p_ben_gueltig_bis in bv_benutzer.ben_gueltig_bis%type default null)
  as
    l_row bv_benutzer%rowtype;
  begin
    l_row.ben_id := p_ben_id;
    l_row.ben_ad := p_ben_ad;
    l_row.ben_stz := p_ben_stz;
    l_row.ben_anr_id := p_ben_anr_id;
    l_row.ben_tit_id := p_ben_tit_id;
    l_row.ben_vorname := p_ben_vorname;
    l_row.ben_nachname := p_ben_nachname;
    l_row.ben_email := p_ben_email;
    l_row.ben_telefon := p_ben_telefon;
    l_row.ben_gueltig_ab := p_ben_gueltig_ab;
    l_row.ben_gueltig_bis := p_ben_gueltig_bis;
    
    merge_benutzer(l_row);
    
    -- Evtl. erzeugte BEN_ID zurueckgeben
    p_ben_id := l_row.ben_id;
  end merge_benutzer;
  
  
  procedure loesche_benutzer(
    p_row in out nocopy bv_benutzer%rowtype)
  as
  begin
    delete from bv_benutzer
     where ben_id = p_row.ben_id;
  end loesche_benutzer;

end bl_ben;
/