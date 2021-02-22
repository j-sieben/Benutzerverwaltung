prompt Anwendung BV
declare
  l_row bv_anwendung%rowtype;
begin
  l_row.anw_id := '&APEX_ALIAS.';
  l_row.anw_apex_alias := '&APEX_ALIAS.';
  l_row.anw_schema := '&APEX_USER.';
  l_row.anw_aar_id := 'HIERARCHIE_EINFACH';
  l_row.anw_name := 'Benutzerverwaltung';
  l_row.anw_beschreibung := 'Zentrale Anwendung zur Verwaltung von Anwendungsbenutzern';
  l_row.anw_aktiv := &C_TRUE.;
  
  bl_anw.merge_anwendung(l_row);
end;
/

prompt Rollen anlegen
declare
  p_row bv_rolle%rowtype;
begin
  p_row.rol_id := 'SUPER_ADMIN';
  p_row.rol_anw_id := '&APEX_ALIAS.';
  p_row.rol_name := 'Super-Administrator';
  p_row.rol_beschreibung := 'Administration von Basistabellen fuer neue Anwendungen, -arten oder Benutzerrechten und -rollen';
  p_row.rol_sortierung := 20;
  p_row.rol_aktiv := 'Y';
  bl_recht.merge_rolle(p_row);
  
  p_row.rol_id := 'ADMINISTRATOR';
  p_row.rol_name := 'Administrator';
  p_row.rol_beschreibung := 'Administrationsrecht fuer Basistabellen aller Anwendungen';
  p_row.rol_sortierung := 20;
  bl_recht.merge_rolle(p_row);
  
  p_row.rol_id := 'LESER';
  p_row.rol_name := 'Leser';
  p_row.rol_beschreibung := 'Einfaches Leserecht ohne Schreibbefugnis';
  p_row.rol_sortierung := 10;
  bl_recht.merge_rolle(p_row);
end;
/

prompt Rollenhierarchie anlegen
begin
  bl_recht.einfache_rollen_hierarchie('&APEX_ALIAS.', 'SUPER_ADMIN:ADMINISTRATOR:LESER');
end;
/

commit;

prompt Basierend auf Rollenkonzept Anwendungsviews einrichten
begin
  bl_anw.create_anw_views('&APEX_ALIAS.');
end;
/

prompt DEFAULT SUPER_ADMIN erzeugen
begin
  bl_recht.create_super_admin(
    p_ben_ad => 'BV_ADMIN',
    p_ben_stz => '123',
    p_ben_anr_id => 'HR',
    p_ben_nachname => 'Sieben',
    p_ben_email => 'j.sieben@condes.de',
    p_ben_telefon => '+49-1266-124433');
    
  -- Materialized View aktualisieren
  dbms_mview.refresh('&INSTALL_USER..BV_BENUTZER_RECHTE');
end;
/

