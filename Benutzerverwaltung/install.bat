@echo off
cls
set /p InstallUser=Daten-Schema der Benutzerverwaltung:

set "PWD=powershell.exe -Command " ^
$inputPass = read-host 'Enter password for %InstallUser%' -AsSecureString ; ^
$BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($inputPass); ^
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "tokens=*" %%a in ('%PWD%') do set PWD=%%a

set /p SID=Servicename der Datenbank oder PDB:

set /p RemoteUser=APEX-Schema der Benutzerverwaltung:

set "RemotePWD=powershell.exe -Command " ^
$inputPass = read-host 'Enter password for %RemoteUser%' -AsSecureString ; ^
$BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($inputPass); ^
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "tokens=*" %%a in ('%RemotePWD%') do set RemotePWD=%%a


set /p APEX_WS=Name des APEX-Workspaces:

set /p APP_ALIAS=Alias der Benutzerverwaltung:

set /p APP_ID=Anwendungs-ID der Benutzerverwaltung:

set nls_lang=GERMAN_GERMANY.AL32UTF8

echo @install_scripts/install.sql %RemoteUser% | sqlplus %InstallUser%/%PWD%@%SID% 

echo @install_scripts/install_apex.sql %InstallUser% %APEX_WS% %APP_ALIAS% %APP_ID% | sqlplus %RemoteUser%/%RemotePWD%@%SID% 

pause
