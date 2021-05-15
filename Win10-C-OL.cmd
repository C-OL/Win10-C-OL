:: Windows 10 C-OL - Custom Tweaks Collection Script
::
:: This is a collection of tweaks that aim to fine tune a fresh install of Windows 10 keeping
:: the Default behavior of visual inputs providing a drastically overall performance boost and enhanced security.
::
:: Some tweaks are meant for the CURRENT_USER instead of using Group Policies to avoid similar annoying messages
:: such as: "Some settings are managed by your organization".
::
:: It requires to Run as Administrator to work properly.
::

@ECHO OFF & COLOR 30
SETLOCAL EnableDelayedExpansion
PUSHD "%~dp0"
CLS & openfiles >NUL 2>&1
IF %ERRORLEVEL%==1 (ECHO. & ECHO :::::::: You are NOT running as Administrator :::::::: & ECHO Right-click and select ^'Run as Administrator^' and try again.
ECHO. & ECHO Press any key to exit & PAUSE > NUL & EXIT)
ECHO. & ECHO :::::::: Windows 10 C-OL - Custom Tweak Collection Script :::::::: & ECHO.
TASKKILL /F /IM EXPLORER.EXE >NUL 2>&1
::WMIC.exe /Namespace:\\root\Default Path SystemRestore Call CreateRestorePoint "Windows 10 C-OL - Custom Tweaks Collection Script", 100, 7
set OS=%PROCESSOR_ARCHITECTURE%
if /i %PROCESSOR_ARCHITECTURE%==x86 (if not defined PROCESSOR_ARCHITEW6432 (set "OS=x86"))

ECHO :::::::: *Lower UAC Level*
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ConsentPromptBehaviorAdmin" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ConsentPromptBehaviorUser" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableInstallerDetection" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableLUA" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableVirtualization" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "FilterAdministratorToken" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "PromptOnSecureDesktop" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ValidateAdminCodeSignatures" /T REG_DWORD /D "0" /F >NUL 2>&1

ECHO :::::::: Accounts
:: Remove DefaultUser0 Account
NET USER DefaultUser0 /Delete >NUL 2>&1
:: Password Expiration
NET ACCOUNTS /MaxPwAge:Unlimited >NUL 2>&1
:: Set User TEMP to Windows TEMP
IF EXIST "%LOCALAPPDATA%\TEMP" RD /S /Q "%LOCALAPPDATA%\TEMP" >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Environment" /V "TEMP" /T REG_SZ /D "%SYSTEMROOT%\TEMP" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Environment" /V "TMP" /T REG_SZ /D "%SYSTEMROOT%\TEMP" /F >NUL 2>&1
:: Microsoft.com accounts (Block Sign-in Microsoft account)
:: 0 = Allow / 1 = can't add / 3 = can't add or login
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "MSAOptional" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "NoConnectedUser" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Security Questions for Local Accounts
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "NoLocalPasswordResetQuestions" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Sync Your Settings
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /V "SyncPolicy" /T REG_DWORD /D "5" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableAppSyncSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableAppSyncSettingSyncUserOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableApplicationSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableApplicationSettingSyncUserOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableCredentialsSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableCredentialsSettingSyncUserOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableDesktopThemeSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableDesktopThemeSettingSyncUserOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisablePersonalizationSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisablePersonalizationSettingSyncUserOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableSettingSyncUserOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableStartLayoutSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableStartLayoutSettingSyncUserOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableSyncOnPaidNetwork" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableWebBrowserSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableWebBrowserSettingSyncUserOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableWindowsSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableWindowsSettingSyncUserOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "EnableBackupForWin8Apps" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Messaging" /V "AllowMessageSync" /T REG_DWORD /D "0" /F >NUL 2>&1

ECHO :::::::: Apps ^& Features
:::: Application Compatibility
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\AIT" /V "AITEnable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Appraiser" /V "HaveUploadedForTarget" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /V "DontRetryOnError" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /V "IsCensusDisabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /V "TaskEnableRun" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CompatTelRunner.exe" /V "Debugger" /T REG_SZ /D "%SYSTEMROOT%\System32\taskkill.exe" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DeviceCensus.exe" /V "Debugger" /T REG_SZ /D "%SYSTEMROOT%\System32\taskkill.exe" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PushToInstall" /V "DisablePushToInstall" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "AITEnable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "AllowTelemetry" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "DisableInventory" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "DisableEngine" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "DisablePCA" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "DisablePropPage" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "DisableUAR" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "Prevent16BitMach" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "RemoveProgramCompatPropPage" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "SbEnable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "VDMDisallowed" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Tracing" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\TelemetryController" /F >NUL 2>&1
:: Compatibility Troubleshoot
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /V "{1d27f844-3a1f-4410-85ac-14651078412d}" /T REG_SZ /D "" /F >NUL 2>&1
:: Classic Paint
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Paint\Settings" /V "DisableModernPaintBootstrap" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Microsoft Edge and Internet Explorer
:: New Edge Uninstall
if %OS%==x86 (set "PF=%PROGRAMFILES%\Microsoft") else if %OS%==AMD64 (set "PF=%PROGRAMFILES(X86)%\Microsoft")
FOR /D %%i IN ("%PF%\Microsoft\Edge\Application\*") DO IF EXIST "%%i\Installer\Setup.exe" (%%i\Installer\Setup.exe --uninstall --force-uninstall --system-level --verbose-logging --delete-profile) >NUL 2>&1
IF EXIST "%SYSTEMROOT%\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" (TAKEOWN /F "%SYSTEMROOT%\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" && ICACLS "%SYSTEMROOT%\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" /GRANT Administrators:F && RD /S /Q "%SYSTEMROOT%\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe") >NUL 2>&1
IF EXIST "%SYSTEMROOT%\SystemApps\Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe" (TAKEOWN /F "%SYSTEMROOT%\SystemApps\Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe" && ICACLS "%SYSTEMROOT%\SystemApps\Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe" /GRANT Administrators:F && RD /S /Q "%SYSTEMROOT%\SystemApps\Microsoft.MicrosoftEdgeDevToolsClient_8wekyb3d8bbwe") >NUL 2>&1
IF EXIST "%LOCALAPPDATA%\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" (TAKEOWN /F "%LOCALAPPDATA%\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" && ICACLS "%LOCALAPPDATA%\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" /GRANT Administrators:F && RD /S /Q "%LOCALAPPDATA%\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe") >NUL 2>&1
IF EXIST "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk" DEL /F /S /Q "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk" >NUL 2>&1
IF EXIST "%LOCALAPPDATA%\Microsoft\Edge" RD /S /Q "%LOCALAPPDATA%\Microsoft\Edge" >NUL 2>&1
IF EXIST "%LOCALAPPDATA%\Microsoft\Windows\Safety\Edge" RD /S /Q "%LOCALAPPDATA%\Microsoft\Windows\Safety\Edge" >NUL 2>&1
IF EXIST "%PROGRAMDATA%\Microsoft\EdgeUpdate" RD /S /Q "%PROGRAMDATA%\Microsoft\EdgeUpdate" >NUL 2>&1
IF EXIST "%USERPROFILE%\Desktop\Microsoft Edge.lnk" DEL /F /S /Q "%USERPROFILE%\Desktop\Microsoft Edge.lnk" >NUL 2>&1
DEL /F /S /Q "%SYSTEMROOT%\System32\Config\SystemProfile\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge*.lnk" >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Edge" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\EdgeUpdate" /F >NUL 2>&1
REG Delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /V "NoRemove" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /V "NoRemove" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /V "NoRemove" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EdgeUpdate" /V "DoNotUpdateToEdgeWithChromium" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MicrosoftEdge.exe" /V "Debugger" /T REG_SZ /D "%SYSTEMROOT%\System32\taskkill.exe" /F >NUL 2>&1
REG Delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\msedge.exe" /F >NUL 2>&1
:: IE Harden
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" /V "WpadOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" /V "WpadOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "IEHarden" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "IEHarden" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4B3F-8CFC-4F3A74704073}" /V "IsInstalled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4B3F-8CFC-4F3A74704073}" /V "IsInstalled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "DisableEdgeDesktopShortcutCreation" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /V "MaxConnectionsPer1_0Server" /T REG_DWORD /D "10" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /V "MaxConnectionsPerServer" /T REG_DWORD /D "10" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /V "CallLegacyWCMPolicies" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /V "EnableHTTP2" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /V "EnableSSL3Fallback" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /V "PreventIgnoreCertErrors" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4B3F-8CFC-4F3A74704073}" /V "IsInstalled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "IEHarden" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "IEHarden" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Delete "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\SOFTWARE\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe" /F >NUL 2>&1
REG Delete "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\SOFTWARE\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedgedevtoolsclient_8wekyb3d8bbwe" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer" /V "IntegratedBrowser" /T REG_DWORD /D "0" /F >NUL 2>&1
:: CheckExeSignatures
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Download" /V "CheckExeSignatures" /T REG_SZ /D "No" /F >NUL 2>&1
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Download" /V "RunInvalidSignatures" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Flash Player (Not needed after KB4577586)
::IF EXIST "%APPDATA%\Adobe\Flash Player" (TAKEOWN /F "%APPDATA%\Adobe\Flash Player" & ICACLS "%APPDATA%\Adobe\Flash Player" /GRANT Administrators:F & RD /S /Q "%APPDATA%\Adobe\Flash Player") >NUL 2>&1
::IF EXIST "%APPDATA%\Macromedia\Flash Player" (TAKEOWN /F "%APPDATA%\Macromedia\Flash Player" & ICACLS "%APPDATA%\Macromedia\Flash Player" /GRANT Administrators:F & RD /S /Q "%APPDATA%\Macromedia\Flash Player") >NUL 2>&1
::IF EXIST "%SYSTEMROOT%\SysWOW64\Macromed\Flash" (TAKEOWN /F "%SYSTEMROOT%\SysWOW64\Macromed\Flash" & ICACLS "%SYSTEMROOT%\SysWOW64\Macromed\Flash" /GRANT Administrators:F & RD /S /Q "%SYSTEMROOT%\SysWOW64\Macromed\Flash") >NUL 2>&1
::IF EXIST "%SYSTEMROOT%\System32\Macromed\Flash" (TAKEOWN /F "%SYSTEMROOT%\System32\Macromed\Flash" & ICACLS "%SYSTEMROOT%\System32\Macromed\Flash" /GRANT Administrators:F & RD /S /Q "%SYSTEMROOT%\System32\Macromed\Flash") >NUL 2>&1
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons" /V "FlashPlayerEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Internet Explorer" /V "DisableFlashInIE" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons" /V "FlashPlayerEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Microsoft OneDrive
TASKLIST | FIND /I "OneDrive.exe" && TASKKILL /F /IM OneDrive.exe >NUL 2>&1
if %OS%==x86 (set "OD=%SYSTEMROOT%\SYSTEM32") else if %OS%==AMD64 (set "OD=%SYSTEMROOT%\SysWOW64")
IF EXIST %OD%\OneDriveSetup.exe (TAKEOWN /F %OD%\OneDrive* && ICACLS %OD%\OneDrive* /GRANT Administrators:F && %OD%\OneDriveSetup.exe /uninstall && DEL /F /S /Q %OD%\OneDrive*) >NUL 2>&1
IF EXIST "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Microsoft OneDrive.lnk" DEL /F /S /Q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Microsoft OneDrive.lnk" >NUL 2>&1
IF EXIST "%APPDATA%\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" DEL /F /S /Q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" >NUL 2>&1
IF EXIST "%LOCALAPPDATA%\Microsoft\OneDrive" RD /S /Q "%LOCALAPPDATA%\Microsoft\OneDrive" >NUL 2>&1
IF EXIST "%PROGRAMDATA%\Microsoft OneDrive" RD /S /Q "%PROGRAMDATA%\Microsoft OneDrive" >NUL 2>&1
IF EXIST "%SYSTEMDRIVE%\OneDriveTemp" RD /S /Q "%SYSTEMDRIVE%\OneDriveTemp" >NUL 2>&1
IF EXIST "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" DEL /F /S /Q "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" >NUL 2>&1
IF EXIST "%USERPROFILE%\Links\OneDrive.lnk" DEL /F /S /Q "%USERPROFILE%\Links\OneDrive.lnk" >NUL 2>&1
IF EXIST "%USERPROFILE%\OneDrive" RD /S /Q "%USERPROFILE%\OneDrive" >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\WoW6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG Delete "HKEY_CURRENT_USER\Environment" /V "OneDrive" /F >NUL 2>&1
REG Delete "HKEY_CURRENT_USER\SOFTWARE\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG Delete "HKEY_CURRENT_USER\SOFTWARE\Classes\WoW6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG Delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\OneDrive" /F >NUL 2>&1
REG Delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG Delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "OneDriveSetup" /F >NUL 2>&1
REG Delete "HKEY_USERS\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "OneDriveSetup" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\OneDrive" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SkyDrive" /F >NUL 2>&1
::REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{A52BBA46-E9E1-435f-B3D9-28DAA648C0F6}" /F >NUL 2>&1
::REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{A52BBA46-E9E1-435f-B3D9-28DAA648C0F6}" /F >NUL 2>&1
REG Delete "HKEY_USERS\S-1-5-21-2840528155-2331882053-1912885801-1000\SOFTWARE\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG Delete "HKEY_USERS\S-1-5-21-2840528155-2331882053-1912885801-1000\SOFTWARE\Classes\WoW6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG Delete "HKEY_USERS\S-1-5-21-2840528155-2331882053-1912885801-1000_Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG Delete "HKEY_USERS\S-1-5-21-2840528155-2331882053-1912885801-1000_Classes\WoW6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /V "DisableFileSyncNGSC" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Storage\EnabledDenyGP" /V "DenyAllGPState" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\OneDrive" /V "PreventNetworkTrafficPreUserSignIn" /T REG_DWORD /D "1" /F >NUL 2>&1
:::::::: .NET Framework
:: Strong Cryptography
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /V "SchUseStrongCrypto" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /V "SystemDefaultTlsVersions" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v3.0" /V "SchUseStrongCrypto" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v3.0" /V "SystemDefaultTlsVersions" /T REG_DWORD /D "1" /F >NU
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" /V "SchUseStrongCrypto" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" /V "SystemDefaultTlsVersions" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework\v2.0.50727" /V "SchUseStrongCrypto" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework\v2.0.50727" /V "SystemDefaultTlsVersions" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework\v3.0" /V "SchUseStrongCrypto" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework\v3.0" /V "SystemDefaultTlsVersions" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework\v4.0.30319" /V "SchUseStrongCrypto" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework\v4.0.30319" /V "SystemDefaultTlsVersions" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Use Latest CLR
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework" /V "OnlyUseLatestCLR" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework" /V "OnlyUseLatestCLR" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Windows Installer in Safe Mode
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\MSIServer" /ve /T REG_SZ /D "Service" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\MSIServer" /ve /T REG_SZ /D "Service" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Installer" /V "SafeForScripting" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Windows Media Player
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Setup\UserOptions" /V "DesktopShortcut" /T REG_SZ /D "No" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MediaPlayer\Preferences" /V "AcceptedPrivacyStatement" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MediaPlayer\Preferences" /V "AutoCopyCD" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MediaPlayer\Preferences" /V "DisableMRU" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MediaPlayer\Preferences" /V "FirstRun" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MediaPlayer\Preferences" /V "SendUserGUID" /T REG_BINARY /D "00" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MediaPlayer\Preferences" /V "UsageTracking" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /V "GroupPrivacyAcceptance" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /V "PreventCDDVDMetadataRetrieval" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /V "PreventMusicFileMetadataRetrieval" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /V "PreventRadioPresetsRetrieval" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Prevent Windows Media Digital Rights Management (DRM)
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WMDRM" /V "DisableOnline" /T REG_DWORD /D "1" /F >NUL 2>&1

ECHO :::::::: Devices
:::: Mouse
REG Add "HKEY_CURRENT_USER\Control Panel\Mouse" /V "ActiveWindowTracking" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Mouse" /V "Beep" /T REG_SZ /D "no" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Mouse" /V "ExtendedSounds" /T REG_SZ /D "No" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Mouse" /V "MouseHoverTime" /T REG_SZ /D "100" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Mouse" /V "MouseSensitivity" /T REG_SZ /D "20" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Mouse" /V "MouseSpeed" /T REG_SZ /D "2" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Mouse" /V "MouseTrails" /T REG_SZ /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Mouse" /V "MouseThreshold1" /T REG_SZ /D "4" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Mouse" /V "MouseThreshold2" /T REG_SZ /D "6" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Mouse" /V "SnapToDefaultButton" /T REG_SZ /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Mouse" /V "SwapMouseButtons" /T REG_SZ /D "0" /F >NUL 2>&1
:::: Typing
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\CTF\LangBar" /V "ShowStatus" /T REG_DWORD /D "3" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\Settings" /V "EnableHwkbAutocorrection2" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\Settings" /V "EnableHwkbTextPrediction" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\Settings" /V "InsightsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\Settings" /V "MultilingualEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" /V "AllowLanguageFeaturesUninstall" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Keyboard On Screen
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Osk" /V "BounceTime" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Osk" /V "FirstRepeatDelay" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Osk" /V "KeystrokeDelay" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Osk" /V "NextRepeatDelay" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\TabletTip\1.7" /V "EnableKeyAudioFeedback" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\TabletTip\1.7" /V "EnableTextPrediction" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Pen ^& Windows Ink
:: PenWorkspace
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace" /V "PenWorkspaceAppSuggestionsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace" /V "PenWorkspaceButtonDesiredVisibility" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: AutoPlay
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoDriveTypeAutoRun" /T REG_DWORD /D "255" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoAutoplayfornonVolume" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main" /V "Autorun" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /V "DisableAutoplay" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoAutorun" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoDriveTypeAutoRun" /T REG_DWORD /D "255" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\cdrom" /V "Autorun" /T REG_DWORD /D "0" /F >NUL 2>&1
:::::::: Hardware Related Tweaks
:: Block Legacy File System Filter Drivers
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /V "IoBlockLegacyFsFilters" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Camera Fix?
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Media Foundation\Platform" /V "EnableFrameServerMode" /T REG_SZ /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows Media Foundation\Platform" /V "EnableFrameServerMode" /T REG_SZ /D "0" /F >NUL 2>&1
:: Camera On/Off OSD Notifications
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\OEM\Device\Capture" /V "NoPhysicalCameraLED" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Enable Intel AHCI
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iaStorAC" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iaStorAC\StartOverride" /V "0" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iaStorAVC" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iaStorAVC\StartOverride" /V "0" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iaStorV" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iaStorV\StartOverride" /V "0" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\storahci" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\storahci\StartOverride" /V "0" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Enable Legacy F8 Bootmenu
BCDEDIT /Set {Current} BootMenuPolicy Legacy >NUL 2>&1
:: Enforce Device Driver Signing (Default)
::BCDEDIT /Set NoIntegrityChecks OFF >NUL 2>&1
::BCDEDIT /Set TestSigning OFF >NUL 2>&1
:: Hardware Accelerated GPU Scheduling
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /V "HwSchMode" /T REG_DWORD /D "2" /F >NUL 2>&1
:: Windows Data Execution Prevention (DEP)
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoDataExecutionPrevention" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoHeapTerminationOnCorruption" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "DisableHHDEP" /T REG_DWORD /D "0" /F >NUL 2>&1
START /B /WAIT BCDEDIT /Set {Current} nx OptOut >NUL 2>&1
:: NTFS File System
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "ContigFileAllocSize" /T REG_DWORD /D "200" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "LongPathsEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsAllowExtendedCharacter8dot3Rename" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsDisable8dot3NameCreation" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsDisableLastAccessUpdate" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsEnableTxfDeprecatedFunctionality" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsMemoryUsage" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsMftZoneReservation" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "Win31FileSystem" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "Win95TruncatedExtensions" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Split Threshold for Svchost (for 16GB RAM)
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /V "SvcHostSplitThresholdInKB" /T REG_DWORD /D "17662460" /F >NUL 2>&1

ECHO :::::::: Ease of Access
:::: Narrator
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "CoupleNarratorCursorKeyboard" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "ECHOChars" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "ECHOWords" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "ErrorNotificationType" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "FollowInsertion" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "IntonationPause" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "NarratorCursorHighlight" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "PlayAudioCues" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "ReadHints" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NarratorHome" /V "AutoStart" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NarratorHome" /V "MinimizeType" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "ContextVerbosityLevel" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "ContextVerbosityLevelV2" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "DetailedFeedback" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "DuckAudio" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "ECHOToggleKeys" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "OnlineServicesEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "ScriptingEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "UserVerbosityLevel" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "WinEnterLaunchEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Speech
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /V "ModelDownloadAllowed" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /V "VoiceActivationEnableAboveLockscreen" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /V "VoiceActivationOn" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /V "HasAccepted" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\Microsoft.549981C3F5F10_8wekyb3d8bbwe!App" /V "AgentActivationEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\Microsoft.549981C3F5F10_8wekyb3d8bbwe!App" /V "AgentActivationOnLockScreenEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /V "AgentActivationEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /V "AgentActivationLastUsed" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /V "ModelDownloadAllowed" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /V "VoiceActivationDefaultOn" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Speech" /V "AllowSpeechModelUpdate" /T REG_DWORD /D "0" /F >NUL 2>&1

ECHO :::::::: Gaming
:: Game Bar / Game Mode
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar" /V "AllowAutoGameMode" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar" /V "AutoGameModeEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar" /V "ShowStartupPanel" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameUX" /V "DownloadGameInfo" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameUX" /V "GameUpdateOptions" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameUX" /V "ListRecentlyPlayed" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Captures
REG Add "HKEY_CURRENT_USER\SYSTEM\GameConfigStore" /V "GameDVR_Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /V "AppCaptureEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /V "HistoricalCaptureEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /V "AllowGameDVR" /T REG_DWORD /D "0" /F >NUL 2>&1
:: SmartGlass
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" /V "BluetoothPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" /V "UserAuthPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1

ECHO :::::::: Mixed Reality
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Holographic" /V "FirstRunSucceeded" /T REG_DWORD /D "0" /F >NUL 2>&1

ECHO :::::::: Network ^& Internet
:: Active Probing (pings to MSFT NCSI server)
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /V "EnableActiveProbing" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Admin Shares
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "AutoShareServer" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "AutoShareWks" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "RestrictNullSessAccess" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "Size" /T REG_DWORD /D "3" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "SMB1" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "SMB2" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "IRPStackSize" /T REG_DWORD /D "20" /F >NUL 2>&1
:: Adobe Type Manager
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /V "DisableATMFD" /T REG_DWORD /D "1" /F >NUL 2>&1
:: BITS
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\BITS" /V "EnablePeercaching" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\BITS" /V "DisableBranchCache" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\BITS" /V "DisablePeerCachingClient" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\BITS" /V "DisablePeerCachingServer" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Block Files From Internet
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /V "SaveZoneInformation" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /V "SaveZoneInformation" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Associations\ModRiskFileTypes" /ve /T REG_SZ /D ".bat;.exe;.reg;.vbs;.chm;.msi;.js;.cmd" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Associations\ModRiskFileTypes" /ve /T REG_SZ /D ".bat;.exe;.reg;.vbs;.chm;.msi;.js;.cmd" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Associations\ModRiskFileTypes" /ve /T REG_SZ /D ".bat;.exe;.reg;.vbs;.chm;.msi;.js;.cmd" /F >NUL 2>&1
:: BranchCache
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PeerDist\HostedCache\Discovery" /V "SCPDiscoveryEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PeerDist\CooperativeCaching" /V "Enable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PeerDist\Service" /V "Enable" /T REG_DWORD /D "0" /F >NUL 2>&1
:: CertIFicate Revocation Check
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentIFiers" /V "AuthenticodeEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: CredSSP Encryption
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /V "AllowEncryptionOracle" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Detailed Data Usage
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DusmSvc\Settings" /V "DisableSystemBucket" /T REG_DWORD /D "1" /F >NUL 2>&1
:: DNS
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /V "DisableSmartProtocolReordering" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /V "DisableSmartNameResolution" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /V "EnableMulticast" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /V "RegistrationEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /V "UpdateSecurityLevel" /T REG_DWORD /D "256" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /V "UpdateTopLevelDomainZones" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNSCache\Parameters" /V "DisableParallelAandAAAA" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNSCache\Parameters" /V "MaxCacheTTL" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNSCache\Parameters" /V "MaxNegativeCacheTTL" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Encrypt and Sign Outgoing Secure Channel
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" /V "SealSecureChannel" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" /V "SignSecureChannel" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Ethernet as Metered Connection
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\DefaultMediaCost" /V "Ethernet" /T REG_DWORD /D "2" /F >NUL 2>&1
:: Find My Device
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Settings\FindMyDevice" /V "LocationSyncEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Hotspot 2.0 Networks
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WlanSvc\AnqpCache" /V "OsuRegistrationStatus" /T REG_DWORD /D "0" /F >NUL 2>&1
:: IIS Installation
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\IIS" /V "PreventIISInstall" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Internet Connection Sharing
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Network Connections" /V "NC_ShowSharedAccessUI" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Intranet Protected Mode
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main" /V "NoProtectedModeBanner" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main" /V "NoProtectedModeBanner" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Microsoft Peer-to-Peer Networking Services
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\\Policies\Microsoft\Peernet" /V "Disabled" /T REG_DWORD /D "1" /F >NUL 2>&1
:: NetBIOS over TCP/IP
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\NetBT\Parameters" /V "NetbiosOptions" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netbt\Parameters" /V "NoNameReleaseOnDemand" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Network Auto Install
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup" /V "GlobalAutoSetup" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Domain" /V "AutoSetup" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private" /V "AutoSetup" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Public" /V "AutoSetup" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Network Connectivity Status Indicator
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /V "NoActiveProbe" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Password Reveal
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CredUI" /V "DisablePasswordReveal" /T REG_DWORD /D "1" /f
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" /V "DisablePasswordReveal" /T REG_DWORD /D "1" /f
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredUI" /V "DisablePasswordReveal" /T REG_DWORD /D "1" /f
:: Require trusted path for credential entry
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI" /V "EnableSecureCredentialPrompting" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Restrict Anonymous Enumeration Shares
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" /V "AllowProtectedCreds" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LanManWorkstation" /V "AllowInsecureGuestAuth" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /V "DisableRemoteScmEndpoints" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "DisableDomainCreds" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "EveryoneIncludesAnonymous" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "ForceGuest" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "LimitBlankPasswordUse" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "LmCompatibilityLevel" /T REG_DWORD /D "5" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "LsaCfgFlags" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "NoLMHash" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "RestrictAnonymous" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "RestrictAnonymousSAM" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "RunAsPPL" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "SCENoApplyLegacyAuditPolicy" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "SecureBoot" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "SubmitControl" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" /V "AllowNullSessionFallback" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" /V "RestrictReceivingNTLMTraffic" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" /V "RestrictSendingNTLMTraffic" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" /V "UseLogonCredential" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManWorkstation\Parameters" /V "DisableBandwidthThrottling" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManWorkstation\Parameters" /V "EnableSecuritySignature" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManWorkstation\Parameters" /V "RequireSecuritySignature" /T REG_DWORD /D "256" /F >NUL 2>&1
:: RPC Unauthenticated Connections
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\RPC" /V "RestrictRemoteClients" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Router Discovery
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\QoS" /V "Do not use NLA" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\ServiceProvider" /V "DnsPriority" /T REG_DWORD /D "6" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\ServiceProvider" /V "HostsPriority" /T REG_DWORD /D "5" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\ServiceProvider" /V "LocalPriority" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\ServiceProvider" /V "NetbtPriority" /T REG_DWORD /D "7" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /V "NetworkThrottlingIndex" /T REG_DWORD /D "70" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /V "SystemResponsiveness" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Limit Reservable Bandwidth 
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Psched" /V "NonBestEffortLimit" /T REG_DWORD /D "0" /F >NUL 2>&1
:: MSMQ
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSMQ\Parameters" /V "TCPNoDelay" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Shares Of Recently Opened Documents To Network Locations
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoNetHood" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoRecentDocsNetHood" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoNetHood" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoRecentDocsNetHood" /T REG_DWORD /D "1" /F >NUL 2>&1
:: svchost.exe Security Mitigation
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SCMConfig" /V "EnableSvchostMitigationPolicy" /T REG_DWORD /D "1" /F >NUL 2>&1
:: TCP/IP
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /V "EnableDynamicBacklog" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "BSDUrgent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DeadGWDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DeadGWDetectDefault" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DefaultRcvWindow" /T REG_DWORD /D "2000" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DefaultTOS" /T REG_DWORD /D "12" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DefaultTTL" /T REG_DWORD /D "64" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DisableIPSourceRouting" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DisableTaskOffload" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DontAddDefaultGatewayDefault" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableAddrMaskReply" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableDeadGWDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableDynamicBacklog" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableICMPRedirect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableMultiCastForwarding" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnablePMTUBHDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnablePMTUDiscovery" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableRSS" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableSecurityFilters" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableWsd" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "ForwardBroadcasts" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "GlobalMaxTCPWindowSize" /T REG_DWORD /D "ffff" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "IGMPLevel" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "IPEnableRouter" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "KeepAliveInterval" /T REG_DWORD /D "1000" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "KeepAliveTime" /T REG_DWORD /D "300000" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "MaxUserPort" /T REG_DWORD /D "65534" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "PerformRouterDiscovery" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "PMTUBlackHoleDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "QualifyingDestinationThreshold" /T REG_DWORD /D "3" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "SackOpts" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "SynAttackProtect" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCP1323Opts" /T REG_DWORD /D "3" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPMaxConnectResponseRetransmissions" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPMaxDataRetransmissions" /T REG_DWORD /D "3" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPMaxDupAcks" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPMaxHalOpen" /T REG_DWORD /D "64" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPMaxHalOpenRetired" /T REG_DWORD /D "50" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPMaxPortsExhausted" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPTimedWaitDelay" /T REG_DWORD /D "30" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPUseRFC1122UrgentPointer" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPWindowSize" /T REG_DWORD /D "2238" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "UseDomainNameDevolution" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "UseZeroBroadCast" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "BSDUrgent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DeadGWDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DeadGWDetectDefault" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DefaultRcvWindow" /T REG_DWORD /D "2000" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DefaultTOS" /T REG_DWORD /D "12" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DefaultTTL" /T REG_DWORD /D "64" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DisableIPSourceRouting" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DisableTaskOffload" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DontAddDefaultGatewayDefault" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableAddrMaskReply" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableDeadGWDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableDynamicBacklog" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableICMPRedirect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableMultiCastForwarding" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnablePMTUBHDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnablePMTUDiscovery" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableRSS" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableSecurityFilters" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableWsd" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "ForwardBroadcasts" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "GlobalMaxTCPWindowSize" /T REG_DWORD /D "ffff" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "IGMPLevel" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "IPEnableRouter" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "KeepAliveInterval" /T REG_DWORD /D "1000" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "KeepAliveTime" /T REG_DWORD /D "300000" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "MaxUserPort" /T REG_DWORD /D "65534" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "PerformRouterDiscovery" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "PMTUBlackHoleDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "QualifyingDestinationThreshold" /T REG_DWORD /D "3" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "SackOpts" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "SynAttackProtect" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCP1323Opts" /T REG_DWORD /D "3" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPMaxConnectResponseRetransmissions" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPMaxDataRetransmissions" /T REG_DWORD /D "3" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPMaxDupAcks" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPMaxHalOpen" /T REG_DWORD /D "64" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPMaxHalOpenRetired" /T REG_DWORD /D "50" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPMaxPortsExhausted" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPTimedWaitDelay" /T REG_DWORD /D "30" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPUseRFC1122UrgentPointer" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPWindowSize" /T REG_DWORD /D "2238" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "UseDomainNameDevolution" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "UseZeroBroadCast" /T REG_DWORD /D "0" /F >NUL 2>&1
:: TCP Timestamps
NETSH Int TCP Set Global Timestamps=Disabled >NUL 2>&1
:: Terminal Server Shadowing
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "Shadow" /T REG_DWORD /D "0" /F >NUL 2>&1
:: VPN related
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PolicyAgent" /V "AssumeUDPEncapsulationContextOnSendRule" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\Parameters" /V "DisableIKENameEkuCheck" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\Parameters" /V "NegotiateDH2048_AES256" /T REG_DWORD /D "2" /F >NUL 2>&1
:: WaitNetworkStartup
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Winlogon\SyncForegroundPolicy" /F >NUL 2>&1
:: WiFi Sense and Hot Spot
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /V "value" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Default\WiFi\AllowWiFiHotSpotReporting" /V "value" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager" /V "WiFiSenseCredShared" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager" /V "WiFiSenseOpen" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Config" /V "AutoConnectAllowedOEM" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Config" /V "DefaultAutoConnectSharedState" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Config" /V "WiFiSenseAllowed" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Config" /V "WiFiSharingFacebookInitial" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Config" /V "WiFiSharingOutlookInitial" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Config" /V "WiFiSharingSkypeInitial" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\crowdsrcplugin" /V "EnableWiFiCrowdsourcing" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Features\S-1-5-21-3752830748-2673197281-2103194476-1000\SocialNetworks\ABCH" /V "OptInStatus" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Features\S-1-5-21-3752830748-2673197281-2103194476-1000\SocialNetworks\ABCH-SKYPE" /V "OptInStatus" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Features\S-1-5-21-3752830748-2673197281-2103194476-1000\SocialNetworks\FACEBOOK" /V "OptInStatus" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy" /V "fMinimizeConnections" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Windows Connect Now
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /V "DisableFlashConfigRegistrar" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /V "DisableInBand802DOT11Registrar" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /V "DisableUPnPRegistrar" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /V "DisableWPDRegistrar" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /V "EnableRegistrars" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\UI" /V "DisableWcnUi" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Windows Mail
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Mail" /V "DisableCommunities" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Mail" /V "ManualLaunchAllowed" /T REG_DWORD /D "0" /F >NUL 2>&1

ECHO :::::::: Personalization
:::: Display (125%)
REG Add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\GraphicsDrivers\ScaleFactors\SHP146A0_24_07E0_39^75456C06EC4F911F5356A9227E7D0CF6" /V "DpiValue" /T REG_DWORD /D "4294967295" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop\PerMonitorSettings\SHP146A0_24_07E0_39^75456C06EC4F911F5356A9227E7D0CF6" /V "DpiValue" /T REG_DWORD /D "4294967295" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AutoRotation" /V "LastOrientation" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Colors
:: Dark Mode
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /V "AppsUseLightTheme" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /V "SystemUsesLightTheme" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Transparency
::REG Add "HKEY_USERS\.Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /V "EnableTransparency" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /V "ColorPrevalence" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /V "EnableTransparency" /T REG_DWORD /D "0" /F >NUL 2>&1
:: DWM
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "AnimationAttributionEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "AnimationAttributionHashingEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "AlwaysHibernateThumbnails" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "Animations" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "ColorPrevalence" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "ColorizationBlurBalance" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "ColorizationGlassAttribute" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "ColorizationOpaqueBlend" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "Composition" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "DisallowAnimations" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "DisallowFlip3d" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "EnableAeroPeek" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "EnableWindowColorization" /T REG_DWORD /D "1" /F >NUL 2>&1
:::: Lock Screen
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "DisableAutomaticRestartSignOn" /T REG_SZ /D "1" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "DontDisplayLastUsername" /T REG_SZ /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "ParseAutoexec" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\AccessPage\Camera" /V "CameraEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "AllocateCDRoms" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "AllocateFloppies" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "AutoRestartShell" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "EnableFirstLogonAnimation" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "ParseAutoexec" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "PasswordExpiryWarning" /T REG_SZ /D "5" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "PowerdownAfterShutdown" /T REG_SZ /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "RestartApps" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" /V "DisableStartupSound" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen" /V "SlideshowDuration" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableFirstLogonAnimation" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ShutdownWithoutLogon" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "SynchronousMachineGroupPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "SynchronousUserGroupPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "UndockWithoutLogon" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics\Credential Provider" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics\FacialFeatures" /V "EnhancedAntiSpoofing" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /V "NoLockScreen" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /V "NoLockScreenCamera" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /V "NoLockScreenSlideshow" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "DisableAcrylicBackgroundOnLogon" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Logon Screen On Resume
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop" /V "ScreenSaverIsSecure" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System\Power" /V "PromptPasswordOnResume" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Welcome Screen
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoWelcomeScreen" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoWelcomeScreen" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Windows Spotlight
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableWindowsConsumerFeatures" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "ConfigureWindowsSpotlight" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableCloudOptimizedContent" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableSoftLanding" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableThirdPartySuggestions" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableWindowsConsumerFeatures" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableWindowsSpotlightFeatures" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableWindowsSpotlightOnActionCenter" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableWindowsSpotlightOnSettings" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableWindowsSpotlightWindowsWelcomeExperience" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "IncludeEnterpriseSpotlight" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableThirdPartySuggestions" /T REG_DWORD /D "1" /F >NUL 2>&1

ECHO :::::::: Privacy
:::: General
:: Advertising ID
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /V "DisabledByGroupPolicy" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Current\Device\Bluetooth" /V "AllowAdvertising" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Current\Device\Browser" /V "AllowAddressBarDropdown" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Let Websites Provide Locally Relevant Content By Accessing My Language List
REG Add "HKEY_USERS\.Default\Control Panel\International\User Profile" /V "HttpAcceptLanguageOptOut" /T REG_DWORD /D "1" /F >NUL 2>&1
:::: Speech
:::: Inking ^& Typing Personalization
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" /V "AllowLinguisticDataCollection" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\InputPersonalization" /V "AllowInputPersonalization" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputPersonalization" /V "RestrictImplicitInkCollection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputPersonalization" /V "RestrictImplicitTextCollection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /V "HarvestContacts" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\TIPC" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Personalization\Settings" /V "AcceptedPrivacyPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Personalization\Settings" /V "RestrictImplicitInkCollection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Personalization\Settings" /V "RestrictImplicitInkCollection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Personalization\Settings" /V "RestrictImplicitTextCollection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Personalization\Settings" /V "RestrictImplicitTextCollection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /V "PreventHandwritingErrorReports" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /V "PreventHandwritingErrorReports" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /V "PreventHandwritingDataSharing" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /V "PreventHandwritingDataSharing" /T REG_DWORD /D "1" /F >NUL 2>&1
:::: Diagnostics ^& Feedback
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Diagnostics\Performance" /V "DisableDiagnosticTracing" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Diagnostics\Performance\BootCKCLSettings" /V Start /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Diagnostics\Performance\SecondaryLogonCKCLSettings" /V Start /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Diagnostics\Performance\ShutdownCKCLSettings" /V Start /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\ScheduledDiagnostics" /V "EnabledExecution" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EventLog\ProtectedEventLogging" /V "EnableProtectedEventLogging" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\ScriptedDiagnosticsProvider\Policy" /V "DisableQueryRemoteServer" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{C295FBBA-FD47-46AC-8BEE-B1715EC634E5}" /V "DownloadToolsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{C295FBBA-FD47-46AC-8BEE-B1715EC634E5}" /V "ScenarioExecutionEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{EB73B633-3F4E-4BA0-8F60-8F3C6F53168F}" /V "EnabledScenarioExecutionLevel" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{EB73B633-3F4E-4BA0-8F60-8F3C6F53168F}" /V "ScenarioExecutionEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Microsoft Help and Feedback
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /V "PeriodInNanoSeconds" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /V "NumberOfSIUFInPeriod" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /V "NoActiveHelp" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /V "NoExplicitFeedback" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /V "NoImplicitFeedback" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /V "NoOnlineAssist" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /V "NoActiveHelp" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /V "NoExplicitFeedback" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /V "NoImplicitFeedback" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /V "NoOnlineAssist" /T REG_DWORD /D "1" /F >NUL 2>&1
:: F1 key - Help and Support
REG Add "HKEY_CURRENT_USER\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\Win32" /ve /T REG_SZ /D "" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\Win64" /ve /T REG_SZ /D "" /F >NUL 2>&1
TASKLIST | FIND /I "HelpPane.exe" && TASKKILL /F /IM HelpPane.exe >NUL 2>&1
IF EXIST %SYSTEMROOT%\HelpPane.exe (TAKEOWN /F %SYSTEMROOT%\HelpPane.exe && ICACLS %SYSTEMROOT%\HelpPane.exe /INHERITANCE:R /REMOVE Administrators) >NUL 2>&1
:: Telemetry
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "AllowTelemetry" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /V "AllowTelemetry" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack"  /V "DiagTrackAuthorization" /T REG_DWORD /D "7" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "DisableDiagnosticDataViewer" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "DoNotShowFeedbackNotifications" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /V "ShowedToastAtLevel" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "AllowCommercialDataPipeline" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "AllowDeviceNameInDiagnosticData" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "ConfigureMicrosoft365UploadEndpointValue" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "LimitEnhancedDiagnosticDataWindowsAnalytics" /T REG_DWORD /D "1" /F >NUL 2>&1
:: .NET Core CLI telemetry
SETX DOTNET_CLI_TELEMETRY_OPTOUT 1 >NUL 2>&1
:: PowerShell 7^+ telemetry
SETX POWERSHELL_TELEMETRY_OPTOUT 1 >NUL 2>&1
:: Windows Messaging and Customer Experience Improvement Program (CEIP)
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Messenger\Client" /V "CEIP" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Messenger\Client" /V "PreventRun" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\IE" /V "CEIPEnable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\IE" /V "SqmLoggerRunning" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\Reliability" /V "CEIPEnable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\Reliability" /V "SqmLoggerRunning" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\Windows" /V "CEIPEnable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\Windows" /V "DisableOptinExperience" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\Windows" /V "SqmLoggerRunning" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppV\CEIP" /V "CEIPEnable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Messenger\Client" /V "CEIP" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Messenger\Client" /V "PreventAutoRun" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Messenger\Client" /V "PreventRun" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /V "CEIPEnable" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Windows Performance PerfTrack Log
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{9C5A40DA-B965-4FC3-8781-88DD50A6299D}" /V "ScenarioExecutionEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Tailored Experiences
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /V "TailoredExperiencesWithDiagnosticDataEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /V "TailoredExperiencesWithDiagnosticDataEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Activity History (Activity Feed / Timeline)
:: App Permissions
:: Location Tracking and Sensors
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /V "SensorPermissionState" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /V "DisableLocation" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /V "DisableLocationScripting" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /V "DisableSensors" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /V "DisableWindowsLocationProvider" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Geolocation
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /V "Status" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /V "Value" /T reg_SZ /D "Deny" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /V "Value" /T reg_SZ /D "Deny" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetooth" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\cellularData" /V "Value" /T reg_SZ /D "Deny" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" /V "Value" /T reg_SZ /D "Deny" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /V "Value" /T reg_SZ /D "Deny" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /V "Value" /T reg_SZ /D "Deny" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\gazeInput" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\humanInterfaceDevice" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" /V "Value" /T reg_SZ /D "Deny" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" /V "Value" /T reg_SZ /D "Deny" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\sensors.custom" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\serialCommunication" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\usb" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /V "Value" /T reg_SZ /D "Deny" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\WiFiData" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\WiFiDirect" /V "Value" /T reg_SZ /D "Allow" /F >NUL 2>&1

ECHO :::::::: System
:::: Notifications ^& Actions
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /V "NoToastApplicationNotification" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /V "NoToastApplicationNotificationOnLockScreen" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\System" /V "DisableLockScreenAppNotifications" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /V "UseActionCenterExperience" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /V "NoTileApplicationNotification" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ActionCenter\Quick Actions\All\SystemSettings_Launcher_QuickNote" /V "Type" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Explorer" /V "DisableNotificationCenter" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /V "NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /V "NOC_GLOBAL_SETTING_ALLOW_Notification_SOUND" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /V "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /V "NOC_GLOBAL_SETTING_TOASTS_ENABLED" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /V "AudioEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /V "LockScreenToastEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /V "NoCloudApplicationNotification" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /V "NoTileApplicationNotification" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /V "NoToastApplicationNotification" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /V "ToastEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Power ^& Sleep
:: Get Rid of Fast StartUp, Hibernation and Sleep functions (4 minutes monitor off)
POWERCFG /H OFF >NUL 2>&1
POWERCFG /SETACVALUEINDEX SCHEME_CURRENT SUB_BUTTONS SBUTTONACTION 0 >NUL 2>&1
POWERCFG /SETDCVALUEINDEX SCHEME_CURRENT SUB_BUTTONS SBUTTONACTION 0 >NUL 2>&1
POWERCFG /X -Disk-TimeOut-AC 0 >NUL 2>&1
POWERCFG /X -Disk-TimeOut-DC 0 >NUL 2>&1
POWERCFG /X -Hibernate-TimeOut-AC 0 >NUL 2>&1
POWERCFG /X -Hibernate-TimeOut-DC 0 >NUL 2>&1
POWERCFG /X -Monitor-TimeOut-AC 4 >NUL 2>&1
POWERCFG /X -Monitor-TimeOut-DC 4 >NUL 2>&1
POWERCFG /X -Standby-TimeOut-AC 0 >NUL 2>&1
POWERCFG /X -Standby-TimeOut-DC 0 >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "HiberbootEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /V "HiberbootEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /V "HibernateEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Start Menu Options
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /V "ShowHibernateOption" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /V "ShowSleepOption" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /V "ShowLockOption" /T REG_DWORD /D "1" /F >NUL 2>&1
:: WinHTTP Registrations
REG Add "HKEY_CURRENT_USER\SOFTWARE\Classes\Localettings\SOFTWARE\Microsoft\Windows\CurrentVersion\AppContainer\Mappings" /V "CleanupLeakedContainerRegistrations" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" /V "CleanupLeakedContainerRegistrations" /T REG_DWORD /D "1" /F >NUL 2>&1
:::: Storage
:: Storage Sense
REG Delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense" /F >NUL 2>&1
:: Enhanced Storage Devices
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EnhancedStorageDevices" /V "TCGSecurityActivationDisabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Disable Reserved Storage
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /V "MiscPolicyInfo" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /V "PassedPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /V "ShippedWithReserves" /T REG_DWORD /D "0" /F >NUL 2>&1
DISM /Online /Set-ReservedStorageState /State:Disabled >NUL 2>&1
:::: Tablet
:: Multitasking (Snap windows - refer to explorer customizations)
:: Activity Feed / Timeline
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "EnableActivityFeed" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\System" /V "PublishUserActivities" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\System" /V "UploadUserActivities" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Shared Experiences
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "EnableCdp" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "EnableMmx" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /V "CdpSessionUserAuthzPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /V "NearShareChannelUserAuthzPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /V "RomeSdkChannelUserAuthzPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP\SettingsPage" /V "BluetoothLastDisabledNearShare" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP\SettingsPage" /V "NearShareChannelUserAuthzPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
:: SharedLocal Folder
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\AppModel\StateManager" /V "AllowSharedLocalAppData" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Clipboard
:: Clipboard History
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Clipboard" /V "EnableClipboardHistory" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\System" /V "AllowClipboardHistory" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Sync Across Devices
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\System" /V "AllowCrossDeviceClipboard" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Remote Desktop
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule" /V "DisableRPCoverTCP" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoRDS" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "AllowSignedFiles" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "AllowUnsignedFiles" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "CreateEncryptedOnlyTickets" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "DisablePasswordSaving" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "TSAppCompat" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "TSEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "TSUserEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "fAllowToGetHelp" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "fAllowUnsolicited" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "fAllowUnsolicitedFullControl" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "fDenyTSConnections" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "fDisableCdm" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "fEncryptRPCTraffic" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client" /V "fEnableUsbBlockDeviceBySetupClass" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client" /V "fEnableUsbNoAckIsochWriteToDevice" /T REG_DWORD /D80 /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client" /V "AllowBasic" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client" /V "AllowDigest" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" /V "AllowUnencryptedTraffic" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service\WinRS" /V "AllowRemoteShellAccess" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /V "AllowRemoteRPC" /T reg_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /V "StartRCM" /T reg_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /V "TSUserEnabled" /T reg_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /V "fDenyTSConnections" /T reg_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-TCP" /V "UserAuthentication" /T REG_DWORD /D "1" /F >NUL 2>&1
:::: Remote Assistance
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /V "AllowRemoteRPC" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /V "CreateEncryptedOnlyTickets" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /V "fAllowFullControl" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /V "fAllowToGetHelp" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /V "fEnableChatControl" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: AutoLogger
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\WMI\AutoLogger\SQMLogger" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\EventLog-Application" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\EventLog-Security" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\EventLog-Security" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\EventLog-System" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\IntelPTTEKRecertIFication" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\IntelRST" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\NetCore" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\RadioMgr" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\WinPhoneCritical\{A9C11050-9E93-4fa4-8FE0-7C4750A345B2}" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Tracing\SystemSettings_RASAPI32" /V "EnableAutoFileTracing" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Tracing\SystemSettings_RASAPI32" /V "EnableConsoleTracing" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Tracing\SystemSettings_RASAPI32" /V "EnableFileTracing" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Tracing\SystemSettings_RASMANCS" /V "EnableAutoFileTracing" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Tracing\SystemSettings_RASMANCS" /V "EnableConsoleTracing" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Tracing\SystemSettings_RASMANCS" /V "EnableFileTracing" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AITEventLog" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AppModel" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AppPlat" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\Audio" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\BioEnrollment" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\Circular Kernel Context Logger" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\DataMarket" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\DefenderApiLogger" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\DefenderAuditLogger" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\DiagLog" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\Diagtrack-Listener" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\FaceCredProv" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\FaceTel" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\HolographicDevice" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\iclsClient" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\iclsProxy" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\LwtNetLog" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\Mellanox-Kernel" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\Microsoft-Windows-Rdp-Graphics-RdpIdd-Trace" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\Microsoft-Windows-Setup" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\NBSMBLOGGER" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\NtfsLog" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\PEAuthLog" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\RdrLog" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\ReadyBoot" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SetupPlatform" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SetupPlatformTel" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SocketHeciServer" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SpoolerLogger" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\TCPIPLOGGER" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\TileStore" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\Tpm" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\TPMProvisioningService" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\UBPM" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\WdiContextLog" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\WFP-IPsec Trace" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\WiFiDriverIHVSession" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\WiFiDriverIHVSessionRepro" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\WiFiDriverSession" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\WiFiSession" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Crash Control
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "AlwaysKeepMemoryDump" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "AutoReboot" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "CrashDumpEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "DisplayParameters" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "DumpLogLevel" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "EnableLogFile" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "LogEvent" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "MinidumpsCount" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "Overwrite" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "SendAlert" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl\StorageTelemetry" /V "DeviceDumpEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: DISM Servicing Options
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /V "EnableDpxLog" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /V "EnableLog" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /V "DisableRemovePayload" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /V "DisableComponentBackups" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /V "DisableResetbase" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /V "LatentActions" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /V "NumCBSPersistLogs" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /V "SupersededActions" /T REG_DWORD /D "1" /F >NUL 2>&1
:::: Memory Management
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "SystemPages" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization" /V "MinVmVersionForCpuBasedMitigations" /T REG_SZ /D "1.0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /V "ProtectionMode" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /V "SafeDLLSearchMode" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "ClearPageFileAtShutdown" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "DisablePagingExecutive" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "Featuresettings" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "FeaturesettingsOverride" /T REG_DWORD /D "72" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "FeaturesettingsOverrideMask" /T REG_DWORD /D "3" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "LargeSystemCache" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "SwapfileControl" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /V "DisableExceptionChainValidation" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /V "RestrictAnonymousSAM" /T REG_DWORD /D "1" /F >NUL 2>&1
:::: OOBE
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /V "ScoobeSystemSettingEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\OOBE" /V "DisablePrivacyExperience" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OOBE" /V "DisablePrivacyExperience" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "DisableVoice" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "HideEULAPage" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "SkipMachineOOBE" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "SkipUserOOBE" /T REG_DWORD /D "1" /F >NUL 2>&1
:::: Windows Explorer Clean and Speed UP
:: Active Desktop (obsolete in Win10?)
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /V "NoAddingComponents" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /V "NoClosingComponents" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /V "NoComponents" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /V "NoDeletingComponents" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /V "NoEditingComponents" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /V "NoHTMLWallPaper" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "ForceActiveDesktopOn" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoActiveDesktop" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoActiveDesktopChanges" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Application Suggestions and Automatic Installation (ContentDeliveryManager)
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy" /V "Disabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "ContentDeliveryAllowed" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "FeatureManagementEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "OemPreInstalledAppsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "PreInstalledAppsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "PreInstalledAppsEverEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "ReInstalledAppsEverEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "RotatingLockScreenEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "RotatingLockScreenOverlayEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SilentInstalledAppsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SlideShowEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SoftlandingEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-202913Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-202914Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280797Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280810Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280811Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280812Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280813Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280814Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280815Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280817Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-310091Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-310092Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-310093Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-310094Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-314558Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-314559Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-314562Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-314563Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-314566Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-314567Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338380Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338381Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338382Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338386Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338387Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338388Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338389Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338393Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-346480Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-346481Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-353694Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-353695Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-353696Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-353697Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-353698Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-353699Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000044Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000045Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000105Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000106Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000161Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000162Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000163Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000164Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000165Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000166Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SystemPaneSuggestionsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\310093" /V "AllowPartialContentAvailability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SilentInstalledAppsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SilentInstalledAppsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /F >NUL 2>&1
:: Automatic Refresh (F5)
REG Add "HKEY_CLASSES_ROOT\CLSID\{BDEADE7F-C265-11D0-BCED-00A0C90AB50F}\Instance" /V "DontRefresh" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CLASSES_ROOT\WoW6432Node\CLSID\{BDEADE7F-C265-11D0-BCED-00A0C90AB50F}\Instance" /V "DontRefresh" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\EXPLORER.EXE" /V "DontUseDesktopChangeRouter" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoRemoteChangeNotIFy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoRemoteRecursiveEvents" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop" /V "ExplorerRefreshOnRename" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Update" /V "UpdateMode" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Automatically Hide Scroll Bars
REG Add "HKEY_CURRENT_USER\Control Panel\Accessibility" /V "DynamicScrollbars" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Command Prompt Instead of PowerShell
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DontUsePowerShellOnWinX" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Confirm Delete Dialog Box
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "ConfirmFileDelete" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "ConfirmFileDelete" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Default Drag n Drop
:: 0 or delete = Default action / 1 = Always copy / 2 = Always move / 4 = Always create shortcut
::REG Add "HKEY_CLASSES_ROOT\AllFileSystemObjects" /V "DefaultDropEffect" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Desktop Gadgets
REG Delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /V "DisableCharmsHint" /F >NUL 2>&1
REG Delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /V "DisableTLcorner" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /V "DisableCharmsHint" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /V "DisableTLcorner" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Windows\Sidebar" /V "TurnOffSidebar" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Windows\Sidebar" /V "TurnOffUnsignedGadgets" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Windows\Sidebar" /V "TurnOffUserInstalledGadgets" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Desktop Icons
:: My Computer on Desktop
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Recycled Bin on Desktop
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{645FF040-5081-101B-9F08-00AA002F954E}" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{645FF040-5081-101B-9F08-00AA002F954E}" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Network on Desktop
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{208D2C60-3AEA-1069-A2D7-08002B30309D}" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{208D2C60-3AEA-1069-A2D7-08002B30309D}" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Control Panel
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "﻿{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "﻿{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /T REG_DWORD /D "1" /F >NUL 2>&1
:: User's Files
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{59031A47-3F72-44A7-89C5-5595FE6B30EE}" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{59031A47-3F72-44A7-89C5-5595FE6B30EE}" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{59031A47-3F72-44A7-89C5-5595FE6B30EE}" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{59031A47-3F72-44A7-89C5-5595FE6B30EE}" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{59031A47-3F72-44A7-89C5-5595FE6B30EE}" /F >NUL 2>&1
:: Quick Access Show Frequent Folders and Recent Files
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134EF9C-6B18-4996-AD04-ED5912E00EB5}" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3936E9E4-D92C-4EEE-A85A-BC16D5EA0819}" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134EF9C-6B18-4996-AD04-ED5912E00EB5}" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3936E9E4-D92C-4EEE-A85A-BC16D5EA0819}" /F >NUL 2>&1
:: Remove 3D Objects
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /F >NUL 2>&1
:: Remove Desktop
::REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /F >NUL 2>&1
::REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /F >NUL 2>&1
:: Remove Documents
::REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /F >NUL 2>&1
::REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{D3162B92-9365-467A-956B-92703ACA08AF}" /F >NUL 2>&1
::REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43BE-B5FD-F8091C1C60D0}" /F >NUL 2>&1
::REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{D3162B92-9365-467A-956B-92703ACA08AF}" /F >NUL 2>&1
:: Remove Downloads
::REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088E3905-0323-4B02-9826-5D99428E115F}" /F >NUL 2>&1
::REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /F >NUL 2>&1
::REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088E3905-0323-4B02-9826-5D99428E115F}" /F >NUL 2>&1
::REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /F >NUL 2>&1
:: Remove Music
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3DFDF296-DBEC-4FB4-81D1-6A3438BCF4DE}" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4EBB-811F-33C572699FDE}" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3DFDF296-DBEC-4FB4-81D1-6A3438BCF4DE}" /F >NUL 2>&1
:: Remove Pictures
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24AD3AD4-A569-4530-98E1-AB02F9417AA8}" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4CB0-BBD7-DFA0ABB5ACCA}" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24AD3AD4-A569-4530-98E1-AB02F9417AA8}" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4CB0-BBD7-DFA0ABB5ACCA}" /F >NUL 2>&1
:: Remove Videos
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43BF-BE83-3742FED03C9C}" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{F86FA3AB-70D2-4FC7-9C99-FCBF05467F3A}" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43BF-BE83-3742FED03C9C}" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{F86FA3AB-70D2-4FC7-9C99-FCBF05467F3A}" /F >NUL 2>&1
:: File Explorer Customizations
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "MapNetDrvBtn" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "ClearRecentDocsOnExit" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "DisablePersonalDirChange" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoAutoTrayNotIFy" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoChangeStartMenu" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoInstrumentation" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoRecentDocsHistory" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoStartMenuMFUprogramsList" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "PreXPSP2ShellProtocolBehavior" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "HideRecentlyAddedApps" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoNewAppAlert" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\SOFTWARE\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /V "FolderType" /T REG_SZ /D "NotSpecIFied" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "AlwaysShowMenus" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "AutoCheckSelect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisableThumbnailCache" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisallowShaking" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DontPrettyPath" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "EnableBalloonTips" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "FolderContentsInfoTip" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "Hidden" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "HideDrivesWithNoMedia" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "HideFileExt" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "HideIcons" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "HideMergeConflicts" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "IconsOnly" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "JointResize" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "LaunchTo" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ListviewAlphaSelect" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ListviewShadow" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "LockTaskbar" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NavPaneExpandToCurrentFolder" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NavPaneShowAllFolders" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NoNetCrawling" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NoSharedDocuments" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NoTaskGrouping" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "PersistBrowsers" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "SeparateProcess" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "SharingWizardOn" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowCompColor" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowInfoTip" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowPreviewHandlers" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowSecondsInSystemClock" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowStatusBar" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowSuperHidden" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowSyncProviderNotifications" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowTaskViewButton" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowTypeOverlay" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "SnapAssist" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "SnapFill" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "Start_NotIFyNewApps" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "Start_SearchFiles" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "Start_TrackDocs" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "Start_TrackProgs" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "StoreAppsOnTaskbar" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarAnimations" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarAppsVisibleInTabletMode" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarBadges" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarSizeMove" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarSmallIcons" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "UseCheckBoxes" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "WebView" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "WebViewBarricade" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /V "Append Completion" /T REG_SZ /D "No" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /V "AutoSuggest" /T reg_SZ /D "No" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /V "FullPath" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /V "StartupPage" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Ribbon" /V "MinimizedStateTabletModeOff" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Ribbon" /V "MinimizedStateTabletModeOn" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "DisableSearchBoxSuggestions" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "ExplorerRibbonStartsMinimized" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoUseStoreOpenWith" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "ShowRunAsDIFferentUserInStart" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "ActiveSetupDisabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "ActiveSetupTaskOverride" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "DisableEdgeDesktopShortcutCreation" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "EnableAutoTray" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "ShowFrequent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "ShowRecent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "LocalKnownFoldersMigrated" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "ShowDriveLettersFirst" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "TelemetrySalt" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisablePreviewDesktop" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisallowShaking" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowSuperHidden" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "AllowOnlineTips" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "LinkResolveIgnoreLinkInfo" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoAutoTrayNotIFy" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoCloseDragDropBands" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoDrivesInSendToMenu" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoInternetOpenWith" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoLowDiskSpaceChecks" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoOnlinePrintsWizard" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoPublishingWizard" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoRecentDocsMenu" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoResolveSearch" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoResolveTrack" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoSimpleNetIDList" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoStrCmpLogical" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoToolbarsOnTaskbar" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoWebServices" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoUseStoreOpenWith" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\StigRegKey\Typing\TaskbarAvoidanceEnabled" /V "TaskbarAvoidanceEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Audit Process Creation
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit" /V "ProcessCreationIncludeCmdLine_Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: USB/external Duplicates
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /F >NUL 2>&1
:: File History
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\FileHistory" /V "Disabled" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\FileHistory" /V "Disabled" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Icon Cache
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "Max Cached Icons" /T REG_SZ /D "10240" /F >NUL 2>&1
:: Maintenance
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /V "MaintenanceDisabled" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Mobility Center
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\MobilityCenter" /V "NoMobilityCenter" /T REG_DWORD /D "1" /F >NUL 2>&1
:: MUI Cache
REG Delete "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\MUICache" /F >NUL 2>&1
:: Notepad
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Notepad" /V "StatusBar" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Notepad" /V "fWrapAround" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\SOFTWARE\Microsoft\Notepad" /V "StatusBar" /T REG_DWORD /D "1" /F >NUL 2>&1
:: People Bar
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "HidePeopleBar" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /V "PeopleBand" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /V "PeopleBand" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Provide Locally Relevant Content
REG Add "HKEY_CURRENT_USER\Control Panel\International\User Profile" /V "HttpAcceptLanguageOptOut" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Remove Icon and Thumbnail Cache
::IF EXIST %LOCALAPPDATA%\IconCache.db (ATTRIB -H %LOCALAPPDATA%\IconCache.db & DEL /F /S /Q %LOCALAPPDATA%\IconCache.db & FSUTIL File CreateNew %LOCALAPPDATA%\IconCache.db 0) >NUL 2>&1
::IF EXIST %LOCALAPPDATA%\Microsoft\Windows\Explorer\*.db (ATTRIB -H %LOCALAPPDATA%\Microsoft\Windows\Explorer\*.db & DEL /F /S /Q %LOCALAPPDATA%\Microsoft\Windows\Explorer\*.db) >NUL 2>&1
:: Remove 'Shortcut' Text and Arrow
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "Link" /T REG_BINARY /D "00000000" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" /V "ShortcutNameTemplate" /T REG_SZ /D "%s.lnk" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "Link" /T REG_BINARY /D "00000000" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" /V "ShortcutNameTemplate" /T REG_SZ /D "%s.lnk" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "Link" /T REG_BINARY /D "00000000" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /V "29" /T REG_SZ /D "" /F >NUL 2>&1
:: Remove Video Preview Border on Navigation Pane
REG Add "HKEY_CLASSES_ROOT\SystemFileAssociations\Image" /V "Treatment" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SystemFileAssociations\Image" /V "Treatment" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Show More Details in File Transfer Dialog
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /V "ConfirmationCheckBoxDoForAll" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /V "EnthusiastMode" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /V "ConfirmationCheckBoxDoForAll" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /V "EnthusiastMode" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Speed Up
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /V "VisualFXSetting" /T REG_DWORD /D "3" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop" /V "ActiveWndTrackTimeout" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop" /V "ActiveWndTrkTimeout" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop" /V "AutoColorization" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop" /V "AutoEndTasks" /T REG_SZ /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop" /V "DockMoving" /T REG_SZ /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop" /V "DragFromMaximize" /T REG_SZ /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop" /V "DragFullWindows" /T REG_SZ /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop" /V "FontSmoothing" /T REG_SZ /D "2" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop" /V "ForegroundFlashCount" /T REG_DWORD /D "5" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop" /V "HungAppTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop" /V "LowLevelHooksTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop" /V "MenuShowDelay" /T REG_SZ /D "100" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop" /V "MouseWheelRouting" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop" /V "PaintDesktopVersion" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop" /V "SmoothScroll" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop" /V "UserPreferencesMask" /T REG_BINARY /D "9812038010000000" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop" /V "WaitToKillAppTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop" /V "WaitToKillServiceTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop" /V "ActiveWndTrackTimeout" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop" /V "ActiveWndTrkTimeout" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop" /V "AutoColorization" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop" /V "AutoEndTasks" /T REG_SZ /D "1" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop" /V "DockMoving" /T REG_SZ /D "1" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop" /V "DragFromMaximize" /T REG_SZ /D "1" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop" /V "DragFullWindows" /T REG_SZ /D "1" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop" /V "FontSmoothing" /T REG_SZ /D "2" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop" /V "ForegroundFlashCount" /T REG_DWORD /D "5" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop" /V "HungAppTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop" /V "LowLevelHooksTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop" /V "MenuShowDelay" /T REG_SZ /D "100" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop" /V "MouseWheelRouting" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop" /V "PaintDesktopVersion" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop" /V "SmoothScroll" /T REG_SZ /D "1" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop" /V "UserPrefenrencesMask" /T REG_BINARY /D "9812038010000000" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop" /V "WaitToKillAppTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop" /V "WaitToKillServiceTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /V "StartupDelayInMSec" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "AllowBlockingAppsAtShutdown" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /V "WaitToKillServiceTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\ControlSet001" /V "WaitToKillServiceTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\ControlSet002" /V "WaitToKillServiceTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
:: Keyboard Delay
REG Add "HKEY_CURRENT_USER\Control Panel\Keyboard" /V "KeyboardDelay" /T REG_SZ /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Keyboard" /V "KeyboardSpeed" /T REG_SZ /D "31" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\Control Panel\Keyboard" /V "InitialKeyboardIndicators" /T REG_SZ /D "2147483650" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Keyboard" /V "KeyboardDelay" /T REG_SZ /D "0" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Keyboard" /V "KeyboardSpeed" /T REG_SZ /D "31" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Keyboard" /V "InitialKeyboardIndicators" /T REG_SZ /D "2147483650" /F >NUL 2>&1
:: No Beep
REG Add "HKEY_CURRENT_USER\Control Panel\Sound" /V "Beep" /T REG_SZ /D "no" /F >NUL 2>&1
:: Window Animations
REG Add "HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics" /V "MinAnimate" /T REG_SZ /D "0" /F >NUL 2>&1
REG Add "HKEY_USERS\.Default\Control Panel\Desktop\WindowMetrics" /V "MinAnimate" /T REG_SZ /D "0" /F >NUL 2>&1
:: Task Manager More Details
REG Delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\TaskManager" /V "Preferences" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\TaskManager" /V "StartUpTab" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\TaskManager" /V "UseStatusSetting" /T REG_DWORD /D "1" /F >NUL 2>&1
:: TouchScreen
::REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Wisp\Touch" /V "TouchGate" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Windows Error Reporting
REG Add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /V "DontSendAdditionalData" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /V "Disabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /V "DoReport" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /V "ForceQueueMode" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" /V "DWNoExternalURL" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" /V "DWNoFileCollection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" /V "DWNoSecondLevelCollection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\HelpSvc" /V "Headlines" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\HelpSvc" /V "MicrosoftKBSearch" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /V "DisableSendGenericDriverNotFoundToWER" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /V "DisableSendRequestAdditionalSOFTWAREToWER" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /V "AutoApproveOSDumps" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /V "Disabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /V "DontSendAdditionalData" /T REG_DWORD /D "1" /F >NUL 2>&1
:: WSH
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Script Host\Settings" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Windows Administrative Tools
:: Device Manager
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /V "DEVMGR_SHOW_DETAILS" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /V "DEVMGR_SHOW_NONPRESENT_DeviceS" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Event Viewer
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EventViewer" /V "MicrosoftEventVwrDisableLinks" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Virtualization App-V
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppV\Client" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Windows Explorer Right Click Menu Enhance
:: 3D Edit
REG Delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.3mf\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.bmp\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.fbx\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.gIF\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.glb\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.jfIF\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.jpe\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.jpeg\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.jpg\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.obj\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.ply\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.png\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.stl\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.tIF\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.tIFf\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.3mf\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.bmp\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.fbx\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.gIF\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.glb\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jfIF\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpe\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpeg\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpg\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.obj\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.ply\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.png\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.stl\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.tIF\Shell\3D Edit" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.tIFf\Shell\3D Edit" /F >NUL 2>&1
:: Add to 'New' Menu
IF EXIST "%APPDATA%\Microsoft\Windows\SendTo\Mail recipient.*" DEL /F /S /Q "%APPDATA%\Microsoft\Windows\SendTo\Mail recipient.*" >NUL 2>&1
REG Add "HKEY_CLASSES_ROOT\.cmd\ShellNew" /V "NullFile" /T REG_SZ /D "" /F >NUL 2>&1
REG Add "HKEY_CLASSES_ROOT\Drive\ShellEx\-ContextMenuHandlers\{FBEB8A05-BEEE-4442-804E-409D6C4515E9}" /ve /T REG_SZ /D "" /F >NUL 2>&1
REG Add "HKEY_CLASSES_ROOT\batfile\ShellEx\-ContextMenuHandlers\Compatibility" /ve /T REG_SZ /D "{1D27F844-3A1F-4410-85AC-14651078412D}" /F >NUL 2>&1
REG Add "HKEY_CLASSES_ROOT\cmdfile\ShellEx\-ContextMenuHandlers\Compatibility" /ve /T REG_SZ /D "{1D27F844-3A1F-4410-85AC-14651078412D}" /F >NUL 2>&1
REG Add "HKEY_CLASSES_ROOT\exefile\ShellEx\-ContextMenuHandlers\Compatibility" /ve /T REG_SZ /D "{1D27F844-3A1F-4410-85AC-14651078412D}" /F >NUL 2>&1
:: Allow Mapped Drives in Command Prompt
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableLinkedConnections" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Cast to Device
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /V "{7AD84985-87B4-4A16-BE58-8B72A5B390F7}" /T REG_SZ /D "Play to menu" /F >NUL 2>&1
:: CD Burning
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoCDBurning" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Copy as path
REG Add "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /V "CanonicalName" /T REG_SZ /D "{707C7BC6-685A-4A4D-A275-3966A5A3EFAA}" /F >NUL 2>&1
REG Add "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /V "CommandStateHandler" /T REG_SZ /D "{3B1599F9-E00A-4BBF-AD3E-B3F99FA87779}" /F >NUL 2>&1
REG Add "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /V "CommandStateSync" /T REG_SZ /D "" /F >NUL 2>&1
REG Add "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /V "Description" /T REG_SZ /D "@shell32.dll,-30336" /F >NUL 2>&1
REG Add "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /V "Icon" /T REG_SZ /D "Imageres.dll,-5302" /F >NUL 2>&1
REG Add "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /V "InvokeCommandOnSelection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /V "MUIVerb" /T REG_SZ /D "@shell32.dll,-30329" /F >NUL 2>&1
REG Add "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /V "VerbHandler" /T REG_SZ /D "{F3D06E7C-1E45-4A26-847E-F9FCDEE59BE0}" /F >NUL 2>&1
REG Add "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /V "VerbName" /T REG_SZ /D "copyaspath" /F >NUL 2>&1
REG Add "HKEY_CLASSES_ROOT\AllfileSystemObjects\Shell\Windows.CopyAsPath" /ve /T REG_SZ /D "Copy As Path" /F >NUL 2>&1
:: Copy To / Move To
REG Add "HKEY_CLASSES_ROOT\AllFileSystemObjects\ShellEx\ContextMenuHandlers\Copy To" /ve /T REG_SZ /D "{C2FBB630-2971-11D1-A18C-00C04FD75D13}" /F >NUL 2>&1
REG Add "HKEY_CLASSES_ROOT\AllFileSystemObjects\ShellEx\ContextMenuHandlers\Move To" /ve /T REG_SZ /D "{C2FBB631-2971-11D1-A18C-00C04FD75D13}" /F >NUL 2>&1
:: Extract All Context Menu for ZIP Files
REG Delete "HKEY_CLASSES_ROOT\CompressedFolder\ShellEx\ContextMenuHandlers\{B8CDCB65-B1BF-4B42-9428-1DFDB7EE92AF}" /F >NUL 2>&1
:: Give Access To
::REG Delete "HKEY_CLASSES_ROOT\*\ShellEx\ContextMenuHandlers\Sharing" /F >NUL 2>&1
::REG Delete "HKEY_CLASSES_ROOT\Directory\Background\ShellEx\ContextMenuHandlers\Sharing" /F >NUL 2>&1
::REG Delete "HKEY_CLASSES_ROOT\Directory\ShellEx\ContextMenuHandlers\Sharing" /F >NUL 2>&1
::REG Delete "HKEY_CLASSES_ROOT\Drive\ShellEx\ContextMenuHandlers\Sharing" /F >NUL 2>&1
::REG Delete "HKEY_CLASSES_ROOT\LibraryFolder\background\ShellEx\ContextMenuHandlers\Sharing" /F >NUL 2>&1
::REG Delete "HKEY_CLASSES_ROOT\UserLibraryFolder\ShellEx\ContextMenuHandlers\Sharing" /F >NUL 2>&1
:: Include in Libraries
REG Delete "HKEY_CLASSES_ROOT\Folder\ShellEx\ContextMenuHandlers\Library Location" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\ShellEx\ContextMenuHandlers\Library Location" /F >NUL 2>&1
:: ISO Burn
REG Delete "HKEY_CLASSES_ROOT\Windows.IsoFile\Shell\Burn" /F >NUL 2>&1
:: Login Without Password in "control userpasswords2" or netplwiz
REG Add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device" /V "DevicePasswordLessBuildVersion" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Meet Now
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "HideSCAMeetNow" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "HideSCAMeetNow" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Msi Extract
REG Add "HKEY_CLASSES_ROOT\Msi.Package\Shell\Extract" /VE /T REG_SZ /D "Extract MSI" /F >NUL 2>&1
REG Add "HKEY_CLASSES_ROOT\Msi.Package\Shell\Extract" /V "NeverDefault" /T REG_SZ /D "" /F >NUL 2>&1
REG Add "HKEY_CLASSES_ROOT\Msi.Package\Shell\Extract\Command" /VE  /T REG_SZ /D "msiexec.exe /a "%1" /qb TARGETDIR="%1 Contents"" /F >NUL 2>&1
:: 'New' Menu
REG Delete "HKEY_CLASSES_ROOT\.contact\ShellNew" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\.library-ms\ShellNew" /F >NUL 2>&1
::REG Delete "HKEY_CLASSES_ROOT\Folder\ShellEx\ContextMenuHandlers\Library Location" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\.rtf\ShellNew" /F >NUL 2>&1
:: Number of Selections on Explorer
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "MultipleInvokePromptMinimum" /T REG_DWORD /D "200" /F >NUL 2>&1
:: Pin to Quick Access
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\Shell\PinToHome" /F >NUL 2>&1
:: Restore Previous Versions (File History Properties Tab)
REG Delete "HKEY_CLASSES_ROOT\AllFilesystemObjects\ShellEx\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\ShellEx\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\Directory\ShellEx\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\Drive\ShellEx\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
:: Restore Previous Versions (File History Context Menu)
REG Delete "HKEY_CLASSES_ROOT\AllFilesystemObjects\ShellEx\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\ShellEx\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\Directory\ShellEx\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG Delete "HKEY_CLASSES_ROOT\Drive\ShellEx\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG Delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /V "NoPreviousVersionsPage" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "NoPreviousVersionsPage" /F >NUL 2>&1
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PreviousVersions" /V "DisableLocalPage" /F >NUL 2>&1
REG Delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /V "NoPreviousVersionsPage" /F >NUL 2>&1
REG Delete "HKEY_CURRENT_USER\Software\Policies\Microsoft\PreviousVersions" /V "DisableLocalPage" /F >NUL 2>&1
:: 'Share'
::REG Delete "HKEY_CLASSES_ROOT\*\ShellEx\ContextMenuHandlers\ModernSharing" /F >NUL 2>&1
:: Windows Picture and Fax Viewer
REG Delete "HKEY_CLASSES_ROOT\SystemFileAssociations\Image\ShellEx\ContextMenuHandlers\ShellImagePreview" /F >NUL 2>&1
:: Win-X Menu Shortcuts
::IF NOT exist "%LOCALAPPDATA%\Microsoft\Windows\WinX\Group2\Registry Editor" (mklink /h "%LOCALAPPDATA%\Microsoft\Windows\WinX\Group2\Registry Editor" %SYSTEMROOT%\regedit.exe) >NUL 2>&1
::IF NOT exist "%LOCALAPPDATA%\Microsoft\Windows\WinX\Group3\Services" (mklink "%LOCALAPPDATA%\Microsoft\Windows\WinX\Group3\Services" %SYSTEMROOT%\System32\services.msc) >NUL 2>&1

::ECHO :::::::: Time ^& Language
:: Date ^& time
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\tzautoupdate" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" /V "DynamicDaylightTimeDisabled" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" /V "TimeZoneKeyName" /T REG_SZ /D "Eastern Standard Time" /F >NUL 2>&1

ECHO :::::::: Update ^& Security
:::: Windows Update
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /V "DisableWindowsUpdateAccess" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services" WaaSMedicSvc /V Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsoSvc" /V "DelayedAutoStart" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /V "AllowMUUpdateService" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /V "AutoInstallMinorUpdates" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /V "NoAutoRebootWithLoggedOnUsers" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Windows Store Automatic Updates
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /V "AutoDownload" /T REG_DWORD /D "2" /F >NUL 2>&1
:: Drivers Update
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /V "PreventDeviceMetadataFromNetwork" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" /V "PreventDeviceMetadataFromNetwork" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Current\Device\Update" /V "ExcludeWUDriversInQualityUpdate" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Default\Update" /V "ExcludeWUDriversInQualityUpdate" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Default\Update\ExcludeWUDriversInQualityUpdate" /V "Value" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /V "ExcludeWUDriversInQualityUpdate" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /V "ExcludeWUDriversInQualityUpdate" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /V "ExcludeWUDriversInQualityUpdate" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Other MS Products Update
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Services\7971F918-A847-4430-9279-4A52D1EFE18D" /V "RegisteredWithAU" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Maps updates
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\Maps" /V "AutoUpdateEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps" /V "AutoDownloadAndUpdateMapData" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps" /V "AllowUntriggeredNetworkTrafficOnSettingsPage" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Delivery Optimization
REG Add "HKEY_USERS\S-1-5-20\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /V "DownloadMode" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /V "SystemSettingsDownloadMode" /T REG_DWORD /D "0" /F >NUL 2>&1
:::::::: Windows Security
:: Windows Defender
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender" /V "DisableAntiVirus" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features" /V "TamperProtection" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" /V "SubmitSamplesConsent" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows Security Health\State" /V "AccountProtection_MicrosoftAccount_Disconnected" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows Security Health\State" /V "AppAndBrowser_StoreAppsSmartScreenOff" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" /V "DisableEnhancedNotifications" /T reg_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" /V "DisableNotifications" /T reg_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender Security Center\Virus and Threat Protection" /V "SummaryNotificationDisabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /V "DontOfferThroughWUAU" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /V "DontReportInfectionInformation" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" /V "MpEnablePus" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /V "DisableGenericReports" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /V "CheckForSignaturesBeforeRunningScan" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" /V "DisableBlockAtFirstSeen" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" /V "LocalSettingOverrideSpyNetReporting" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" /V "SpyNetReporting" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" /V "SpyNetReportingLocation" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Core Isolation / Device Guard
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /V "EnableVirtualizationBasedSecurity" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /V "RequirePlatformSecurityFeatures" /T REG_DWORD /D "3"  /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /V "LsaCfgFlags" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Network Protection
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Network Protection" /V "EnableNetworkProtection" /T REG_DWORD /D "1" /F >NUL 2>&1
:: SmartScreen
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "EnableSmartScreen" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "ShellSmartScreenLevel" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /V "ContentEvaluation" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /V "EnableWebContentEvaluation" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "SmartScreenEnabled" /T REG_SZ /D "On" /F >NUL 2>&1
:: Boot-Start Driver Initialization Policy
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\EarlyLaunch" /V "DriverLoadPolicy" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Windows Insider Program
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Current\Device\System" /V "AllowExperimentation" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Default\SYSTEM\AllowExperimentation" /V "Value" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /V "HideInsiderPage" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /V "AllowBuildPreview" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /V "EnableConfigFlighting" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /V "EnableExperimentation" /T REG_DWORD /D "0" /F >NUL 2>&1
:: License Telemetry
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /V "NoGenTicket" /T REG_DWORD /D "1" /F >NUL 2>&1

ECHO :::::::: Windows Search, Cortana, Indexing/Prefetch
TASKLIST | FIND /I "SearchUI.exe" & TASKKILL /F /IM SearchUI.exe
RD /S /Q "%SYSTEMROOT%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy" /F >NUL 2>&1
REG Add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Cortana.exe" /V "Debugger" /t REG_SZ /d "%SYSTEMROOT%\System32\taskkill.exe" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Search\Gather\Windows\SystemIndex" /V "EnableFindMyFiles" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowCortanaButton" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "AllowSearchToUseLocation" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "BingSearchEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "CanCortanaBeEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "CortanaConsent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "CortanaEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "CortanaInAmbientMode" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "CortanaSpeechAllowedOverLockScreen" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "DeviceHistoryEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "HasCortanaBeenEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "HistoryViewEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "SearchboxTaskbarMode" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "VoiceShortcut" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Windows Search" /V "CortanaConsent" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "AllowCloudSearch" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "AllowCortana" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "AllowCortanaAboveLock" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "AllowIndexingEncryptedStoresOrItems" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "AllowSearchToUseLocation" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "AlwaysUseAutoLangDetection" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "BingSearchEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "ConnectedSearchPrivacy" /T reg_DWORD /D "3" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "ConnectedSearchSafeSearch" /T reg_DWORD /D "3" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "ConnectedSearchUseWeb" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "ConnectedSearchUseWebOverMeteredConnections" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "DisableWebSearch" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "PreventIndexOnBattery" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "PreventUsingAdvancedIndexingOptions" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /V "IsAADCloudSearchEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /V "IsDeviceSearchHistoryEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /V "IsMSACloudSearchEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /V "SafeSearchMode" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Search Companion
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SearchCompanion" /V "DisableContentFileUpdates" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Prefetch
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /V "EnableBootTrace" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /V "EnablePrefetcher" /T REG_DWORD /D "0" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /V "EnableSuperfetch" /T REG_DWORD /D "0" /F >NUL 2>&1

ECHO :::::::: Scheduled Tasks
::SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Servicing\StartComponentCleanup" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "MicrosoftEdgeUpdateTaskMachineCore" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "MicrosoftEdgeUpdateTaskMachineUA" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Active Directory Rights Management Services Client\AD RMS Rights Policy Template Management (Automated)" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Active Directory Rights Management Services Client\AD RMS Rights Policy Template Management (Manual)" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\AppID\EDP Policy Manager" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\AppID\SmartScreenSpecIFic" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Application Experience\AITAgent" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Application Experience\Consolidator" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Application Experience\KernelCeipTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Application Experience\StartupAppTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Application Experience\UsbCeip" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\ApplicationData\CleanupTemporaryState" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\ApplicationData\DsSvcCleanup" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\ApplicationData\DsSvcCleanup" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\ApplicationData\appuriverIFierdaily" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\ApplicationData\appuriverIFierinstall" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\AppxDeploymentClient\Pre-staged app cleanup" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Autochk\Proxy" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\BrokerInfrastructure\BgTaskRegistrationMaintenanceTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Chkdsk\ProactiveScan" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Clip\License Validation" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\TelTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\DUSM\dusmtask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Defrag\ScheduledDefrag" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Device" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Device User" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Diagnosis\Scheduled" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\DirectX\DXGIAdapterCache" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\DirectX\DirectXDatabaseUpdater" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\DiskCleanup\SilentCleanup" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\DiskFootprint\Diagnostics" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\DiskFootprint\StorageSense" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\ErrorDetails\EnableErrorDetailsUpdate" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\ErrorDetails\ErrorDetailsUpdate" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Feedback\Siuf\DmClient" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Flighting\FeatureConfig\ReconcileFeatures" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Flighting\FeatureConfig\UsageDataFlushing" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Flighting\OneSettings\RefreshCache " >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\HelloFace\FODCleanupTask " >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Input\LocalUserSyncDataAvailable" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Input\MouseSyncDataAvailable" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Input\PenSyncDataAvailable" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Input\TouchpadSyncDataAvailable" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\International\Synchronize Language Settings" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\LanguageComponentsInstaller\Installation" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\LanguageComponentsInstaller\Uninstallation" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\License Manager\TempSignedLicenseExchange" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Location\Notifications" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Location\WindowsActionDialog" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\MUI\LPRemove" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Maintenance\WinSAT" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Management\Provisioning\Cellular" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Management\Provisioning\Logon" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Maps\MapsToastTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Maps\MapsUpdateTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Mobile Broadband Accounts\MNO Metadata Parser" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\NlaSvc\WiFiTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Offline Files\Synchronization" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\PI\Secure-Boot-Update" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\PI\Sqm-Tasks" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\PerfTrack\BackgroundConfigSurveyor" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\PushToInstall\LoginCheck" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\PushToInstall\Registration" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Ras\MobilityManager" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\RecoveryEnvironment\VerIFyWinRE" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\RetailDemo\CleanupOfflineContent" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\SettingSync\BackgroundUploadTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\SettingSync\BackgroundUploadTaskDisabled" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\SettingSync\BackupTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\SettingSync\NetworkStateChangeTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\SetupSQMTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Setup\SetupCleanupTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Shell\FamilySafetyMonitorToastTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Shell\FamilySafetyRefreshTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Shell\FamilySafetyUpload" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Shell\IndexerAutomaticMaintenance" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\SpacePort\SpaceAgentTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\SpacePort\SpaceManagerTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Speech\SpeechModelDownloadTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Storage Tiers Management\Storage Tiers Management Initialization" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Storage Tiers Management\Storage Tiers Optimization" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Subscription\EnableLicenseAcquisition" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Subscription\LicenseAcquisition" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Sysmain\ResPriStaticDbSync" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Sysmain\WsSwapAssessmentTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\SystemRestore\SR" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\TPM\Tpm-HASCertRetr" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\TPM\Tpm-Maintenance" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Task Manager\Interactive" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\TextServicesFramework\MsCtfMonitor" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\UpdateOrchestrator\Battery Saver Deferred Install" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\UpdateOrchestrator\Maintenance Install" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\UpdateOrchestrator\Policy Install" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\UpdateOrchestrator\Reboot" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\UpdateOrchestrator\Reboot_AC" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\UpdateOrchestrator\Reboot_Battery" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\UpdateOrchestrator\Refresh Settings" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\UpdateOrchestrator\Report policies" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\UpdateOrchestrator\Resume On Boot" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Maintenance Work" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Wake To Work" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Work" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\UpdateOrchestrator\USO_UxBroker_Display" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\UpdateOrchestrator\USO_UxBroker_ReadyToReboot" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\UpdateOrchestrator\UpdateModelTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\WCM\WiFiTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\WDI\ResolutionHost" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\WOF\WIM-Hash-Management" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\WOF\WIM-Hash-Validation" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\WS\WSTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Windows Error Reporting\QueueReportingDisabled" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Windows Media Sharing\UpdateLibrary" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\WindowsUpdate\Scheduled Start" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\WindowsUpdate\sih" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\WindowsUpdate\sihboot" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Wininet\CacheTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\WlanSvc\CDSSync" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Work Folders\Work Folders Logon Synchronization" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Work Folders\Work Folders Maintenance Work" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Workplace Join\Automatic-Device-Join" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Workplace Join\Device-Sync" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Workplace Join\Device-Sync" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\WwanSvc\NotificationTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\WwanSvc\OobeDiscovery" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\XblGameSave\Xbgm" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\XblGameSave\XblGameSaveTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\XblGameSave\XblGameSaveTaskLogon" >NUL 2>&1
NETSH AdvFirewall Firewall Add Rule Name="Compatability Telemetry Runner" Action="Block" Dir="In" Interface="Any" Program="%SYSTEMDRIVE%\Windows\System32\CompatTelRunner.exe" Description="Disallow CompatTelRunner to connect in from the Internet." Enable=Yes >NUL 2>&1
NETSH AdvFirewall Firewall Add Rule Name="Compatability Telemetry Runner" Action="Block" Dir="Out" Interface="Any" Program="%SYSTEMDRIVE%\Windows\System32\CompatTelRunner.exe" Description="Disallow CompatTelRunner to connect out to the Internet." Enable=Yes >NUL 2>&1

ECHO :::::::: Services
::for /D%%G in (CertPropSvc,CDPSvc,CDPUserSvc,CscService,DiagTrack,DoSvc,DevicesFlow,DevicesFlowUserSvc,DevQueryBroker,DsmSvc,DusmSvc,DPS,diagnosticshub.standardcollector.service,dmwappushservice,MapsBroker,MessagingService,OneSyncSvc,PimIndexMaintenanceSvc,PrintWorkflowUserSvc,PcaSvc,RemoteRegistry,SmsRouter,Spooler,TrkWks,StiSvc,SecurityHealthService,Sense,UnistoreSvc,UserDataSvc,WpnUserService,WerSvc,WMPNetworkSvc,WSearch,WdNisDrv,WdNisSvc,WinDefend) do (
::sc Config %%G start= disabled )
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DeviceAssociationBrokerSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iphlpsvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sense" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SensorDataService" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wlidsvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TabletInputService" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AJRouter" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ALG" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Application Experience\Microsoft Compatibility Appraiser" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Application Experience\ProgramDataUpdater" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Application Experience\StartupAppTask" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CertPropSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Clip\License Validation" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CredentialEnrollmentManagerUserSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Customer Experience Improvement Program\Consolidator" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Customer Experience Improvement Program\KernelCeipTask" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Customer Experience Improvement Program\UsbCeip" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DiagTrack" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DmWapPushService" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DoSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EntAppSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FDResPub" /V "Start" /T REG_DWORD /D "2" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HelloFace\FODCleanupTask" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HomeGroupListener" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HomeGroupProvider" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\icssvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\idsvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManworkstation" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lfsvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MapsBroker" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Maps\MapsToastTask" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Maps\MapsUpdateTask" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MessagingService" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MessagingService_60731" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MixedRealityOpenXRSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mrxsmb10" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mrxsmb\Parameters" /V "RefuseReset" /T REG_DWORD /D "1" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MSiSCSI" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MsLldp" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ms_lltdio" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ms_msclient" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ms_pacer" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ms_rspndr" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NaturalAuthentication" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Ndu" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBIOS" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetTCPPortSharing" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PcaSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\perceptionsimulation" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PhoneSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc_60731" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PrintWorkflowUserSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RemoteAccess" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RemoteRegistry" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RetailDemo" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\seclogon" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SEMgrSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SessionEnv" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\sgrmbroker" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedRealitySvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\shpamsvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SNMPTRAP" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\spectrum" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SysMain" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TermService" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UmRdpService" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UnistoreSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UnistoreSvc_60731" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UserDataSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UserDataSvc_60731" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicguestinterface" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicheartbeat" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmickvpexchange" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicrdv" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicshutdown" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmictimesync" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicvmsession" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicvss" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WbioSrvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wcncsvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wercplsupport" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WerSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinHttpAutoProxySvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinRM" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wisvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WMPNetworkSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WpcMonSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WSearch" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\xbgm" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XblAuthManager" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XblGameSave" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XboxGipSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1

:::::::: Settings Control Panel Clean-Up
REG Add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "SettingsPageVisibility" /T REG_SZ /D "hide:mobile-Devices;maps;gaming-gamebar;gaming-gamedvr;gaming-broadcasting;gaming-gamemode;gaming-xboxnetworking;cortana-windowssearch;cortana-talktocortana;cortana-permissions;cortana-moredetails;windowsinsider;holographic-audio;privacy-holographic-environment;holographic-headset;holographic-management;remotedesktop" /F >NUL 2>&1

ECHO. & ECHO Tweaks Have Been Completed Sucessefully.
ECHO. & ECHO Additionally you can run a script to remove unnecessary Windows Features and Windows UWP Applications.
CHOICE /T 15 /C YN /D N /M "Would you like to REMOVE these Features?"
IF %ERRORLEVEL%==1 (GOTO :Bloatware) ELSE (GOTO :Reboot)

:Reboot
ECHO. & ECHO Your SYSTEM needs to reboot for changes to take effect. & choice.exe /T 15 /C YN /D N /M "Would you like to REBOOT now?"
IF %ERRORLEVEL%==1 (SHUTDOWN /R /F /D P:4:1 /T 5 /C "Windows 10 C-OL - Custom Tweaks Collection Script") ELSE (CALL EXPLORER.EXE)
GOTO :EOF

:Bloatware
ECHO. & ECHO NOTICE: It can take some time while all Features are been removed.
ECHO :::::::: Windows Capabilities
::DISM /online /Remove-Capability /CapabilityName:Language.Basic~~~en-US~0.0.1.0 >NUL 2>&1
::DISM /online /Remove-Capability /CapabilityName:Media.WindowsMediaPlayer~~~~0.0.12.0 >NUL 2>&1
::DISM /online /Remove-Capability /CapabilityName:Microsoft.Windows.MSPaint~~~~0.0.1.0 >NUL 2>&1
::DISM /online /Remove-Capability /CapabilityName:Microsoft.Windows.Notepad~~~~0.0.1.0 >NUL 2>&1
::DISM /online /Remove-Capability /CapabilityName:Microsoft.Windows.PowerShell.ISE~~~~0.0.1.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:Analog.Holographic.Desktop~~~~0.0.1.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:App.StepsRecorder~~~~0.0.1.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:App.Support.QuickAssist~~~~0.0.1.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:Browser.InternetExplorer~~~~0.0.11.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:Hello.Face.18330~~~~0.0.1.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:Hello.Face.18967~~~~0.0.1.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:Hello.Face.Migration.18330~~~~0.0.1.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:Hello.Face.Migration.18967~~~~0.0.1.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:Language.Handwriting~~~en-US~0.0.1.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:Language.OCR~~~en-US~0.0.1.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:Language.Speech~~~en-US~0.0.1.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:Language.TextToSpeech~~~en-US~0.0.1.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:MathRecognizer~~~~0.0.1.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:Microsoft.Windows.WordPad~~~~0.0.1.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:OneCoreUAP.OneSync~~~~0.0.1.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:OpenSSH.Client~~~~0.0.1.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:OpenSSH.Server~~~~0.0.1.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:Print.Fax.Scan~~~~0.0.1.0 >NUL 2>&1
DISM /online /Remove-Capability /CapabilityName:XPS.Viewer~~~~0.0.1.0 >NUL 2>&1
ECHO :::::::: Windows Features
DISM /online /Disable-Feature /FeatureName:"DirectPlay" >NUL 2>&1
DISM /online /Disable-Feature /FeatureName:"Microsoft-Windows-Subsystem-Linux" >NUL 2>&1
DISM /online /Disable-Feature /FeatureName:"MicrosoftWindowsPowerShellV2" >NUL 2>&1
DISM /online /Disable-Feature /FeatureName:"MicrosoftWindowsPowerShellV2Root" >NUL 2>&1
DISM /online /Disable-Feature /FeatureName:"MSRDC-Infrastructure" >NUL 2>&1
DISM /online /Disable-Feature /FeatureName:"Printing-Foundation-Features" >NUL 2>&1
DISM /online /Disable-Feature /FeatureName:"Printing-Foundation-InternetPrinting-Client" >NUL 2>&1
DISM /online /Disable-Feature /FeatureName:"Printing-Foundation-LPDPrintService" >NUL 2>&1
DISM /online /Disable-Feature /FeatureName:"Printing-Foundation-LPRPortMonitor" >NUL 2>&1
DISM /online /Disable-Feature /FeatureName:"Printing-XPSServices-Features" >NUL 2>&1
DISM /online /Disable-Feature /FeatureName:"SMB1Protocol" >NUL 2>&1
DISM /online /Disable-Feature /FeatureName:"SMB1Protocol-Client" >NUL 2>&1
DISM /online /Disable-Feature /FeatureName:"SMB1Protocol-Deprecation" >NUL 2>&1
DISM /online /Disable-Feature /FeatureName:"SMB1Protocol-Server" >NUL 2>&1
DISM /online /Disable-Feature /FeatureName:"WCF-TCP-PortSharing45" >NUL 2>&1
DISM /online /Disable-Feature /FeatureName:"WorkFolders-Client" >NUL 2>&1

ECHO :::::::: Windows UWP Applications
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.3DBuilder* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.549981C3F5F10* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Advertising.Xaml* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Appconnector* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.BingFinance* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.BingFoodAndDrink* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.BingHealthAndFitness* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.BingMaps* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.BingNews* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.BingSports* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.BingTranslator* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.BingTravel* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.BingWeather* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.CommsPhone* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.ConnectivityStore* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.FreshPaint* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.GetHelp* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.GetStarted* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Groove* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.HelpAndTips* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Media.PlayReadyClient* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Messaging* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Microsoft3DViewer* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.MicrosoftEdge* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.MicrosoftEdgeDevToolsClient* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.MicrosoftPowerBIForWindows* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.MixedReality.Portal* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.MSPaint* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Office.OneNote* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Office.Sway* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.OfficeLens* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.OneConnect* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.People* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Print3D* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Reader* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.RemoteDesktop* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.ScreenSketch* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.SkypeApp* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Todos* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Wallet* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Whiteboard* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.windowscommunicationsapps* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.WindowsMaps* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.WindowsPhone* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.WindowsReadingList* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.WindowsScan* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.WindowsSoundRecorder* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.WinJS.1.0* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.WinJS.2.0* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Xbox.TCUI* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.XboxApp* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.XboxGamingOverlay* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.XboxIdentityProvider* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.XboxSpeechToTextOverlay* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.YourPhone* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.ZuneMusic* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.ZuneVideo* | Remove-AppxPackage -AllUsers" >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *XboxOneSmartGlass* | Remove-AppxPackage -AllUsers" >NUL 2>&1
ECHO :::::::: Windows UWP Provisioned Applications
::PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WebMediaExtensions*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
::PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Windows.Photos*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
::PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WindowsAlarms*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
::PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WindowsCamera*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.3DBuilder*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.549981C3F5F10*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Advertising.Xaml*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Appconnector*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.BingFinance*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.BingFoodAndDrink*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.BingHealthAndFitness*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.BingMaps*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.BingNews*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.BingSports*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.BingTranslator*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.BingTravel*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.BingWeather*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.CommsPhone*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.ConnectivityStore*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.FreshPaint*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.GetHelp*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.GetStarted*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Groove*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.HelpAndTips*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Media.PlayReadyClient*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Messaging*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Microsoft3DViewer*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.MicrosoftEdge*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.MicrosoftEdgeDevToolsClient*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.MicrosoftOfficeHub*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.MicrosoftPowerBIForWindows*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.MicrosoftSolitaireCollection*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.MicrosoftStickyNotes*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.MixedReality.Portal*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.MSPaint*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Office.OneNote*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Office.Sway*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.OfficeLens*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.OneConnect*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.People*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Print3D*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Reader*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.RemoteDesktop*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.ScreenSketch*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.SkypeApp*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Todos*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Wallet*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Whiteboard*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.windowscommunicationsapps*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WindowsFeedbackHub*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WindowsMaps*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WindowsPhone*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WindowsReadingList*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WindowsScan*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WindowsSoundRecorder*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WinJS.1.0*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WinJS.2.0*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Xbox.TCUI*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.XboxApp*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.XboxGamingOverlay*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.XboxIdentityProvider*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.XboxSpeechToTextOverlay*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.YourPhone*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.ZuneMusic*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.ZuneVideo*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*XboxOneSmartGlass*'} | Remove-AppXProvisionedPackage -Online" >NUL 2>&1
GOTO :Reboot

:EOF
EXIT
