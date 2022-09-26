-- Parameters:
-- 1: APEX schema, which is accessible by the APEX workspace

-- Remarks: Messages will be installed in the default language of PIT.
-- Translations must be installed separately

@init/init_owner.sql &1. 

prompt
prompt &section.
prompt &h1.Benutzerverwaltung (BV)-Installation at user &INSTALL_USER.
@core/install.sql

prompt &h1.Finished BV-Installation

exit
