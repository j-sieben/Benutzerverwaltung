
insert into bv_anrede(anr_id, anr_name, anr_sortierung)
select 'HR', 'Herr', 10 from dual union all
select 'FR', 'Frau', 20 from dual;


insert into bv_titel(tit_id, tit_name)
select 'DR', 'Dr.' from dual union all
select 'DR_MED', 'Dr. med.' from dual union all
select 'PD', 'PD' from dual union all
select 'PD_DR', 'PD Dr.' from dual union all
select 'PD_DR_MED', 'PD Dr. med.' from dual union all
select 'PROF_DR', 'Prof. Dr.' from dual union all
select 'PROF_DR_MED', 'Prof. Dr. med.' from dual union all
select 'PROF', 'Prof.' from dual;


insert into bv_anwendung_art(aar_id, aar_name, aar_beschreibung, aar_aktiv)
select 'HIERARCHIE_EINFACH', 'Einfache Hierarchie', 'Die Rechteverwaltung besteht aus einer aufeinander aufbauenden Folge von Anwendungsrollen.', 'Y' from dual union all
select 'HIERARCHIE_KOMPLEX', 'Komplexe Hierarchie', 'Die Rechteverwaltung besteht aus Anwendungsrollen, die in einer komplexen Weise aufeinander verweisen.', 'Y' from dual union all
select 'RECHTE_ROLLEN', 'Rechte und Rollen', 'Die Rechteverwaltung besteht aus Rechten, die einem Benutzer direkt oder ueber eine Rolle zugewiesen werden koennen.', 'N' from dual;


-- Anwendung BV
insert into ui_admin_anw(anw_id, anw_apex_alias, anw_schema, anw_aar_id, anw_name, anw_beschreibung, anw_aktiv)
select '~APP_ID.', '~APP_ID.', '~APP_ID.', 'HIERARCHIE_KOMPLEX', 'Benutzerverwaltung', 'Zentrale Anwendung zur Verwaltung von Anwendungsbenutzern', 'Y' from dual;

-- Rollenhierarchie anlegen
begin
  ui_admin_komplexe_rol_pkg.update_rol_hierarchie('~APP_ID.', 'SUPER_ADMIN', 'SUPER_ADMIN:ADMINISTRATOR');
end;
/

commit;

begin
  bl_anw_pkg.create_anw_views('~APP_ID.');
end;
/

prompt DEFAULT SUPER_ADMIN erzeugen
begin
  bl_recht_pkg.create_super_admin(
    p_ben_ad => 'BV_ADMIN',
    p_ben_stz => '123',
    p_anr_id => 'HR',
    p_ben_nachname => 'Sieben',
    p_ben_email => 'j.sieben@condes.de',
    p_ben_telefon => '+49-1266-124433');
end;
/


insert into ui_admin_rol(rol_id, rol_anw_id, rol_name, rol_beschreibung, rol_aktiv, rol_sortierung)
select 'LESER', c_anw_id, 'Leser',  'Einfaches Leserecht ohne Schreibbefugnis', 'Y', 10 from dual union all
select 'ADMINISTRATOR', c_anw_id, 'Administrator', 'Administrationsrecht fuer Basistabellen aller Anwendungen', 'Y', 20 from dual union all
select 'SUPER_ADMIN', c_anw_id, 'Super-Administrator', 'Administration von Basistabellen fuer neue Anwendungen, -arten oder Benutzerrechten und -rollen', 'Y', 20 from dual;


commit;