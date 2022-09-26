prompt Anwendung BV
declare
  l_row dl_bv_anwendung%rowtype;
begin
  l_row.anw_id := '&APP_ALIAS.';
  l_row.anw_apex_alias := '&APP_ALIAS.';
  l_row.anw_schema := user;
  l_row.anw_aar_id := 'HIERARCHIE_EINFACH';
  l_row.anw_name := 'Benutzerverwaltung';
  l_row.anw_beschreibung := 'Zentrale Anwendung zur Verwaltung von Anwendungsbenutzern';
  l_row.anw_aktiv := &C_TRUE.;
  
  bl_anw.merge_anwendung(l_row);
end;
/

prompt Rollen anlegen
declare
  p_row dl_bv_rolle%rowtype;
begin
  p_row.rol_id := 'SUPER_ADMIN';
  p_row.rol_anw_id := '&APP_ALIAS.';
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
  bl_recht.einfache_rollen_hierarchie('&APP_ALIAS.', 'SUPER_ADMIN:ADMINISTRATOR:LESER');
end;
/

commit;

prompt Basierend auf Rollenkonzept Anwendungsviews einrichten
begin
  bl_anw.create_anw_views('&APP_ALIAS.');
end;
/
