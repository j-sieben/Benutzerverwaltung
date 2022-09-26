-- Parameters:
-- 1: Owner of BV, package into which BV will be installed
-- 2: APEX workspace name, into which the APEX application will be installed. Needs access to Owner of BV
-- 3: ALIAS of the APEX-application. 
-- 4: APP_ID of the APEX-application.

-- Remarks: Messages will be installed in the default language of PIT.
-- Translations must be installed separately

@init/init_apex.sql &1. &2. &3. &4. 

prompt
prompt &section.
prompt &h1.APEX application &3.
@apex/install.sql


prompt &h1.Finished BV-Installation

pause
