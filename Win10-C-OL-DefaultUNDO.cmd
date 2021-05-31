::
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


ECHO :::::::: * UAC Level *
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ConsentPromptBehaviorAdmin" /T REG_DWORD /D "5" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ConsentPromptBehaviorUser" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableInstallerDetection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableLUA" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableVirtualization" /T REG_DWORD /D "1" /F >NUL 2>&1

REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "PromptOnSecureDesktop" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ValidateAdminCodeSignatures" /T REG_DWORD /D "0" /F >NUL 2>&1

REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "LocalAccountTokenFilterPolicy" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "FilterAdministratorToken" /F >NUL 2>&1


ECHO :::::::: Accounts
:: Remove DefaultUser0 Account
::NET USER DefaultUser0 /DELETE >NUL 2>&1
:: Password Expiration
::NET ACCOUNTS /MaxPwAge:Unlimited >NUL 2>&1
:: Set User TEMP to Windows TEMP
::IF EXIST "%LOCALAPPDATA%\TEMP" RD /S /Q "%LOCALAPPDATA%\TEMP" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\Environment" /V "TEMP" /T REG_SZ /D "%SYSTEMROOT%\TEMP" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\Environment" /V "TMP" /T REG_SZ /D "%SYSTEMROOT%\TEMP" /F >NUL 2>&1
:: Microsoft.com accounts (Block Sign-in Microsoft account)
:: 0 = Allow / 1 = can't ADD / 3 = can't ADD or login
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "MSAOptional" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "NoConnectedUser" /F >NUL 2>&1
:: Security Questions for Local Accounts
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "NoLocalPasswordResetQuestions" /F >NUL 2>&1
:: Sync Your Settings
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /V "Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync" /V "Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /V "Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /V "Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /V "Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /V "Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "EnableBackupForWin8Apps" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /V "SyncPolicy" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Messaging" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableApplicationSettingSync" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableApplicationSettingSyncUserOverride" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableAppSyncSettingSync" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableAppSyncSettingSyncUserOverride" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableCredentialsSettingSync" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableCredentialsSettingSyncUserOverride" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableDesktopThemeSettingSync" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableDesktopThemeSettingSyncUserOverride" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisablePersonalizationSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisablePersonalizationSettingSyncUserOverride" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableSettingSyncUserOverride" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableStartLayoutSettingSync" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableStartLayoutSettingSyncUserOverride" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableSyncOnPaidNetwork" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableWebBrowserSettingSync" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableWebBrowserSettingSyncUserOverride" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableWindowsSettingSync" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableWindowsSettingSyncUserOverride" /F >NUL 2>&1


ECHO :::::::: Apps ^& Features
:::: Application Compatibility
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\TelemetryController" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\AIT" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\AppRaiser" /V "HaveUploadedForTarget" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /V "DontRetryOnError" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /V "IsCensusDisabled" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /V "TaskEnableRun" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Tracing" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\NoExecuteState" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CompatTelRunner.exe" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DeviceCensus.exe" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PushToInstall" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /F >NUL 2>&1
:: Compatibility Troubleshoot
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /V "{1d27f844-3a1f-4410-85ac-14651078412d}" /T REG_SZ /D "" /F >NUL 2>&1
:: Classic Paint
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Paint\Settings" /F >NUL 2>&1
:: Microsoft Edge and Internet Explorer
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EdgeUpdate" /V "DoNotUpdateToEdgeWithChromium" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MicrosoftEdge.exe" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\msedge.exe" /F >NUL 2>&1
:: IE Harden
REG DELETE "HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /F >NUL 2>&1
::REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main" /V "Default_Page_URL" /T REG_SZ /D "about:blank" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main" /V "NoProtectedModeBanner" /F >NUL 2>&1
::REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main" /V "Start Page" /T REG_SZ /D "about:blank" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\PhishingFilter" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "AutoDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "IEHarden" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "IntranetName" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "ProxyBypass" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "UNCAsIntranet" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\WoW6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "IEHarden" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4B3F-8CFC-4F3A74704073}" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4B3F-8CFC-4F3A74704073}" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer" /V "IntegratedBrowser" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "DisableEdgeDesktopShortcutCreation" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /V "MaxConnectionsPer1_0Server" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /V "MaxConnectionsPerServer" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "AutoDetect" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "IEHarden" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "IntranetName" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "ProxyBypass" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "UNCAsIntranet" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /V "CallLegacyWCMPolicies" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /V "EnableHTTP2" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /V "EnableSSL3Fallback" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /V "PreventIgnoreCertErrors" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4B3F-8CFC-4F3A74704073}" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "IEHarden" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\SOFTWARE\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedgedevtoolsclient_8wekyb3d8bbwe" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\SOFTWARE\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main" /V "First Home Page" /F >NUL 2>&1
:: Microsoft OneDrive
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Storage\EnabledDenyGP" /V "DenyAllGPState" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\OneDrive" /V "PreventNetworkTrafficPreUserSignIn" /F >NUL 2>&1
:::::::: .NET Framework
:: Strong Cryptography
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /V "SchUseStrongCrypto" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /V "SystemDefaultTLSVersions" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v3.0" /V "SchUseStrongCrypto" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v3.0" /V "SystemDefaultTLSVersions" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" /V "SchUseStrongCrypto" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" /V "SystemDefaultTLSVersions" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework\v2.0.50727" /V "SchUseStrongCrypto" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework\v2.0.50727" /V "SystemDefaultTLSVersions" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework\v3.0" /V "SchUseStrongCrypto" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework\v3.0" /V "SystemDefaultTLSVersions" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework\v4.0.30319" /V "SchUseStrongCrypto" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework\v4.0.30319" /V "SystemDefaultTLSVersions" /F >NUL 2>&1
:: Use Latest CLR
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework" /V "OnlyUseLatestCLR" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework" /V "OnlyUseLatestCLR" /F >NUL 2>&1
:: Windows Installer in Safe Mode
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\MSIServer" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\MSIServer" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Installer" /F >NUL 2>&1
:: Windows Media Player
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MediaPlayer" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /F >NUL 2>&1
:: Prevent Windows Media Digital Rights Management (DRM)
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WMDRM" /F >NUL 2>&1
:: AppX
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Appx" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "AicEnabled" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FVE" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\AppModel\StateManager" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /V "AllowDevelopmentWithoutDevLicense" /F >NUL 2>&1


ECHO :::::::: Devices
:::: Mouse
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "ActiveWindowTracking" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "Beep" /T REG_SZ /D "No" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "ExtendedSounds" /T REG_SZ /D "No" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "MouseHoverTime" /T REG_SZ /D "400" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "MouseSensitivity" /T REG_SZ /D "10" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "MouseSpeed" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "MouseTrails" /T REG_SZ /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "MouseThreshold1" /T REG_SZ /D "6" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "MouseThreshold2" /T REG_SZ /D "10" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "SnapToDefaultButton" /T REG_SZ /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "SwapMouseButtons" /T REG_SZ /D "0" /F >NUL 2>&1
:::: Typing
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\CTF\LangBar" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\Settings" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" /F >NUL 2>&1
:: Keyboard On Screen
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Osk" /V "BounceTime" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Osk" /V "FirstRepeatDelay" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Osk" /V "KeystrokeDelay" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Osk" /V "NextRepeatDelay" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\TabletTip\1.7" /V "EnableKeyAudioFeedback" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\TabletTip\1.7" /V "EnableTextPrediction" /F >NUL 2>&1
:::: Pen ^& Windows Ink
:: PenWorkspace
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace" /V "PenWorkspaceAppSuggestionsEnabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace" /V "PenWorkspaceButtonDesiredVisibility" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" /F >NUL 2>&1
:::: AutoPlay
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main" /V "Autorun" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /V "DisableAutoplay" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoAutorun" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoAutoplayfornonVolume" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoDriveTypeAutoRun" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "DontSetAutoplayCheckbox" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CDROM" /V "Autorun" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\IniFileMapping\Autorun.inf" /F >NUL 2>&1
:::::::: Hardware Related Tweaks
:: Block Legacy File System Filter Drivers
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /V "IoBlockLegacyFsFilters" /F >NUL 2>&1
:: Camera Fix?
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Media Foundation\Platform" /V "EnableFrameServerMode" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows Media Foundation\Platform" /V "EnableFrameServerMode" /F >NUL 2>&1
:: Camera On/Off OSD Notifications
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\OEM\Device\Capture" /V "NoPhysicalCameraLED" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Intel AHCI
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iaStorAC" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iaStorAVC" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iaStorV" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\storahci" /F >NUL 2>&1
:: Enable Legacy F8 Bootmenu
BCDEDIT /Set {Current} BootMenuPolicy STANDARD >NUL 2>&1
:: Enforce Device Driver Signing (Default)
::BCDEDIT /Set LoadOptions DENABLE_INTEGRITY_CHECKS >NUL 2>&1
::BCDEDIT /Set TESTSIGNING OFF >NUL 2>&1
:: Hardware Accelerated GPU Scheduling
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /V "HwSchMode" /T REG_DWORD /D "2" /F >NUL 2>&1
:: Windows Data Execution Prevention (DEP)
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoDataExecutionPrevention" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoHeapTerminationOnCorruption" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "DisableHHDEP" /F >NUL 2>&1
::BCDEDIT /Set {Current} NX OptOut >NUL 2>&1
:: NTFS File System
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "ContigFileAllocSize" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "LongPathsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsAllowExtendedCharacter8dot3Rename" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsDisable8dot3NameCreation" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsDisableLastAccessUpdate" /T REG_DWORD /D "2147483650" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsEnableTxfDeprecatedFunctionality" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsMemoryUsage" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsMftZoneReservation" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "Win31FileSystem" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "Win95TruncatedExtensions" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Split Threshold for Svchost (for 16GB RAM)
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /V "SvcHostSplitThresholdInKB" /T REG_DWORD /D "3670016" /F >NUL 2>&1
:: NvCache
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NvCache" /F >NUL 2>&1
:: DiskQuota
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DiskQuota" /F >NUL 2>&1
:: Kernel DMA
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Kernel DMA Protection" /F >NUL 2>&1
:: HTTP Printing
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Printers" /F >NUL 2>&1


ECHO :::::::: Ease of Access
:::: Narrator
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "CoupleNarratorCursorKeyboard" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "ECHOChars" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "ECHOWords" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "ErrorNotificationType" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "FollowInsertion" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "IntonationPause" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "NarratorCursorHighlight" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "PlayAudioCues" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "ReadHints" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NarratorHome" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "ContextVerbosityLevel" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "ContextVerbosityLevelV2" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "DetailedFeedback" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "DuckAudio" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "ECHOToggleKeys" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "OnlineServicesEnabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "ScriptingEnabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "UserVerbosityLevel" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "WinEnterLaunchEnabled" /F >NUL 2>&1
:::: Speech
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /V "ModelDownloadAllowed" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /V "VoiceActivationEnableAboveLockscreen" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /V "VoiceActivationOn" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Settings" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /V "ModelDownloadAllowed" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /V "VoiceActivationDefaultOn" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Speech" /F >NUL 2>&1


ECHO :::::::: Gaming
:: Game Bar / Game Mode
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar" /V "AllowAutoGameMode" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar" /V "AutoGameModeEnabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar" /V "ShowStartupPanel" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameUX" /F >NUL 2>&1
:: Captures
REG ADD "HKEY_CURRENT_USER\SYSTEM\GameConfigStore" /V "GameDVR_Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /V "AppCaptureEnabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /V "HistoricalCaptureEnabled" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /F >NUL 2>&1
:: SmartGlass
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" /V "BluetoothPolicy" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" /V "UserAuthPolicy" /F >NUL 2>&1


ECHO :::::::: Mixed Reality
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Holographic" /V "FirstRunSucceeded" /T REG_DWORD /D "0" /F >NUL 2>&1


ECHO :::::::: Network ^& Internet
:: Active Probing
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /V "EnableActiveProbing" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /V "NoActiveProbe" /F >NUL 2>&1 
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /V "DisablePassivePolling" /F >NUL 2>&1 
:: Admin Shares
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "AutoShareServer" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "AutoShareWks" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "IRPStackSize" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "RequireSecuritySignature" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "RestrictNullSessAccess" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "Size" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "SMB1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "SMB2" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /V "SMBDeviceEnabled" /F >NUL 2>&1
:: Adobe Type Manager
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /V "DisableATMFD" /F >NUL 2>&1
:: BranchCache
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PeerDist" /F >NUL 2>&1
:: BITS
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\BITS" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\BITS" /F >NUL 2>&1
:: Block Files From Internet
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /F >NUL 2>&1
REG DELETE "HKEY_USERS\.Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Associations\ModRiskFileTypes" /F >NUL 2>&1
:: Certificate Revocation Check
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "AuthenticodeEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: CredSSP Encryption
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /F >NUL 2>&1
:: Detailed Data Usage
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DusmSvc\Settings" /F >NUL 2>&1
:: DNS
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNSCache\Parameters" /V "DisableParallelAandAAAA" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNSCache\Parameters" /V "MaxCacheTTL" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNSCache\Parameters" /V "MaxNegativeCacheTTL" /F >NUL 2>&1
:: Encrypt and Sign Outgoing Secure Channel
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" /V "RequireStrongKey" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" /V "SealSecureChannel" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" /V "SignSecureChannel" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Ethernet as Metered Connection
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\DefaultMediaCost" /V "Ethernet" /T REG_DWORD /D "2" /F >NUL 2>&1
:: Find My Device
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Settings\FindMyDevice" /F >NUL 2>&1
:: Hotspot 2.0 Networks
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WlanSvc\AnqpCache" /V "OsuRegistrationStatus" /T REG_DWORD /D "1" /F >NUL 2>&1
:: IIS Installation
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\IIS" /F >NUL 2>&1
:: Internet Connection Sharing
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Network Connections" /V "NC_ShowSharedAccessUI" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Intranet Protected Mode
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main" /V "NoProtectedModeBanner" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main" /V "NoProtectedModeBanner" /F >NUL 2>&1
:: Microsoft Peer-to-Peer Networking Services
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Peernet" /V "Disabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: NetBIOS over TCP/IP
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\NetBT\Parameters" /V "NetbiosOptions" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /V "NoNameReleaseOnDemand" /F >NUL 2>&1
:: Network Auto Install
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup" /V "GlobalAutoSetup" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Domain" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Public" /F >NUL 2>&1
:: Password Reveal
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CredUI" /V "DisablePasswordReveal" /T REG_DWORD /D "1" /F
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" /V "DisablePasswordReveal" /T REG_DWORD /D "1" /F
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredUI" /V "DisablePasswordReveal" /T REG_DWORD /D "1" /F
:: Require trusted path for credential entry
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI" /F >NUL 2>&1
:: Restrict Anonymous Enumeration Shares
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LanManWorkstation" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /V "DisableRemoteScmEndpoints" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "DisableDomainCreds" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "EveryoneIncludesAnonymous" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "ForceGuest" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "LimitBlankPasswordUse" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "LmCompatibilityLevel" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "LsaCfgFlags" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "NoLMHash" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "RestrictAnonymous" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "RestrictAnonymousSAM" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "RestrictRemoteSAM" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "RunAsPPL" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "SCENoApplyLegacyAuditPolicy" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "SecureBoot" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "SubmitControl" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\FIPSAlgorithmPolicy" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" /V "AllowNullSessionFallback" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" /V "RestrictReceivingNTLMTraffic" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" /V "RestrictSendingNTLMTraffic" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" /V "NTLMMinClientSec" /T REG_DWORD /D "536870912" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" /V "NTLMMinServerSec" /T REG_DWORD /D "536870912" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\PKU2U" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" /V "UseLogonCredential" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManWorkstation\Parameters" /V "DisableBandwidthThrottling" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManWorkstation\Parameters" /V "EnableSecuritySignature" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManWorkstation\Parameters" /V "RequireSecuritySignature" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManWorkstation\Parameters" /V "EnablePlainTextPassword" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Kerberos
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters" /F >NUL 2>&1
:: LDAP
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LDAP" /V "LDAPClientIntegrity" /T REG_DWORD /D "1" /F >NUL 2>&1
:: RPC Unauthenticated Connections
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\RPC" /F >NUL 2>&1
:: MMThrottling
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /V "NetworkThrottlingIndex" /T REG_DWORD /D "10" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /V "SystemResponsiveness" /T REG_DWORD /D "20" /F >NUL 2>&1
:: Limit Reservable Bandwidth 
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Psched" /F >NUL 2>&1
:: MSMQ
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSMQ\Parameters" /F >NUL 2>&1
:: svchost.exe Security Mitigation
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SCMConfig" /F >NUL 2>&1
:: TCP/IP
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /V "EnableDynamicBacklog" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "ForwardBroadcasts" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "IPEnableRouter" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "BSDUrgent" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DeadGWDetect" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DeadGWDetectDefault" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DefaultRcvWindow" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DefaultTOS" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DefaultTTL" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DisableIPSourceRouting" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DisableTaskOffload" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DontADDDefaultGatewayDefault" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableADDrMaskReply" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableDeadGWDetect" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableDynamicBacklog" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableICMPRedirect" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableMultiCastForwarding" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnablePMTUBHDetect" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnablePMTUDiscovery" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableRSS" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableSecurityFilters" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableWsd" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "GlobalMaxTCPWindowSize" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "IGMPLevel" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "KeepAliveInterval" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "KeepAliveTime" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "MaxUserPort" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "PerformRouterDiscovery" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "PMTUBlackHoleDetect" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "QualifyingDestinationThreshold" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "SackOpts" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "SynAttackProtect" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCP1323Opts" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPMaxConnectResponseRetransmissions" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPMaxDataRetransmissions" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPMaxDupAcks" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPMaxHalOpen" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPMaxHalOpenRetired" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPMaxPortsExhausted" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPTimedWaitDelay" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPUseRFC1122UrgentPointer" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPWindowSize" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "UseDomainNameDevolution" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "UseZeroBroadCast" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\QoS" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\ServiceProvider" /V "DnsPriority" /T REG_DWORD /D "2000" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\ServiceProvider" /V "HostsPriority" /T REG_DWORD /D "500" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\ServiceProvider" /V "LocalPriority" /T REG_DWORD /D "499" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\ServiceProvider" /V "NetbtPriority" /T REG_DWORD /D "2001" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "BSDUrgent" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DeadGWDetect" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DeadGWDetectDefault" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DefaultRcvWindow" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DefaultTOS" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DefaultTTL" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DisableIPSourceRouting" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DisableTaskOffload" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DontADDDefaultGatewayDefault" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableADDrMaskReply" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableDeadGWDetect" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableDynamicBacklog" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableICMPRedirect" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableMultiCastForwarding" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnablePMTUBHDetect" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnablePMTUDiscovery" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableRSS" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableSecurityFilters" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableWsd" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "ForwardBroadcasts" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "GlobalMaxTCPWindowSize" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "IGMPLevel" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "IPEnableRouter" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "KeepAliveInterval" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "KeepAliveTime" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "MaxUserPort" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "PerformRouterDiscovery" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "PMTUBlackHoleDetect" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "QualifyingDestinationThreshold" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "SackOpts" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "SynAttackProtect" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCP1323Opts" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPMaxConnectResponseRetransmissions" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPMaxDataRetransmissions" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPMaxDupAcks" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPMaxHalOpen" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPMaxHalOpenRetired" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPMaxPortsExhausted" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPTimedWaitDelay" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPUseRFC1122UrgentPointer" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPWindowSize" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "UseDomainNameDevolution" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "UseZeroBroadCast" /F >NUL 2>&1
:: TCP Timestamps
::NETSH Int TCP Set Global TimeStamps=Disabled >NUL 2>&1
:: VPN related
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PolicyAgent" /V "AssumeUDPEncapsulationContextOnSendRule" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\Parameters" /V "DisableIKENameEkuCheck" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\Parameters" /V "NegotiateDH2048_AES256" /F >NUL 2>&1
:: WaitNetworkStartup
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Winlogon\SyncForegroundPolicy" /F >NUL 2>&1
:: WiFi Sense and Hot Spot
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /V "Value" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Default\WiFi\AllowWiFiHotSpotReporting" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager" /V "WiFiSenseCredShared" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager" /V "WiFiSenseOpen" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Config" /V "AutoConnectAllowedOEM" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Config" /V "DefaultAutoConnectSharedState" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Config" /V "WiFiSenseAllowed" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Config" /V "WiFiSharingFacebookInitial" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Config" /V "WiFiSharingOutlookInitial"/F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Config" /V "WiFiSharingSkypeInitial" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\crowdsrcplugin" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy" /V "fMinimizeConnections" /F >NUL 2>&1
:: Windows Connect Now
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\UI" /F >NUL 2>&1
:: Windows Mail
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Mail" /F >NUL 2>&1
:: UNC HardenedPaths
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths" /V "\\*\NETLOGON"  /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths" /V "\\*\SYSVOL" /F >NUL 2>&1
:: ECCCurves
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002" /V "EccCurves" /T REG_MULTI_SZ /D "NistP384 NistP256" /F >NUL 2>&1
:: WBEM
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WBEM\CIMOM" /V "EnableEvents" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WBEM\CIMOM" /V "Logging" /T REG_SZ /D "0" /F >NUL 2>&1
:: SCHANNEL
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2" /F >NUL 2>&1


ECHO :::::::: Personalization
:::: Display (125%)
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\GraphicsDrivers\ScaleFactors\MSBDD_NOEDID_8086_591E_00000000_00020000_0^F4AFC1D490A41A696F160EE50B7BC0E9" /V "DpiValue" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\GraphicsDrivers\ScaleFactors\MSNILNOEDID_1414_008D_FFFFFFFF_FFFFFFFF_0^030B4FCE00727AC1593E5B6FD18648D6" /V "DpiValue" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\GraphicsDrivers\ScaleFactors\SHP146A0_24_07E0_39^75456C06EC4F911F5356A9227E7D0CF6" /V "DpiValue" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\Control Panel\Desktop\PerMonitorSettings\SHP146A0_24_07E0_39^75456C06EC4F911F5356A9227E7D0CF6" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AutoRotation" /V "LastOrientation" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Colors
:: Dark Mode
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /V "AppsUseLightTheme" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /V "SystemUsesLightTheme" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Transparency
::REG ADD "HKEY_USERS\.Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /V "EnableTransparency" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /V "ColorPrevalence" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /V "EnableTransparency" /T REG_DWORD /D "1" /F >NUL 2>&1
:: DWM
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "AnimationAttributionEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "AnimationAttributionHashingEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "AlwaysHibernateThumbnails" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "Animations" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "ColorPrevalence" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "ColorizationBlurBalance" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "ColorizationGlassAttribute" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "ColorizationOpaqueBlend" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "Composition" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "DisallowAnimations" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "DisallowFlip3d" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "DisableAccentGradient" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "EnableAeroPeek" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "EnableWindowColorization" /F >NUL 2>&1
:::: Lock Screen
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "PasswordExpiryWarning" /T REG_SZ /D "5" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "DisableAutomaticRestartSignOn" /T REG_SZ /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "DontDisplayLastUsername" /T REG_SZ /D "0" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "ParseAutoexec" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\AccessPage\Camera" /V "CameraEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "AllocateCDRoms" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "AllocateFloppies" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "AutoRestartShell" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "EnableFirstLogonAnimation" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "ParseAutoexec" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "PowerdownAfterShutdown" /T REG_SZ /D "0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "RestartApps" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "SFCDisable" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" /V "DisableStartupSound" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen" /V "SlideshowDuration" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableFirstLogonAnimation" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ShutdownWithoutLogon" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "SynchronousMachineGroupPolicy" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "SynchronousUserGroupPolicy" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "UndockWithoutLogon" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "DisableAcrylicBackgroundOnLogon" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "EnableLogonOptimization" /F >NUL 2>&1
:: Biometrics
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics" /F >NUL 2>&1
:: Logon Screen On Resume
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop" /V "ScreenSaverIsSecure" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System\Power" /V "PromptPasswordOnResume" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Welcome Screen
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoWelcomeScreen" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoWelcomeScreen" /F >NUL 2>&1
:: Windows Spotlight
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableWindowsConsumerFeatures" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableTailoredExperiencesWithDiagnosticData" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /F >NUL 2>&1

ECHO :::::::: Privacy
:::: General
:: Advertising ID
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /V "DisabledByGroupPolicy" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Current\Device\Bluetooth" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Current\Device\Browser" /F >NUL 2>&1
:: Let Websites Provide Locally Relevant Content By Accessing My Language List
REG DELETE "HKEY_USERS\.Default\Control Panel\International\User Profile" /V "HttpAcceptLanguageOptOut" /F >NUL 2>&1
:::: Speech
:::: Inking ^& Typing Personalization
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" /V "AllowLinguisticDataCollection" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\InputPersonalization" /V "AllowInputPersonalization" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputPersonalization" /V "DisablePersInternal" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputPersonalization" /V "RestrictImplicitInkCollection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputPersonalization" /V "RestrictImplicitTextCollection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /V "HarvestContacts" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\TIPC" /V "Enabled" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Personalization\Settings" /V "AcceptedPrivacyPolicy" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Personalization\Settings" /V "RestrictImplicitInkCollection" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Personalization\Settings" /V "RestrictImplicitTextCollection" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /F >NUL 2>&1
:::: Diagnostics ^& Feedback
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Diagnostics\Performance" /V "DisableDiagnosticTracing" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Diagnostics\Performance\BootCKCLSettings" /V Start /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Diagnostics\Performance\SecondaryLogonCKCLSettings" /V Start /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Diagnostics\Performance\ShutdownCKCLSettings" /V Start /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\ScheduledDiagnostics" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EventLog\ProtectedEventLogging" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\ScriptedDiagnostics" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\ScriptedDiagnosticsProvider\Policy" /V "DisableQueryRemoteServer" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{C295FBBA-FD47-46AC-8BEE-B1715EC634E5}" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{EB73B633-3F4E-4BA0-8F60-8F3C6F53168F}" /F >NUL 2>&1
:: Microsoft Help and Feedback
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /F >NUL 2>&1
:: F1 key - Help and Support
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\Win32" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\Win64" /F >NUL 2>&1
:: Telemetry
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "AllowTelemetry" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "DisableDiagnosticDataViewer" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "DoNotShowFeedbackNotifications" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /V "ShowedToastAtLevel" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /F >NUL 2>&1
:: .NET Core CLI telemetry
::SETX DOTNET_CLI_TELEMETRY_OPTOUT 1 >NUL 2>&1
:: PowerShell 7^+ telemetry
::SETX POWERSHELL_TELEMETRY_OPTOUT 1 >NUL 2>&1
:: Windows Messaging and Customer Experience Improvement Program (CEIP)
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Messenger\Client" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\IE" /V "CEIPEnable" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\IE" /V "SqmLoggerRunning" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\Reliability" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\Windows" /V "CEIPEnable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\Windows" /V "DisableOptinExperience" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\Windows" /V "SqmLoggerRunning" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppV\CEIP" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Messenger\Client" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /F >NUL 2>&1
:: Windows Performance PerfTrack Log
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{9C5A40DA-B965-4FC3-8781-88DD50A6299D}" /F >NUL 2>&1
:: Tailored Experiences
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /V "TailoredExperiencesWithDiagnosticDataEnabled" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /V "TailoredExperiencesWithDiagnosticDataEnabled" /T REG_DWORD /D "2" /F >NUL 2>&1
:: Activity History (Activity Feed / Timeline)
:: App Permissions
:: Location Tracking and Sensors
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /V "SensorPermissionState" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /V "Status" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Activity" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\AppDiagnostics" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Appointments" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Bluetooth" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\BluetoothSync" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\BroadFileSystemAccess" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\CellularData" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Chat" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Contacts" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\DocumentsLibrary" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Email" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\GazeInput" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\HumanInterfaceDevice" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Location" /V "Value" /T REG_SZ /D "Deny" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Microphone" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\PhoneCall" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\PhoneCallHistory" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\PicturesLibrary" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Radios" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Sensors.Custom" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\SerialCommunication" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Usb" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\UserAccountInformation" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\UserDataTasks" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\UserNotificationListener" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\VideosLibrary" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Webcam" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\WiFiData" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\WiFiDirect" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /F >NUL 2>&1


ECHO :::::::: System
:::: Notifications ^& Actions
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /V "NoToastApplicationNotification" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /V "NoToastApplicationNotificationOnLockScreen" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\System" /V "DisableLockScreenAppNotifications" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /V "UseActionCenterExperience" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "DisableNotificationCenter" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /V "NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /V "NOC_GLOBAL_SETTING_ALLOW_Notification_SOUND" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /V "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /V "NOC_GLOBAL_SETTING_TOASTS_ENABLED" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /V "AudioEnabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /V "LockScreenToastEnabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /V "NoCloudApplicationNotification" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /V "NoTileApplicationNotification" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /V "NoToastApplicationNotification" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /V "ToastEnabled" /F >NUL 2>&1
:::: Power ^& Sleep
:: Get Rid of Fast StartUp, Hibernation and Sleep functions (4 minutes monitor off)
POWERCFG /RestoreDefaultSchemes
POWERCFG /SetActive 381B4222-F694-41F0-9685-FF5BB260DF2E >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /V "HiberbootEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /V "HibernateEnabled" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /V "HibernateEnabledDefault" /F >NUL 2>&1
:: Start Menu Options
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /F >NUL 2>&1
:: WinHTTP Registrations
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Mappings" /V "CleanupLeakedContainerRegistrations" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" /V "CleanupLeakedContainerRegistrations" /F >NUL 2>&1
:::: Storage
:: Storage Sense
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense" /F >NUL 2>&1
:: Enhanced Storage Devices
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EnhancedStorageDevices" /V "TCGSecurityActivationDisabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Disable Reserved Storage
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /V "MiscPolicyInfo" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /V "PassedPolicy" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /V "ShippedWithReserves" /T REG_DWORD /D "1" /F >NUL 2>&1
DISM /Online /Set-ReservedStorageState /State:Enabled >NUL 2>&1
:::: Tablet
:: Multitasking (Snap windows - refer to explorer customizations)
:: Activity Feed / Timeline
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "EnableActivityFeed" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\System" /V "PublishUserActivities" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\System" /V "UploadUserActivities" /F >NUL 2>&1
:::: Shared Experiences
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "EnableCdp" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "EnableMmx" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /V "CDPSessionUserAuthzPolicy" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /V "NearShareChannelUserAuthzPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /V "RomeSDKChannelUserAuthzPolicy" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP\SettingsPage" /F >NUL 2>&1
:::: Clipboard
:: Clipboard History
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Clipboard" /V "EnableClipboardHistory" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\System" /V "AllowClipboardHistory" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\System" /V "AllowCrossDeviceClipboard" /F >NUL 2>&1
:::: Remote Desktop
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule" /V "DisableRPCoverTCP" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /F >NUL 2>&1
:: Terminal Server Shadowing
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /V "AllowRemoteRPC" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /V "StartRCM" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /V "TSUserEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /V "fDenyTSConnections" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /V "fSingleSessionPerUser" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-TCP" /V "UserAuthentication" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-TCP" /V "fDisableEncryption" /T REG_DWORD /D "1" /F >NUL 2>&1
:::: Remote Assistance
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /V "AllowRemoteRPC" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /V "CreateEncryptedOnlyTickets" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /V "fAllowFullControl" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /V "fAllowToGetHelp" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /V "fEnableChatControl" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: AutoLogger
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Tracing\SystemSettings_RASAPI32" /V "EnableAutoFileTracing" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Tracing\SystemSettings_RASAPI32" /V "EnableConsoleTracing" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Tracing\SystemSettings_RASAPI32" /V "EnableFileTracing" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Tracing\SystemSettings_RASMANCS" /V "EnableAutoFileTracing" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Tracing\SystemSettings_RASMANCS" /V "EnableConsoleTracing" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Tracing\SystemSettings_RASMANCS" /V "EnableFileTracing" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AITEventLog" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AppModel" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AppPlat" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\Audio" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\BioEnrollment" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\Circular Kernel Context Logger" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\DataMarket" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\DefenderApiLogger" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\DefenderAuditLogger" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\DiagLog" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\Diagtrack-Listener" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\FaceCredProv" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\FaceTel" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\HolographicDevice" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\IclsClient" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\IclsProxy" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\LwtNetLog" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\Mellanox-Kernel" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\Microsoft-Windows-Rdp-Graphics-RdpIdd-Trace" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\Microsoft-Windows-Setup" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\NBSMBLOGGER" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\NtfsLog" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\PEAuthLog" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\RdrLog" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\ReadyBoot" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SetupPlatform" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SetupPlatformTel" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SocketHeciServer" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SpoolerLogger" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\TCPIPLOGGER" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\TileStore" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\Tpm" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\TPMProvisioningService" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\UBPM" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\WdiContextLog" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\WFP-IPsec Trace" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\WiFiDriverIHVSession" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\WiFiDriverIHVSessionRepro" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\WiFiDriverSession" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\WiFiSession" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
:::: Crash Control
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "AlwaysKeepMemoryDump" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "AutoReboot" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "CrashDumpEnabled" /T REG_DWORD /D "7" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "DisplayParameters" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "DumpLogLevel" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "EnableLogFile" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "LogEvent" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "MinidumpsCount" /T REG_DWORD /D "5" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "Overwrite" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "SendAlert" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl\StorageTelemetry" /V "DeviceDumpEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
:::: DISM Servicing Options
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /V "EnableDpxLog" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /V "EnableLog" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /V "DisableRemovePayload" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /V "DisableComponentBackups" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /V "DisableResetbase" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /V "LatentActions" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /V "NumCBSPersistLogs" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /V "SupersededActions" /F >NUL 2>&1
:::: Memory Management
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "SystemPages" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization" /V "MinVmVersionForCpuBasedMitigations" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /V "CWDIllegalInDllSearch" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /V "ProtectionMode" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /V "SafeDLLSearchMode" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /V "SafeProcessSearchMode" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /V "StartRunNoHOMEPATH" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /V "DisableExceptionChainValidation" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /V "RestrictAnonymousSAM" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "ClearPageFileAtShutdown" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "DisablePagingExecutive" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "Featuresettings" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "FeaturesettingsOverride" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "FeaturesettingsOverrideMask" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "LargeSystemCache" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "SwapFileControl" /F >NUL 2>&1
:::: OOBE
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\OOBE" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "DisableVoice" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "HideEULAPage" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "HideLocalAccountScreen" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "HideOEMRegistrationScreen" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "HideOnlineAccountScreens" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "HideWirelessSetupInOOBE" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "SkipMachineOOBE" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "SkipUserOOBE" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "ProtectYourPC" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "UnattendEnableRetailDemo" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Windows Explorer Clean and Speed UP
:: Active Desktop (obsolete in Win10?)
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /V "NoAddingComponents" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /V "NoClosingComponents" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /V "NoComponents" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /V "NoDeletingComponents" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /V "NoEditingComponents" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /V "NoHTMLWallPaper" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "ForceActiveDesktopOn" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoActiveDesktop" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoActiveDesktopChanges" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Application Suggestions and Automatic Installation (ContentDeliveryManager)
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy" /V "Disabled" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "ContentDeliveryAllowed" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "FeatureManagementEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "OemPreInstalledAppsEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "PreInstalledAppsEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "PreInstalledAppsEverEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "ReInstalledAppsEverEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "RotatingLockScreenEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "RotatingLockScreenOverlayEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SilentInstalledAppsEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SlideShowEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SoftlandingEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-202913Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-202914Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280797Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280810Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280811Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280812Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280813Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280814Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280815Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280817Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-310091Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-310092Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-310093Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-310094Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-314558Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-314559Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-314562Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-314563Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-314566Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-314567Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338380Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338381Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338382Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338386Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338387Enabled" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338388Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338389Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338393Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-346480Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-346481Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-353694Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-353695Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-353696Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-353697Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-353698Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-353699Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000044Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000045Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000105Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000106Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000161Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000162Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000163Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000164Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000165Enabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000166Enabled" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SystemPaneSuggestionsEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\202914" /V "Availability" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\202914" /V "HasContent" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\280815" /V "Availability" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\280815" /V "HasContent" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\310091" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\310091" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\310093" /V "AllowPartialContentAvailability" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\310093" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\310093" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\314559" /V "Availability" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\314559" /V "HasContent" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\338387" /V "Availability" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\338387" /V "HasContent" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\338388" /V "Availability" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\338388" /V "HasContent" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\338389" /V "Availability" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\338389" /V "HasContent" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\353694" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\353694" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\353698" /V "Availability" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\353698" /V "HasContent" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000045" /V "Availability" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000045" /V "HasContent" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000105" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000105" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000161" /V "Availability" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000161" /V "HasContent" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000163" /V "Availability" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000163" /V "HasContent" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000165" /V "Availability" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000165" /V "HasContent" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SilentInstalledAppsEnabled" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SilentInstalledAppsEnabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /F >NUL 2>&1
:: Automatic Refresh (F5)
REG DELETE "HKEY_CLASSES_ROOT\CLSID\{BDEADE7F-C265-11D0-BCED-00A0C90AB50F}\Instance" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\WoW6432Node\CLSID\{BDEADE7F-C265-11D0-BCED-00A0C90AB50F}\Instance" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\EXPLORER.EXE" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoRemoteChangeNotIFy" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoRemoteRecursiveEvents" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop" /V "ExplorerRefreshOnRename" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Update" /V "UpdateMode" /F >NUL 2>&1
:: Automatically Hide Scroll Bars
REG DELETE "HKEY_CURRENT_USER\Control Panel\Accessibility" /V "DynamicScrollbars" /F >NUL 2>&1
:: PowerShell
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DontUsePowerShellOnWinX" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /V "EnableScripts" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Confirm DELETE Dialog Box
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "ConfirmFileDelete" /F >NUL 2>&1
:: Default Drag n Drop
:: 0 or DELETE = Default action / 1 = Always copy / 2 = Always move / 4 = Always create shortcut
::REG ADD "HKEY_CLASSES_ROOT\AllFileSystemObjects" /V "DefaultDropEffect" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Desktop Gadgets
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /V "DisableCharmsHint" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /V "DisableTLCorner" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /V "DisableCharmsHint" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /V "DisableTLCorner" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Windows\Sidebar" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Sidebar\Settings" /F >NUL 2>&1
:: Desktop Icons
:: My Computer on Desktop
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Recycled Bin on Desktop
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{645FF040-5081-101B-9F08-00AA002F954E}" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{645FF040-5081-101B-9F08-00AA002F954E}" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Network on Desktop
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{208D2C60-3AEA-1069-A2D7-08002B30309D}" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{208D2C60-3AEA-1069-A2D7-08002B30309D}" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Control Panel
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "﻿{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "﻿{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" /T REG_DWORD /D "1" /F >NUL 2>&1
:: User's Files
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{59031A47-3F72-44A7-89C5-5595FE6B30EE}" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{59031A47-3F72-44A7-89C5-5595FE6B30EE}" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Classes\CLSID\{59031A47-3F72-44A7-89C5-5595FE6B30EE}" /V "System.IsPinnedToNameSpaceTree" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{59031A47-3F72-44A7-89C5-5595FE6B30EE}" /V "System.IsPinnedToNameSpaceTree" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{59031A47-3F72-44A7-89C5-5595FE6B30EE}" /V "System.IsPinnedToNameSpaceTree" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{59031A47-3F72-44A7-89C5-5595FE6B30EE}" /F >NUL 2>&1
::REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{59031A47-3F72-44A7-89C5-5595FE6B30EE}" /F >NUL 2>&1
::REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{59031A47-3F72-44A7-89C5-5595FE6B30EE}" /F >NUL 2>&1
:: Quick Access Show Frequent Folders and Recent Files
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134EF9C-6B18-4996-AD04-ED5912E00EB5}" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3936E9E4-D92C-4EEE-A85A-BC16D5EA0819}" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134EF9C-6B18-4996-AD04-ED5912E00EB5}" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3936E9E4-D92C-4EEE-A85A-BC16D5EA0819}" /F >NUL 2>&1
:: Remove 3D Objects
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /F >NUL 2>&1
:: Remove Desktop
::REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /F >NUL 2>&1
::REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /F >NUL 2>&1
:: Remove Documents
::REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /F >NUL 2>&1
::REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{D3162B92-9365-467A-956B-92703ACA08AF}" /F >NUL 2>&1
::REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43BE-B5FD-F8091C1C60D0}" /F >NUL 2>&1
::REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{D3162B92-9365-467A-956B-92703ACA08AF}" /F >NUL 2>&1
:: Remove Downloads
::REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088E3905-0323-4B02-9826-5D99428E115F}" /F >NUL 2>&1
::REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /F >NUL 2>&1
::REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088E3905-0323-4B02-9826-5D99428E115F}" /F >NUL 2>&1
::REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /F >NUL 2>&1
:: Remove Music
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3DFDF296-DBEC-4FB4-81D1-6A3438BCF4DE}" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4EBB-811F-33C572699FDE}" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3DFDF296-DBEC-4FB4-81D1-6A3438BCF4DE}" /F >NUL 2>&1
:: Remove Pictures
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24AD3AD4-A569-4530-98E1-AB02F9417AA8}" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4CB0-BBD7-DFA0ABB5ACCA}" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24AD3AD4-A569-4530-98E1-AB02F9417AA8}" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4CB0-BBD7-DFA0ABB5ACCA}" /F >NUL 2>&1
:: Remove Videos
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43BF-BE83-3742FED03C9C}" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{F86FA3AB-70D2-4FC7-9C99-FCBF05467F3A}" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43BF-BE83-3742FED03C9C}" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{F86FA3AB-70D2-4FC7-9C99-FCBF05467F3A}" /F >NUL 2>&1
:: File Explorer Customizations
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "MapNetDrvBtn" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "ClearRecentDocsOnExit" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "DisablePersonalDirChange" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoAutoTrayNotIFy" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoChangeStartMenu" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoInstrumentation" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoStartMenuMFUprogramsList" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoRecentDocsHistory" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "PreXPSP2ShellProtocolBehavior" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "HideRecentlyADDedApps" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoNewAppAlert" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\SOFTWARE\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /V "FolderType" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "AutoCheckSelect" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DontPrettyPath" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "Filter" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "Hidden" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "HideFileExt" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "HideIcons" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "IconsOnly" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "LaunchTo" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ListviewAlphaSelect" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ListviewShadow" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "MapNetDrvBtn" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ReindexedProfile" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "SeparateProcess" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ServerAdminUI" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowCompColor" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowCortanaButton" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowInfoTip" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowStatusBar" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowSuperHidden" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowTypeOverlay" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "Start_SearchFiles" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "StoreAppsOnTaskbar" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "StorePinningExperimentResult" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarAnimations" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "WebView" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\SOFTWARE\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /V "FolderType" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "AlwaysShowMenus" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisableThumbnailCache" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisallowShaking" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "EnableBalloonTips" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "FolderContentsInfoTip" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "HideDrivesWithNoMedia" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "HideMergeConflicts" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "JointResize" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "LockTaskbar" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NavPaneExpandToCurrentFolder" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NavPaneShowAllFolders" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NoNetCrawling" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NoSharedDocuments" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NoTaskGrouping" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "PersistBrowsers" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "SharingWizardOn" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowPreviewHandlers" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowSecondsInSystemClock" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowSyncProviderNotifications" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowTaskViewButton" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "SnapAssist" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "SnapFill" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "Start_NotifyNewApps" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "Start_TrackDocs" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "Start_TrackProgs" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "SuperHidden" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarAppsVisibleInTabletMode" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarBadges" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarSizeMove" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarSmallIcons" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "UseCheckBoxes" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "WebView" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "WebViewBarricade" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisablePreviewDesktop" /F >NUL 2>&1

REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /V "FullPath" /T REG_DWORD /D "" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /V "FullPathAddress" /F >NUL 2>&1

::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /V "StartupPage" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Ribbon" /V "MinimizedStateTabletModeOff" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Ribbon" /V "MinimizedStateTabletModeOn" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "ActiveSetupDisabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "ActiveSetupTaskOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "DisableEdgeDesktopShortcutCreation" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "EnableAutoTray" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "ShowFrequent" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "ShowRecent" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "LocalKnownFoldersMigrated" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "ShowDriveLettersFirst" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "TelemetrySalt" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoSMBalloonTip" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "AllowOnlineTips" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "LinkResolveIgnoreLinkInfo" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoAutoTrayNotIFy" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoCloseDragDropBands" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoDrivesInSendToMenu" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoInternetOpenWith" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoLowDiskSpaceChecks" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoOnlinePrintsWizard" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoPublishingWizard" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoRecentDocsMenu" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoResolveSearch" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoResolveTrack" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoSimpleNetIDList" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoStrCmpLogical" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoToolbarsOnTaskbar" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoWebServices" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoNetHood" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoRecentDocsNetHood" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "PreventItemCreationInUsersFilesFolder" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "TurnOffSPIAnimations" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoPreviewPane" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoReadingPane" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoUseStoreOpenWith" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\StigRegKey\Typing\TaskbarAvoidanceEnabled" /V "TaskbarAvoidanceEnabled" /F >NUL 2>&1
:: Audit Process Creation
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit" /V "ProcessCreationIncludeCmdLine_Enabled" /F >NUL 2>&1
:: USB/external Duplicates
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /F >NUL 2>&1
:: File History
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\FileHistory" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\FileHistory" /V "Disabled" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Icon Cache
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "Max Cached Icons" /F >NUL 2>&1
:: Maintenance
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /V "MaintenanceDisabled" /F >NUL 2>&1
:: Mobility Center
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\MobilityCenter" /F >NUL 2>&1
:: MUI Cache
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\MUICache" /F >NUL 2>&1
:: Notepad
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Notepad" /V "StatusBar" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Notepad" /V "fWrapAround" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_USERS\.Default\SOFTWARE\Microsoft\Notepad" /V "StatusBar" /F >NUL 2>&1
:: People Bar
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "HidePeopleBar" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /V "PeopleBand" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_USERS\.Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /V "PeopleBand" /F >NUL 2>&1
:: Provide Locally Relevant Content
REG DELETE "HKEY_CURRENT_USER\Control Panel\International\User Profile" /V "HttpAcceptLanguageOptOut" /F >NUL 2>&1
:: Remove 'Shortcut' Text and Arrow
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "Link" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "Link" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" /F >NUL 2>&1
REG DELETE "HKEY_USERS\.Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "Link" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /V "29" /T REG_SZ /D "" /F >NUL 2>&1
:: Remove Video Preview Border on Navigation Pane
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\Image" /V "Treatment" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SystemFileAssociations\Image" /V "Treatment" /T REG_DWORD /D "2" /F >NUL 2>&1
:: Show More Details in File Transfer Dialog
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /F >NUL 2>&1
:: Speed Up
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /V "VisualFXSetting" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "ActiveWndTrackTimeout" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\Control Panel\Desktop" /V "AutoColorization" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\Control Panel\Desktop" /V "AutoEndTasks" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "DockMoving" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "DragFromMaximize" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "DragFullWindows" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "FontSmoothing" /T REG_SZ /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "ForegroundFlashCount" /T REG_DWORD /D "7" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\Control Panel\Desktop" /V "HungAppTimeout" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\Control Panel\Desktop" /V "LowLevelHooksTimeout" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "MenuShowDelay" /T REG_SZ /D "400" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "MouseWheelRouting" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "PaintDesktopVersion" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\Control Panel\Desktop" /V "SmoothScroll" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "UserPreferencesMask" /T REG_BINARY /D "9E1E078012000000" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\Control Panel\Desktop" /V "WaitToKillAppTimeout" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\Control Panel\Desktop" /V "WaitToKillServiceTimeout" /F >NUL 2>&1
REG ADD ""HKEY_USERS\.Default\Control Panel\Desktop" /V "ActiveWndTrackTimeout" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE ""HKEY_USERS\.Default\Control Panel\Desktop" /V "AutoColorization" /F >NUL 2>&1
REG DELETE ""HKEY_USERS\.Default\Control Panel\Desktop" /V "AutoEndTasks" /F >NUL 2>&1
REG ADD ""HKEY_USERS\.Default\Control Panel\Desktop" /V "DockMoving" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD ""HKEY_USERS\.Default\Control Panel\Desktop" /V "DragFromMaximize" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD ""HKEY_USERS\.Default\Control Panel\Desktop" /V "DragFullWindows" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD ""HKEY_USERS\.Default\Control Panel\Desktop" /V "FontSmoothing" /T REG_SZ /D "2" /F >NUL 2>&1
REG ADD ""HKEY_USERS\.Default\Control Panel\Desktop" /V "ForegroundFlashCount" /T REG_DWORD /D "7" /F >NUL 2>&1
REG DELETE ""HKEY_USERS\.Default\Control Panel\Desktop" /V "HungAppTimeout" /F >NUL 2>&1
REG DELETE ""HKEY_USERS\.Default\Control Panel\Desktop" /V "LowLevelHooksTimeout" /F >NUL 2>&1
REG ADD ""HKEY_USERS\.Default\Control Panel\Desktop" /V "MenuShowDelay" /T REG_SZ /D "400" /F >NUL 2>&1
REG ADD ""HKEY_USERS\.Default\Control Panel\Desktop" /V "MouseWheelRouting" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD ""HKEY_USERS\.Default\Control Panel\Desktop" /V "PaintDesktopVersion" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE ""HKEY_USERS\.Default\Control Panel\Desktop" /V "SmoothScroll" /F >NUL 2>&1
REG ADD ""HKEY_USERS\.Default\Control Panel\Desktop" /V "UserPreferencesMask" /T REG_BINARY /D "9E1E078012000000" /F >NUL 2>&1
REG DELETE ""HKEY_USERS\.Default\Control Panel\Desktop" /V "WaitToKillAppTimeout" /F >NUL 2>&1
REG DELETE ""HKEY_USERS\.Default\Control Panel\Desktop" /V "WaitToKillServiceTimeout" /F >NUL 2>&1

REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "AllowBlockingAppsAtShutdown" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /V "WaitToKillServiceTimeout" /T REG_SZ /D "5000" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control" /V "WaitToKillServiceTimeout" /T REG_SZ /D "5000" /F >NUL 2>&1
:: Keyboard Delay
REG ADD "HKEY_CURRENT_USER\Control Panel\Keyboard" /V "KeyboardDelay" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Keyboard" /V "KeyboardSpeed" /T REG_SZ /D "31" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Keyboard" /V "InitialKeyboardIndicators" /T REG_SZ /D "0" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Keyboard" /V "KeyboardDelay" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Keyboard" /V "KeyboardSpeed" /T REG_SZ /D "31" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Keyboard" /V "InitialKeyboardIndicators" /T REG_SZ /D "0" /F >NUL 2>&1
:: No Beep
REG ADD "HKEY_CURRENT_USER\Control Panel\Sound" /V "Beep" /T REG_SZ /D "Yes" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Sound" /V "ExtendedSounds" /T REG_SZ /D "Yes" /F >NUL 2>&1
:: Window Animations
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics" /V "MinAnimate" /T REG_SZ /D "0" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop\WindowMetrics" /V "MinAnimate" /T REG_SZ /D "0" /F >NUL 2>&1
:: Task Manager More Details
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\TaskManager" /F >NUL 2>&1
:: TouchScreen
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Wisp\Touch" /V "TouchGate" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Windows Error Reporting
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /V "Disabled" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /F >NUL 2>&1
:: WSH
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Script Host\Settings" /V "Enabled" /F >NUL 2>&1
:: Windows Administrative Tools
:: Device Manager
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /V "DEVMGR_SHOW_DETAILS" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /V "DEVMGR_SHOW_NONPRESENT_DeviceS" /F >NUL 2>&1
:: Event Viewer
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EventViewer" /F >NUL 2>&1
:: Virtualization App-V
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppV\Client" /F >NUL 2>&1
:: DCOM
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Ole" /V "EnableDCOM" /T REG_SZ /D "N" /F >NUL 2>&1
:: AppInit_DLLs
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /V "LoadAppInit_DLLs" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /V "RequireSignedAppInit_DLLs" /F >NUL 2>&1
 :::: Windows Explorer Right Click Menu Enhance
:: 3D Edit
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.3mf\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.3mf\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.bmp\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.bmp\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.fbx\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.fbx\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.gIF\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.gIF\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.glb\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.glb\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.jfIF\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.jfIF\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.jpeg\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.jpeg\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.jpe\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.jpe\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.jpg\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.jpg\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.obj\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.obj\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.ply\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.ply\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.png\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.png\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.stl\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.stl\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.tIFf\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.tIFf\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.tIF\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\.tIF\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.3mf\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.3mf\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.bmp\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.bmp\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.fbx\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.fbx\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.gIF\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.gIF\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.glb\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.glb\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jfIF\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jfIF\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpeg\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpeg\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpe\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpe\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpg\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpg\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.obj\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.obj\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.ply\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.ply\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.png\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.png\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.stl\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.stl\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.tIFf\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.tIFf\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.tIF\Shell\3D Edit" /VE /T REG_SZ /D "@%SystemRoot%\system32\mspaint.exe,-59500" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.tIF\Shell\3D Edit/Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\system32\mspaint.exe \"%1\" /ForceBootstrapPaint3D" /F >NUL 2>&1
:: ADD to 'New' Menu
REG DELETE "HKEY_CLASSES_ROOT\.cmd\ShellNew" /V "NullFile" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\Drive\ShellEx\-ContextMenuHandlers\{FBEB8A05-BEEE-4442-804E-409D6C4515E9}" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\batfile\ShellEx\-ContextMenuHandlers\Compatibility" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\cmdfile\ShellEx\-ContextMenuHandlers\Compatibility" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\exefile\ShellEx\-ContextMenuHandlers\Compatibility" /F >NUL 2>&1
:: Allow Mapped Drives in Command Prompt
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableLinkedConnections" /F >NUL 2>&1
:: Cast to Device
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /F >NUL 2>&1
:: CD Burning
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoCDBurning" /F >NUL 2>&1
:: Command Prompt (Administrator)
REG DELETE "HKEY_CLASSES_ROOT\Directory\Shell\RunAs" /F >NUL 2>&1
reg DELETE "HKEY_CLASSES_ROOT\Directory\Background\Shell\RunAs" /F >NUL 2>&1
reg DELETE "HKEY_CLASSES_ROOT\Drive\Shell\RunAs" /F >NUL 2>&1
:: Copy as path
REG DELETE "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /F >NUL 2>&1
:: Copy To / Move To
REG DELETE "HKEY_CLASSES_ROOT\AllFileSystemObjects\ShellEx\ContextMenuHandlers\Copy To" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\AllFileSystemObjects\ShellEx\ContextMenuHandlers\Move To" /F >NUL 2>&1
:: Extract All Context Menu for ZIP Files
REG ADD "HKEY_CLASSES_ROOT\CompressedFolder\ShellEx\ContextMenuHandlers\{B8CDCB65-B1BF-4B42-9428-1DFDB7EE92AF}" /F >NUL 2>&1
:: Give Access To
::REG DELETE "HKEY_CLASSES_ROOT\*\ShellEx\ContextMenuHandlers\Sharing" /F >NUL 2>&1
::REG DELETE "HKEY_CLASSES_ROOT\Directory\Background\ShellEx\ContextMenuHandlers\Sharing" /F >NUL 2>&1
::REG DELETE "HKEY_CLASSES_ROOT\Directory\ShellEx\ContextMenuHandlers\Sharing" /F >NUL 2>&1
::REG DELETE "HKEY_CLASSES_ROOT\Drive\ShellEx\ContextMenuHandlers\Sharing" /F >NUL 2>&1
::REG DELETE "HKEY_CLASSES_ROOT\LibraryFolder\background\ShellEx\ContextMenuHandlers\Sharing" /F >NUL 2>&1
::REG DELETE "HKEY_CLASSES_ROOT\UserLibraryFolder\ShellEx\ContextMenuHandlers\Sharing" /F >NUL 2>&1
:: Include in Libraries
REG ADD "HKEY_CLASSES_ROOT\Folder\ShellEx\ContextMenuHandlers\Library Location" /VE /T REG_SZ /D "{3dad6c5d-2167-4cae-9914-f99e41c12cfa}" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\ShellEx\ContextMenuHandlers\Library Location" /VE /T REG_SZ /D "{3dad6c5d-2167-4cae-9914-f99e41c12cfa}" /F >NUL 2>&1
:: ISO Burn
REG ADD "HKEY_CLASSES_ROOT\Windows.IsoFile\Shell\Burn" /V "MUIVerb" /T REG_EXPAND_SZ /D "@%SystemRoot%\System32\isoburn.exe,-351" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\Windows.IsoFile\Shell\Burn\Command" /VE /T REG_EXPAND_SZ /D "%SystemRoot%\System32\isoburn.exe \"%1\"" /F >NUL 2>&1
:: Login Without Password in "control userpasswords2" or netplwiz
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device" /V "DevicePasswordLessBuildVersion" /T REG_DWORD /D "2" /F >NUL 2>&1
:: Meet Now
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "HideSCAMeetNow" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "HideSCAMeetNow" /F >NUL 2>&1
:: Msi Extract
REG DELETE "HKEY_CLASSES_ROOT\Msi.Package\Shell\Extract" /F >NUL 2>&1
:: 'New' Menu
REG ADD "HKEY_CLASSES_ROOT\.contact\ShellNew" /V "Command" /T REG_EXPAND_SZ /D "\"%programFiles%\Windows Mail\Wab.exe\" /CreateContact \"%1\"" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\.contact\ShellNew\iconpath" /T REG_EXPAND_SZ /D "%ProgramFiles%\Windows Mail\wab.exe,1" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\.contact\ShellNew\MenuText" /T REG_EXPAND_SZ /D "@%CommonProgramFiles%\system\wab32res.dll,-10203" /F >NUL 2>&1

REG DELETE "HKEY_CLASSES_ROOT\.library-ms\ShellNew" /F >NUL 2>&1

REG ADD "HKEY_CLASSES_ROOT\.library-ms" /VE /T REG_SZ /D "LibraryFolder" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\.library-ms" /V "Content Type" /T REG_SZ /D "{c7ca6167-2f46-4c4c-98b2-c92591368971}" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\.library-ms\ShellNew" /V "Handler" /T REG_SZ /D "LibraryFolder" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\.library-ms\ShellNew" /V "IconPath" /T REG_EXPAND_SZ /D "%SystemRoot%\System32\imageres.dll,-1001" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\.library-ms\ShellNew" /V "NullFile" /T REG_SZ /D "" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\.library-ms\ShellNew\Config" /V "IsFolder" /T REG_SZ /D "" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\.library-ms\ShellNew\Config" /V "IsOptIn" /T REG_SZ /D "" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\.library-ms\ShellNew\Config" /V "NoEmptyFile" /T REG_SZ /D "" /F >NUL 2>&1
:: Number of Selections on Explorer
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "MultipleInvokePromptMinimum" /F >NUL 2>&1
:: Pin to Quick Access
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\Shell\PinToHome" /V "AppliesTo" /T REG_SZ /D "System.ParsingName:<>"::{679f85cb-0220-4080-b29b-5540cc05aab6}" AND System.ParsingName:<>"::{645FF040-5081-101B-9F08-00AA002F954E}" AND System.IsFolder:=System.StructuredQueryType.Boolean#True" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\Shell\PinToHome" /V "MUIVerb" /T REG_SZ /D "@shell32.dll,-51377" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\Shell\PinToHome\Command" /V "DelegateExecute" /T REG_SZ /D "{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}" /F >NUL 2>&1
:: Previous Versions (File History Properties Tab)
REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\ShellEx\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\ShellEx\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\Directory\ShellEx\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\Drive\ShellEx\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
:: Previous Versions (File History Context Menu)
REG ADD "HKEY_CLASSES_ROOT\AllFilesystemObjects\ShellEx\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\ShellEx\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\Directory\ShellEx\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\Drive\ShellEx\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /V "NoPreviousVersionsPage" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "NoPreviousVersionsPage" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PreviousVersions" /V "DisableLocalPage" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer" /V "NoPreviousVersionsPage" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\Software\Policies\Microsoft\PreviousVersions" /V "DisableLocalPage" /F >NUL 2>&1
:: 'Share'
::REG DELETE "HKEY_CLASSES_ROOT\*\ShellEx\ContextMenuHandlers\ModernSharing" /F >NUL 2>&1
:: Windows Picture and Fax Viewer
REG DELETE "HKEY_CLASSES_ROOT\SystemFileAssociations\Image\ShellEx\ContextMenuHandlers\ShellImagePreview" /F >NUL 2>&1
:: Win-X Menu Shortcuts
::IF NOT exist "%LOCALAPPDATA%\Microsoft\Windows\WinX\Group2\Registry Editor" (mklink /h "%LOCALAPPDATA%\Microsoft\Windows\WinX\Group2\Registry Editor" %SYSTEMROOT%\regedit.exe) >NUL 2>&1
::IF NOT exist "%LOCALAPPDATA%\Microsoft\Windows\WinX\Group3\Services" (mklink "%LOCALAPPDATA%\Microsoft\Windows\WinX\Group3\Services" %SYSTEMROOT%\System32\services.msc) >NUL 2>&1
:: RunAsUser
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoStartBanner" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\batfile\shell\runasuser" /V "SuppressionPolicy" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\cmdfile\shell\runasuser" /V "SuppressionPolicy" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\exefile\shell\runasuser" /V "SuppressionPolicy" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\mscfile\shell\runasuser" /V "SuppressionPolicy" /F >NUL 2>&1


ECHO :::::::: Time ^& Language
:: Date ^& time
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\tzautoupdate" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" /V "DynamicDaylightTimeDisabled" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" /V "TimeZoneKeyName" /T REG_SZ /D "Eastern Standard Time" /F >NUL 2>&1


ECHO :::::::: Update ^& Security
:::: Windows Update
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /V "DisableWindowsUpdateAccess" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services" WaaSMedicSvc /V Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsoSvc" /V "DelayedAutoStart" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /F >NUL 2>&1
:: Windows Store Automatic Updates
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /F >NUL 2>&1
:: Drivers Update
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /V "PreventDeviceMetadataFromNetwork" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Default\Update\ExcludeWUDriversInQualityUpdate" /V "Value" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /V "ExcludeWUDriversInQualityUpdate" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Other MS Products Update
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Services\7971F918-A847-4430-9279-4A52D1EFE18D" /V "RegisteredWithAU" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Maps updates
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\Maps" /V "AutoUpdateEnabled" /F >NUL 2>&1
:: Delivery Optimization
REG DELETE "HKEY_USERS\S-1-5-20\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /V "DownloadMode" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /F >NUL 2>&1
:::::::: Windows Security
:: Windows Defender
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender" /V "DisableAntiVirus" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features" /V "TamperProtection" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" /V "SubmitSamplesConsent" /T REG_DWORD /D "2" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows Security Health\State" /V "AccountProtection_MicrosoftAccount_Disconnected" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows Security Health\State" /V "AppAndBrowser_StoreAppsSmartScreenOff" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" /V "DisableEnhancedNotifications" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications" /V "DisableNotifications" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender Security Center\Virus and Threat Protection" /V "SummaryNotificationDisabled" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /F >NUL 2>&1
:: Core Isolation / Device Guard
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /V "EnableVirtualizationBasedSecurity" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /V "HypervisorEnforcedCodeIntegrity" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /V "RequirePlatformSecurityFeatures" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /V "Locked" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "LsaCfgFlags" /F >NUL 2>&1
:: Network Protection
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Windows Defender Exploit Guard\Network Protection" /V "EnableNetworkProtection" /F >NUL 2>&1
:: Application Guard
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppHVSI" /F >NUL 2>&1
:: SmartScreen
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "EnableSmartScreen" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /V "ContentEvaluation" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /V "EnableWebContentEvaluation" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "SmartScreenEnabled" /F >NUL 2>&1
:: Boot-Start Driver Initialization Policy
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\EarlyLaunch" /F >NUL 2>&1
:: Windows Insider Program
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Current\Device\System" /V "AllowExperimentation" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Default\System\AllowExperimentation" /V "Value" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /V "HideInsiderPage" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /F >NUL 2>&1
:: License Telemetry
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" /V "NoGenTicket" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /V "AllowWindowsEntitlementReactivation" /F >NUL 2>&1


ECHO :::::::: Windows Search, Cortana, Indexing/Prefetch
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Cortana.exe" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Search\Gather\Windows\SystemIndex" /V "EnableFindMyFiles" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowCortanaButton" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "AllowSearchToUseLocation" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "BingSearchEnabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "CanCortanaBeEnabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "CortanaConsent" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "CortanaEnabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "CortanaInAmbientMode" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "CortanaSpeechAllowedOverLockScreen" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "DeviceHistoryEnabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "HasCortanaBeenEnabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "HistoryViewEnabled" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "SearchboxTaskbarMode" /T REG_DWORD /D "2" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "VoiceShortcut" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Windows Search" /V "CortanaConsent" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "AllowCloudSearch" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /V "IsAADCloudSearchEnabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /V "IsDeviceSearchHistoryEnabled" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /V "IsMSACloudSearchEnabled" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /V "SafeSearchMode" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Search Companion
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SearchCompanion" /F >NUL 2>&1
:: Prefetch
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /V "EnableBootTrace" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /V "EnablePrefetcher" /T REG_DWORD /D "3" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /V "EnableSuperfetch" /F >NUL 2>&1


ECHO :::::::: Scheduled Tasks
SCHTASKS /CHANGE /ENABLE /TN "MicrosoftEdgeUpdateTaskMachineCore" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "MicrosoftEdgeUpdateTaskMachineUA" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Active Directory Rights Management Services Client\AD RMS Rights Policy Template Management (Automated)" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Active Directory Rights Management Services Client\AD RMS Rights Policy Template Management (Manual)" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\AppID\EDP Policy Manager" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\AppID\SmartScreenSpecIFic" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Application Experience\AITAgent" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Application Experience\Consolidator" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Application Experience\KernelCeipTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Application Experience\StartupAppTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Application Experience\UsbCeip" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\ApplicationData\CleanupTemporaryState" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\ApplicationData\DsSvcCleanup" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\ApplicationData\DsSvcCleanup" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\ApplicationData\appuriverIFierdaily" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\ApplicationData\appuriverIFierinstall" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\AppxDeploymentClient\Pre-staged app cleanup" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Autochk\Proxy" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\BrokerInfrastructure\BgTaskRegistrationMaintenanceTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Chkdsk\ProactiveScan" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Clip\License Validation" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\TelTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\DUSM\dusmtask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Defrag\ScheduledDefrag" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Device" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Device User" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Diagnosis\Scheduled" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\DirectX\DXGIAdapterCache" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\DirectX\DirectXDatabaseUpdater" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\DiskCleanup\SilentCleanup" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\DiskFootprint\Diagnostics" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\DiskFootprint\StorageSense" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\ErrorDetails\EnableErrorDetailsUpdate" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\ErrorDetails\ErrorDetailsUpdate" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Flighting\FeatureConfig\ReconcileFeatures" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Flighting\FeatureConfig\UsageDataFlushing" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Flighting\OneSettings\RefreshCache " /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\HelloFace\FODCleanupTask " /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Input\LocalUserSyncDataAvailable" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Input\MouseSyncDataAvailable" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Input\PenSyncDataAvailable" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Input\TouchpadSyncDataAvailable" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\International\Synchronize Language Settings" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\LanguageComponentsInstaller\Installation" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\LanguageComponentsInstaller\Uninstallation" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\License Manager\TempSignedLicenseExchange" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Location\Notifications" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Location\WindowsActionDialog" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\MUI\LPRemove" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Maintenance\WinSAT" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Management\Provisioning\Cellular" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Management\Provisioning\Logon" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Maps\MapsToastTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Maps\MapsUpdateTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Mobile Broadband Accounts\MNO Metadata Parser" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\NlaSvc\WiFiTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Offline Files\Synchronization" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\PI\Secure-Boot-Update" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\PI\Sqm-Tasks" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\PerfTrack\BackgroundConfigSurveyor" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\PushToInstall\LoginCheck" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\PushToInstall\Registration" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Ras\MobilityManager" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\RecoveryEnvironment\VerIFyWinRE" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\RetailDemo\CleanupOfflineContent" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\SettingSync\BackgroundUploadTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\SettingSync\BackgroundUploadTaskDisabled" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\SettingSync\BackupTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\SettingSync\NetworkStateChangeTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\SetupSQMTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Setup\SetupCleanupTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Shell\FamilySafetyMonitorToastTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Shell\FamilySafetyRefreshTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Shell\FamilySafetyUpload" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Shell\IndexerAutomaticMaintenance" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\SpacePort\SpaceAgentTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\SpacePort\SpaceManagerTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Speech\SpeechModelDownloadTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Storage Tiers Management\Storage Tiers Management Initialization" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Storage Tiers Management\Storage Tiers Optimization" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Subscription\EnableLicenseAcquisition" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Subscription\LicenseAcquisition" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Sysmain\ResPriStaticDbSync" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Sysmain\WsSwapAssessmentTask" /F >NUL 2>&1
::SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\TPM\Tpm-HASCertRetr" /F >NUL 2>&1
::SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\TPM\Tpm-Maintenance" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Task Manager\Interactive" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\UpdateOrchestrator\Battery Saver Deferred Install" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\UpdateOrchestrator\Maintenance Install" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\UpdateOrchestrator\Policy Install" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\UpdateOrchestrator\Reboot" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\UpdateOrchestrator\Reboot_AC" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\UpdateOrchestrator\Reboot_Battery" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\UpdateOrchestrator\Refresh Settings" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\UpdateOrchestrator\Report policies" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\UpdateOrchestrator\Resume On Boot" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Maintenance Work" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Wake To Work" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Work" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\UpdateOrchestrator\USO_UxBroker_Display" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\UpdateOrchestrator\USO_UxBroker_ReadyToReboot" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\UpdateOrchestrator\UpdateModelTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\WCM\WiFiTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\WDI\ResolutionHost" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\WOF\WIM-Hash-Management" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\WOF\WIM-Hash-Validation" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\WS\WSTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Windows Error Reporting\QueueReportingDisabled" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Windows Media Sharing\UpdateLibrary" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\WindowsUpdate\Scheduled Start" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\WindowsUpdate\sih" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\WindowsUpdate\sihboot" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Wininet\CacheTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\WlanSvc\CDSSync" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Work Folders\Work Folders Logon Synchronization" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Work Folders\Work Folders Maintenance Work" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Workplace Join\Automatic-Device-Join" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Workplace Join\Device-Sync" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\Workplace Join\Device-Sync" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\WwanSvc\NotificationTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\Windows\WwanSvc\OobeDiscovery" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\XblGameSave\Xbgm" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\XblGameSave\XblGameSaveTask" /F >NUL 2>&1
SCHTASKS /CHANGE /ENABLE /TN "Microsoft\XblGameSave\XblGameSaveTaskLogon" /F >NUL 2>&1

NETSH AdvFirewall Reset

ECHO :::::::: Services
::for /D%%G in (CertPropSvc,CDPSvc,CDPUserSvc,CscService,DiagTrack,DoSvc,DevicesFlow,DevicesFlowUserSvc,DevQueryBroker,DsmSvc,DusmSvc,DPS,diagnosticshub.standardcollector.service,dmwappushservice,MapsBroker,MessagingService,OneSyncSvc,PimIndexMaintenanceSvc,PrintWorkflowUserSvc,PcaSvc,RemoteRegistry,SmsRouter,Spooler,TrkWks,StiSvc,SecurityHealthService,Sense,UnistoreSvc,UserDataSvc,WpnUserService,WerSvc,WMPNetworkSvc,WSearch,WdNisDrv,WdNisSvc,WinDefend) do (
::sc Config %%G start= disabled )
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DeviceAssociationBrokerSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iphlpsvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sense" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SensorDataService" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wlidsvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AJRouter" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ALG" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Application Experience\Microsoft Compatibility Appraiser" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Application Experience\ProgramDataUpdater" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Application Experience\StartupAppTask" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CertPropSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Clip\License Validation" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CredentialEnrollmentManagerUserSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Customer Experience Improvement Program\Consolidator" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Customer Experience Improvement Program\KernelCeipTask" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Customer Experience Improvement Program\UsbCeip" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DiagSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DiagTrack" /V "Start" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DmWapPushService" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DoSvc" /V "Start" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DuSmSvc" /V "Start" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EdgeUpdate" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EdgeUpdateM" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EntAppSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FDResPub" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HelloFace\FODCleanupTask" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\icssvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\idsvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer" /V "Start" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManworkstation" /V "Start" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lfsvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MapsBroker" /V "Start" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Maps\MapsToastTask" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Maps\MapsUpdateTask" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MessagingService" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MixedRealityOpenXRSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mrxsmb10" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mrxsmb" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mrxsmb\Parameters" /V "RefuseReset" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MSiSCSI" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MsLldp" /V "Start" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ms_lltdio" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ms_msclient" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ms_pacer" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ms_rspndr" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NaturalAuthentication" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Ndu" /V "Start" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBIOS" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetTCPPortSharing" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PcaSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\perceptionsimulation" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PhoneSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PrintWorkflowUserSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RemoteAccess" /V "Start" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RemoteRegistry" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RetailDemo" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecLogon" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SEMgrSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SessionEnv" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SgrmBroker" /V "Start" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedRealitySvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SHPamSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SNMPTRAP" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Spectrum" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SysMain" /V "Start" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TabletInputService" /V "Start" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TermService" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UmRdpService" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UnistoreSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UserDataSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicguestinterface" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicheartbeat" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmickvpexchange" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicrdv" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicshutdown" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmictimesync" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicvmsession" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicvss" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WbioSrvc" /V "Start" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wcncsvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wercplsupport" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WerSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinRM" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wisvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WMPNetworkSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WpcMonSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WSearch" /V "Start" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\xbgm" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XblAuthManager" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XblGameSave" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XboxGipSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1

:::::::: Settings Control Panel Clean-Up
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "SettingsPageVisibility" /F >NUL 2>&1
