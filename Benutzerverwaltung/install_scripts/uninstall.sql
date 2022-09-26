@init.sql

alter session set current_schema=&INSTALL_USER.;

prompt &h1.Benutzerverwaltung Deinstallation

prompt &h2.Deinstall APEX application
@apex/clean_up_install.sql

prompt &h2.Deinstall Core Functionality
@core/clean_up_install.sql

exit;
