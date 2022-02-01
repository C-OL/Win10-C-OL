::
:: Windows C-OL - Custom Tweaks Collection Script
::
:: This is a collection of tweaks that aim to fine tune a fresh install of Windows 10(+)
:: keeping the default behavior of visual inputs providing a drastically overall performance
:: boost and enhanced security.
::
:: Most of tweaks are meant for the CURRENT_USER instead of Group Policies to avoid similar
:: annoying messages, such as: "Some settings are managed by your organization".
::
:: It requires to 'Run as Administrator' to work properly.
::

@ECHO OFF & COLOR 30
SETLOCAL EnableDelayedExpansion
PUSHD "%~dp0"
CLS & openfiles >NUL 2>&1
IF %ERRORLEVEL%==1 (ECHO. & ECHO :::::::: You are NOT running as Administrator :::::::: & ECHO Right-click and select ^'Run as Administrator^' and try again.
ECHO. & ECHO Press any key to exit & PAUSE > NUL & EXIT)
ECHO. & ECHO :::::::: Windows C-OL - Custom Tweak Collection Script :::::::: & ECHO.
TASKKILL /F /IM EXPLORER.EXE >NUL 2>&1


ECHO :::::::: * UAC Level *
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ConsentPromptBehaviorAdmin" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ConsentPromptBehaviorUser" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableInstallerDetection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableSecureUIAPaths" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableLUA" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableVirtualization" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "FilterAdministratorToken" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "PromptOnSecureDesktop" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ValidateAdminCodeSignatures" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "LocalAccountTokenFilterPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1


ECHO :::::::: Accounts
:: Remove DefaultUser0 Account
NET USER DefaultUser0 /DELETE >NUL 2>&1
:: Password Expiration
NET ACCOUNTS /MaxPwAge:Unlimited >NUL 2>&1
:: Set User TEMP to Windows TEMP
IF EXIST "%LOCALAPPDATA%\TEMP" RD /S /Q "%LOCALAPPDATA%\TEMP" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Environment" /V "TEMP" /T REG_SZ /D "%SYSTEMROOT%\TEMP" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Environment" /V "TMP" /T REG_SZ /D "%SYSTEMROOT%\TEMP" /F >NUL 2>&1
:: Microsoft.com accounts (Block Sign-in Microsoft account)
:: 0 = Allow / 1 = can't ADD / 3 = can't ADD or login
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "MSAOptional" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "NoConnectedUser" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Security Questions for Local Accounts
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "NoLocalPasswordResetQuestions" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Sync Your Settings
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableSettingSyncUserOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /V "SyncPolicy" /T REG_DWORD /D "5" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableAppSyncSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableAppSyncSettingSyncUserOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableApplicationSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableApplicationSettingSyncUserOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableCredentialsSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableCredentialsSettingSyncUserOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableDesktopThemeSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableDesktopThemeSettingSyncUserOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisablePersonalizationSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisablePersonalizationSettingSyncUserOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableStartLayoutSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableStartLayoutSettingSyncUserOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableSyncOnPaidNetwork" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableWebBrowserSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableWebBrowserSettingSyncUserOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableWindowsSettingSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "DisableWindowsSettingSyncUserOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /V "EnableBackupForWin8Apps" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Messaging" /V "AllowMessageSync" /T REG_DWORD /D "0" /F >NUL 2>&1


ECHO :::::::: Apps ^& Features
:::: Application Compatibility
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\AIT" /V "AITEnable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Appraiser" /V "HaveUploadedForTarget" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /V "DontRetryOnError" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /V "IsCensusDisabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /V "TaskEnableRun" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CompatTelRunner.exe" /V "Debugger" /T REG_SZ /D "%SYSTEMROOT%\System32\taskkill.exe" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DeviceCensus.exe" /V "Debugger" /T REG_SZ /D "%SYSTEMROOT%\System32\taskkill.exe" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PushToInstall" /V "DisablePushToInstall" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "AITEnable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "AllowTelemetry" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "DisableInventory" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "DisableEngine" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "DisablePCA" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "DisablePropPage" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "DisableUAR" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "Prevent16BitMach" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "RemoveProgramCompatPropPage" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "SbEnable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /V "VDMDisallowed" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Tracing" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\TelemetryController" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\NoExecuteState" /V "LastNoExecuteRadioButtonState" /T REG_DWORD /D "14013" /F >NUL 2>&1
:: Compatibility Troubleshoot
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /V "{1d27f844-3a1f-4410-85ac-14651078412d}" /T REG_SZ /D "" /F >NUL 2>&1
:: Classic Paint
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Paint\Settings" /V "DisableModernPaintBootstrap" /T REG_DWORD /D "1" /F >NUL 2>&1
:: IE Harden
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "DisableEdgeDesktopShortcutCreation" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Internet Explorer\SQM" /V "DisableCustomerImprovementProgram" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main" /V "Default_Page_URL" /T REG_SZ /D "about:blank" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main" /V "NoProtectedModeBanner" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main" /V "Start Page" /T REG_SZ /D "about:blank" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\PhishingFilter" /V "EnabledV9" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" /V "WpadOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "AutoDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "IEHarden" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "IntranetName" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "ProxyBypass" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "UNCAsIntranet" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "AddressBarMicrosoftSearchInBingProviderEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "AlternateErrorPagesEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "AutofillAddressEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "AutofillCreditCardEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "ConfigureDoNotTrack" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "ConfigureDoNotTrack" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "EdgeShoppingAssistantEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "LocalProvidersEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "LocalProvidersEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "MetricsReportingEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "NetworkPredictionOptions" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "PaymentMethodQueryEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "PersonalizationReportingEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "PreventSmartScreenPromptOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "PreventSmartScreenPromptOverrideForFiles" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "PromotionalTabsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "ResolveNavigationErrorsUseWebService" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "SearchSuggestEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "SendSiteInfoToImproveServices" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "SpotlightExperiencesAndRecommendationsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "StartupBoostEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge" /V "UserFeedbackAllowed" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge\Recommended" /V "AlternateErrorPagesEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge\Recommended" /V "EdgeShoppingAssistantEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge\Recommended" /V "SearchSuggestEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Edge\Recommended" /V "SyncDisabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds" /V "AllowBasicAuthInClear" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds" /V "DisableEnclosureDownload" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Internet Settings" /V "PreventCertErrorOverrides" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /V "AllowPrelaunch" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /V "FormSuggest Passwords" /T REG_SZ /D "No" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /V "EnabledV9" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /V "PreventOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /V "PreventOverrideAppRepUnknown" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\MicrosoftEdge\TabPreloader" /V "AllowTabPreloading" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\WoW6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "IEHarden" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4B3F-8CFC-4F3A74704073}" /V "IsInstalled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4B3F-8CFC-4F3A74704073}" /V "IsInstalled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer" /V "IntegratedBrowser" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /V "MaxConnectionsPer1_0Server" /T REG_DWORD /D "32" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /V "MaxConnectionsPerServer" /T REG_DWORD /D "32" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" /V "WpadOverride" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "AutoDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "IEHarden" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "IntranetName" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "ProxyBypass" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "UNCAsIntranet" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /V "CallLegacyWCMPolicies" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /V "EnableHTTP2" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /V "EnableSSL3Fallback" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /V "PreventIgnoreCertErrors" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4B3F-8CFC-4F3A74704073}" /V "IsInstalled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap" /V "IEHarden" /T REG_DWORD /D "1" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main" /V "First Home Page" /F >NUL 2>&1
:: CheckExeSignatures
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Download" /V "CheckExeSignatures" /T REG_SZ /D "No" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Download" /V "RunInvalidSignatures" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Microsoft OneDrive
TASKLIST | FIND /I "OneDrive.exe" /F >NUL 2>&1 && TASKKILL /F /IM OneDrive.exe >NUL 2>&1
if %PROCESSOR_ARCHITECTURE%==AMD64 (set OD=%SYSTEMROOT%\SYSTEM32) else (set OD=%SYSTEMROOT%\SysWOW64)
IF EXIST %OD%\OneDriveSetup.exe (TAKEOWN /F %OD%\OneDrive* && ICACLS %OD%\OneDrive* /GRANT Administrators:F /T /Q && %OD%\OneDriveSetup.exe /uninstall) >NUL 2>&1
TIMEOUT /T 2 >NUL 2>&1
DEL /F /S /Q %OD%\OneDrive* >NUL 2>&1
IF EXIST "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Microsoft OneDrive.lnk" DEL /F /S /Q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Microsoft OneDrive.lnk" /F >NUL 2>&1
IF EXIST "%APPDATA%\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" DEL /F /S /Q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" /F >NUL 2>&1
IF EXIST "%LOCALAPPDATA%\Microsoft\OneDrive" RD /S /Q "%LOCALAPPDATA%\Microsoft\OneDrive" /F >NUL 2>&1
IF EXIST "%PROGRAMDATA%\Microsoft OneDrive" RD /S /Q "%PROGRAMDATA%\Microsoft OneDrive" /F >NUL 2>&1
IF EXIST "%SYSTEMDRIVE%\OneDriveTemp" RD /S /Q "%SYSTEMDRIVE%\OneDriveTemp" /F >NUL 2>&1
IF EXIST "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" DEL /F /S /Q "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" /F >NUL 2>&1
IF EXIST "%USERPROFILE%\Links\OneDrive.lnk" DEL /F /S /Q "%USERPROFILE%\Links\OneDrive.lnk" /F >NUL 2>&1
IF EXIST "%USERPROFILE%\OneDrive" RD /S /Q "%USERPROFILE%\OneDrive" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\WoW6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\Environment" /V "OneDrive" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Classes\WoW6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\OneDrive" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "OneDriveSetup" /F >NUL 2>&1
REG DELETE "HKEY_USERS\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /V "OneDriveSetup" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\OneDrive" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SkyDrive" /F >NUL 2>&1
::REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{A52BBA46-E9E1-435f-B3D9-28DAA648C0F6}" /F >NUL 2>&1
::REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{A52BBA46-E9E1-435f-B3D9-28DAA648C0F6}" /F >NUL 2>&1
REG DELETE "HKEY_USERS\S-1-5-21-2840528155-2331882053-1912885801-1000\SOFTWARE\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG DELETE "HKEY_USERS\S-1-5-21-2840528155-2331882053-1912885801-1000\SOFTWARE\Classes\WoW6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG DELETE "HKEY_USERS\S-1-5-21-2840528155-2331882053-1912885801-1000_Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG DELETE "HKEY_USERS\S-1-5-21-2840528155-2331882053-1912885801-1000_Classes\WoW6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /V "DisableFileSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /V "DisableFileSyncNGSC" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /V "DisableMeteredNetworkFileSync" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /V "DisableLibrariesDefaultSaveToOneDrive" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Storage\EnabledDenyGP" /V "DenyAllGPState" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\OneDrive" /V "PreventNetworkTrafficPreUserSignIn" /T REG_DWORD /D "1" /F >NUL 2>&1
:::::::: .NET Framework
:: Strong Cryptography
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /V "SchUseStrongCrypto" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" /V "SystemDefaultTLSVersions" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v3.0" /V "SchUseStrongCrypto" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v3.0" /V "SystemDefaultTLSVersions" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" /V "SchUseStrongCrypto" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" /V "SystemDefaultTLSVersions" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework\v2.0.50727" /V "SchUseStrongCrypto" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework\v2.0.50727" /V "SystemDefaultTLSVersions" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework\v3.0" /V "SchUseStrongCrypto" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework\v3.0" /V "SystemDefaultTLSVersions" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework\v4.0.30319" /V "SchUseStrongCrypto" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework\v4.0.30319" /V "SystemDefaultTLSVersions" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Use Latest CLR
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework" /V "OnlyUseLatestCLR" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\.NETFramework" /V "OnlyUseLatestCLR" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Windows Installer in Safe Mode
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\MSIServer" /VE /T REG_SZ /D "Service" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\MSIServer" /VE /T REG_SZ /D "Service" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Installer" /V "AlwaysInstallElevated" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Installer" /V "DisableBrowse" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Installer" /V "EnableUserControl" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Installer" /V "SafeForScripting" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Windows Media Player
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MediaPlayer\Setup\UserOptions" /V "DesktopShortcut" /T REG_SZ /D "No" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MediaPlayer\Preferences" /V "AcceptedPrivacyStatement" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MediaPlayer\Preferences" /V "AutoCopyCD" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MediaPlayer\Preferences" /V "DisableMRU" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MediaPlayer\Preferences" /V "FirstRun" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MediaPlayer\Preferences" /V "SendUserGUID" /T REG_BINARY /D "00" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MediaPlayer\Preferences" /V "UsageTracking" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /V "GroupPrivacyAcceptance" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /V "PreventCDDVDMetadataRetrieval" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /V "PreventMusicFileMetadataRetrieval" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /V "PreventRadioPresetsRetrieval" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Prevent Windows Media Digital Rights Management (DRM)
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WMDRM" /V "DisableOnline" /T REG_DWORD /D "1" /F >NUL 2>&1
:: AppX
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Appx" /V "AllowDevelopmentWithoutDevLicense" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "AicEnabled" /T REG_SZ /D "PreferStore" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FVE" /V "UseAdvancedStartup" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FVE" /V "UseTPMKeyPIN" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FVE" /V "UseTPMPIN" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Appx" /V "AllowAllTrustedApps" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Appx" /V "AllowDeploymentInSpecialProfiles" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Appx" /V "BlockNonAdminUserInstall" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Appx" /V "RestrictAppDataToSystemVolume" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Appx" /V "RestrictAppToSystemVolume" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\AppModel\StateManager" /V "AllowSharedLocalAppData" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\AppModel\StateManager" /V "AllowSharedUserAppData" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /V "AllowAllTrustedApps" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /V "AllowDevelopmentWithoutDevLicense" /T REG_DWORD /D "1" /F >NUL 2>&1


ECHO :::::::: Devices
:::: Mouse
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "ActiveWindowTracking" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "Beep" /T REG_SZ /D "No" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "ExtendedSounds" /T REG_SZ /D "No" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "MouseHoverTime" /T REG_SZ /D "100" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "MouseSensitivity" /T REG_SZ /D "20" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "MouseSpeed" /T REG_SZ /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "MouseTrails" /T REG_SZ /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "MouseThreshold1" /T REG_SZ /D "4" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "MouseThreshold2" /T REG_SZ /D "6" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "SnapToDefaultButton" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Mouse" /V "SwapMouseButtons" /T REG_SZ /D "0" /F >NUL 2>&1
:::: Typing
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\CTF\LangBar" /V "ShowStatus" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\Settings" /V "EnableHwkbAutocorrection2" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\Settings" /V "EnableHwkbTextPrediction" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\Settings" /V "InsightsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\Settings" /V "VoiceTypingEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\Settings" /V "MultilingualEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" /V "AllowLanguageFeaturesUninstall" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" /V "AllowLinguisticDataCollection" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Inking ^& Typing Personalization
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" /V "AllowLinguisticDataCollection" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\InputPersonalization" /V "AllowInputPersonalization" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputPersonalization" /V "RestrictImplicitInkCollection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputPersonalization" /V "RestrictImplicitTextCollection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /V "HarvestContacts" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Input\TIPC" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Personalization\Settings" /V "AcceptedPrivacyPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Personalization\Settings" /V "RestrictImplicitInkCollection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Personalization\Settings" /V "RestrictImplicitTextCollection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /V "PreventHandwritingErrorReports" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /V "PreventHandwritingDataSharing" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Keyboard On Screen
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Osk" /V "BounceTime" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Osk" /V "FirstRepeatDelay" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Osk" /V "KeystrokeDelay" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Osk" /V "NextRepeatDelay" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Osk" /V "RunningState" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\TabletTip\1.7" /V "EnableKeyAudioFeedback" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\TabletTip\1.7" /V "EnableTextPrediction" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\TabletTip\1.7" /V "EdgeTargetDockedState" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\TabletTip\1.7" /V "TipbandDesiredVisibility" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Pen ^& Windows Ink
:: PenWorkspace
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace" /V "PenWorkspaceAppSuggestionsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PenWorkspace" /V "PenWorkspaceButtonDesiredVisibility" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" /V "AllowWindowsInkWorkspace" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: AutoPlay
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main" /V "Autorun" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers" /V "DisableAutoplay" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoAutorun" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoAutoplayfornonVolume" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoDriveTypeAutoRun" /T REG_DWORD /D "255" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "DontSetAutoplayCheckbox" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CDROM" /V "Autorun" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\IniFileMapping\Autorun.inf" /VE  /T REG_SZ /D "@SYS:DoesNotExist" /F >NUL 2>&1
:::::::: Hardware Related Tweaks
:: Block Legacy File System Filter Drivers
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /V "IoBlockLegacyFsFilters" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Camera Fix?
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Media Foundation\Platform" /V "EnableFrameServerMode" /T REG_SZ /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows Media Foundation\Platform" /V "EnableFrameServerMode" /T REG_SZ /D "0" /F >NUL 2>&1
:: Camera On/Off OSD Notifications
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\OEM\Device\Capture" /V "NoPhysicalCameraLED" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Enable Intel AHCI
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iaStorAC" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iaStorAC\StartOverride" /V "0" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iaStorAVC" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iaStorAVC\StartOverride" /V "0" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iaStorV" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iaStorV\StartOverride" /V "0" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\storahci" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\storahci\StartOverride" /V "0" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Enable Legacy F8 Bootmenu
BCDEDIT /Set {Current} BootMenuPolicy Legacy >NUL 2>&1
:: Enforce Device Driver Signing (Default)
BCDEDIT /Set LoadOptions DENABLE_INTEGRITY_CHECKS >NUL 2>&1
BCDEDIT /Set TESTSIGNING OFF >NUL 2>&1
:: Hardware Accelerated GPU Scheduling
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /V "HwSchMode" /T REG_DWORD /D "2" /F >NUL 2>&1
:: Windows Data Execution Prevention (DEP)
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoDataExecutionPrevention" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoHeapTerminationOnCorruption" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "DisableHHDEP" /T REG_DWORD /D "0" /F >NUL 2>&1
BCDEDIT /Set {Current} NX OptOut >NUL 2>&1
:: NTFS File System
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies" /V "LongPathsEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy Objects\{48981759-12F2-42A6-A048-028B3973495F}Machine\System\CurrentControlSet\Policies" /V "LongPathsEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "ContigFileAllocSize" /T REG_DWORD /D "200" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "DisableDeleteNotification" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "LongPathsEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsAllowExtendedCharacter8dot3Rename" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsDisable8dot3NameCreation" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsDisableLastAccessUpdate" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsEnableTxfDeprecatedFunctionality" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsMemoryUsage" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsMftZoneReservation" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "Win31FileSystem" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /V "Win95TruncatedExtensions" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Split Threshold for Svchost (for 16GB RAM)
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /V "SvcHostSplitThresholdInKB" /T REG_DWORD /D "17658348" /F >NUL 2>&1
:: NvCache
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NvCache" /V "OptimizeBootAndResume" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NvCache" /V "EnablePowerModeState" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NvCache" /V "EnableNvCache" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NvCache" /V "EnableSolidStateMode" /T REG_DWORD /D "1" /F >NUL 2>&1
:: DiskQuota
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DiskQuota" /V "Enable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DiskQuota" /V "Enforce" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Kernel DMA
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Kernel DMA Protection" /V "DeviceEnumerationPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
:: HTTP Printing
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Printers" /V "DisableHTTPPrinting" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Printers" /V "DisableWebPnPDownload" /T REG_DWORD /D "1" /F >NUL 2>&1


ECHO :::::::: Ease of Access
:::: Narrator
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "CoupleNarratorCursorKeyboard" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "ECHOChars" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "ECHOWords" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "ErrorNotificationType" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "FollowInsertion" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "IntonationPause" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "NarratorCursorHighlight" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "PlayAudioCues" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator" /V "ReadHints" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NarratorHome" /V "AutoStart" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NarratorHome" /V "MinimizeType" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "ContextVerbosityLevel" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "ContextVerbosityLevelV2" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "DetailedFeedback" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "DuckAudio" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "ECHOToggleKeys" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "OnlineServicesEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "ScriptingEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "UserVerbosityLevel" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam" /V "WinEnterLaunchEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Speech
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /V "ModelDownloadAllowed" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /V "VoiceActivationEnableAboveLockscreen" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /V "VoiceActivationOn" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /V "HasAccepted" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\Microsoft.549981C3F5F10_8wekyb3d8bbwe!App" /V "AgentActivationEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\Microsoft.549981C3F5F10_8wekyb3d8bbwe!App" /V "AgentActivationOnLockScreenEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /V "AgentActivationEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /V "AgentActivationLastUsed" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /V "ModelDownloadAllowed" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /V "VoiceActivationDefaultOn" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Speech" /V "AllowSpeechModelUpdate" /T REG_DWORD /D "0" /F >NUL 2>&1


ECHO :::::::: Gaming
:: Game Bar / Game Mode
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar" /V "AllowAutoGameMode" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar" /V "AutoGameModeEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar" /V "ShowStartupPanel" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameUX" /V "DownloadGameInfo" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameUX" /V "GameUpdateOptions" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameUX" /V "ListRecentlyPlayed" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Captures
REG ADD "HKEY_CURRENT_USER\SYSTEM\GameConfigStore" /V "GameDVR_Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /V "AppCaptureEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /V "HistoricalCaptureEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /V "AllowGameDVR" /T REG_DWORD /D "0" /F >NUL 2>&1
:: SmartGlass
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" /V "BluetoothPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" /V "UserAuthPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1


ECHO :::::::: Mixed Reality
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Holographic" /V "FirstRunSucceeded" /T REG_DWORD /D "0" /F >NUL 2>&1


ECHO :::::::: Network ^& Internet
:: Active Probing (pings to MSFT NCSI server)
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /V "EnableActiveProbing" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Admin Shares
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "AutoShareServer" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "AutoShareWks" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "RestrictNullSessAccess" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "Size" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "SMB1" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "SMB2" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "IRPStackSize" /T REG_DWORD /D "20" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "EnableAuthenticateUserSharing" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "EnableForcedLogoff" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "EnableSecuritySignature" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "ServiceDllUnloadOnStop" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" /V "RequireSecuritySignature" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Adobe Type Manager
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /V "DisableATMFD" /T REG_DWORD /D "1" /F >NUL 2>&1
:: BITS
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\BITS" /V "EnablePeercaching" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\BITS" /V "DisableBranchCache" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\BITS" /V "DisablePeerCachingClient" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\BITS" /V "DisablePeerCachingServer" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Block Files From Internet
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /V "SaveZoneInformation" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments" /V "SaveZoneInformation" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Associations\ModRiskFileTypes" /ve /T REG_SZ /D ".bat;.exe;.reg;.vbs;.chm;.msi;.js;.cmd" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Associations\ModRiskFileTypes" /ve /T REG_SZ /D ".bat;.exe;.reg;.vbs;.chm;.msi;.js;.cmd" /F >NUL 2>&1
::REG ADD "HKEY_USERS\.Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Associations\ModRiskFileTypes" /ve /T REG_SZ /D ".bat;.exe;.reg;.vbs;.chm;.msi;.js;.cmd" /F >NUL 2>&1
:: BranchCache
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PeerDist\HostedCache\Discovery" /V "SCPDiscoveryEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PeerDist\CooperativeCaching" /V "Enable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PeerDist\Service" /V "Enable" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Certificate Revocation Check
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "AuthenticodeEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
:: CredSSP Encryption - Encryption Oracle Remediation
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /V "AllowEncryptionOracle" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Detailed Data Usage
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DusmSvc\Settings" /V "DisableSystemBucket" /T REG_DWORD /D "1" /F >NUL 2>&1
:: DNS
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /V "DoHPolicy" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /V "DisableSmartProtocolReordering" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /V "DisableSmartNameResolution" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /V "EnableMulticast" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /V "RegistrationEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /V "UpdateSecurityLevel" /T REG_DWORD /D "256" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /V "UpdateTopLevelDomainZones" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNSCache\Parameters" /V "DisableParallelAandAAAA" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNSCache\Parameters" /V "MaxCacheTTL" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DNSCache\Parameters" /V "MaxNegativeCacheTTL" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Encrypt and Sign Outgoing Secure Channel
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" /V "RequireStrongKey" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" /V "RequireSignOrSeal" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" /V "SealSecureChannel" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" /V "SignSecureChannel" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Ethernet as Metered Connection
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\DefaultMediaCost" /V "Ethernet" /T REG_DWORD /D "2" /F >NUL 2>&1
:: Find My Device
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Settings\FindMyDevice" /V "LocationSyncEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Hotspot 2.0 Networks
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WLanSvc\AnqpCache" /V "OsuRegistrationStatus" /T REG_DWORD /D "0" /F >NUL 2>&1
:: IIS Installation
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\IIS" /V "PreventIISInstall" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Internet Connection Sharing
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Network Connections" /V "NC_ShowSharedAccessUI" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Intranet Protected Mode
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main" /V "NoProtectedModeBanner" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main" /V "NoProtectedModeBanner" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Microsoft Peer-to-Peer Networking Services
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\\Policies\Microsoft\Peernet" /V "Disabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: NetBIOS over TCP/IP
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /V "NetbiosOptions" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /V "NoNameReleaseOnDemand" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Network Auto Install
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup" /V "GlobalAutoSetup" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Domain" /V "AutoSetup" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private" /V "AutoSetup" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Public" /V "AutoSetup" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Network Connectivity Status Indicator
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /V "NoActiveProbe" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Password Reveal
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CredUI" /V "DisablePasswordReveal" /T REG_DWORD /D "1" /f
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Internet Explorer\Main" /V "DisablePasswordReveal" /T REG_DWORD /D "1" /f
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredUI" /V "DisablePasswordReveal" /T REG_DWORD /D "1" /f
:: Require trusted path for credential entry
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI" /V "EnableSecureCredentialPrompting" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI" /V "EnumerateAdministrators" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Restrict Anonymous Enumeration Shares
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" /V "AllowProtectedCreds" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LanManWorkstation" /V "AllowInsecureGuestAuth" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /V "DisableRemoteScmEndpoints" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "DisableDomainCreds" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "EveryoneIncludesAnonymous" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "ForceGuest" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\FIPSAlgorithmPolicy" /V "Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "LimitBlankPasswordUse" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "LmCompatibilityLevel" /T REG_DWORD /D "5" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "LsaCfgFlags" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "NoLMHash" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "RestrictAnonymous" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "RestrictAnonymousSAM" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "RestrictRemoteSAM" /T REG_SZ /D "O:BAG:BAD:(A;;RC;;;BA)" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "RunAsPPL" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "SCENoApplyLegacyAuditPolicy" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "SecureBoot" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" /V "SubmitControl" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" /V "AllowNullSessionFallBack" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" /V "NTLMMinClientSec" /T REG_DWORD /D "537395200" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" /V "NTLMMinServerSec" /T REG_DWORD /D "537395200" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" /V "RestrictReceivingNTLMTraffic" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" /V "RestrictSendingNTLMTraffic" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\pku2u" /V "AllowOnlineID" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" /V "UseLogonCredential" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManWorkstation\Parameters" /V "DisableBandwidthThrottling" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManWorkstation\Parameters" /V "EnableSecuritySignature" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManWorkstation\Parameters" /V "EnablePlainTextPassword" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManWorkstation\Parameters" /V "RequireSecuritySignature" /T REG_DWORD /D "1" /F >NUL 2>&1
:: LDAP
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LDAP" /V "LDAPClientIntegrity" /T REG_DWORD /D "1" /F >NUL 2>&1
:: RPC Unauthenticated Connections
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\RPC" /V "RestrictRemoteClients" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Router Discovery
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\QoS" /V "Do not use NLA" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\ServiceProvider" /V "DnsPriority" /T REG_DWORD /D "6" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\ServiceProvider" /V "HostsPriority" /T REG_DWORD /D "5" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\ServiceProvider" /V "LocalPriority" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\ServiceProvider" /V "NetbtPriority" /T REG_DWORD /D "7" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /V "NetworkThrottlingIndex" /T REG_DWORD /D "ffffffff" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /V "SystemResponsiveness" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Limit Reservable Bandwidth 
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Psched" /V "NonBestEffortLimit" /T REG_DWORD /D "0" /F >NUL 2>&1
:: MSMQ
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSMQ\Parameters" /V "TCPNoDelay" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Shares Of Recently Opened Documents To Network Locations
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoNetHood" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoRecentDocsNetHood" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoNetHood" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoRecentDocsNetHood" /T REG_DWORD /D "1" /F >NUL 2>&1
:: svchost.exe Security Mitigation
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SCMConfig" /V "EnableSvchostMitigationPolicy" /T REG_DWORD /D "1" /F >NUL 2>&1
:: TCP/IP
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /V "EnableDynamicBacklog" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /V "MinimumDynamicBacklog" /T REG_DWORD /D "20" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /V "MaximumDynamicBacklog" /T REG_DWORD /D "20000" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /V "DynamicBacklogGrowthDelta" /T REG_DWORD /D "10" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DeadGWDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DeadGWDetectDefault" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DisableIPSourceRouting" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableDeadGWDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableDynamicBacklog" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableICMPRedirect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableMultiCastForwarding" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnablePMTUBHDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnablePMTUDiscovery" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableRSS" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableSecurityFilters" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "EnableWsd" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "ForwardBroadcasts" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "IGMPLevel" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "IPEnableRouter" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "KeepAliveInterval" /T REG_DWORD /D "1000" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "KeepAliveTime" /T REG_DWORD /D "300000" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "NoNameReleaseOnDemand" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "PMTUBlackHoleDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "PerformRouterDiscovery" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "SackOpts" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "SynAttackProtect" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCP1323Opts" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPMaxConnectResponseRetransmissions" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPMaxDataRetransmissions" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPMaxDupAcks" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPMaxHalOpen" /T REG_DWORD /D "64" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPMaxHalOpenRetired" /T REG_DWORD /D "50" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPMaxPortsExhausted" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPTimedWaitDelay" /T REG_DWORD /D "30" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPUseRFC1122UrgentPointer" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TCPWindowSize" /T REG_DWORD /D "2238" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "UseDomainNameDevolution" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "UseZeroBroadCast" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "DisableTaskOffload" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DeadGWDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DeadGWDetectDefault" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DisableIPSourceRouting" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableDeadGWDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableDynamicBacklog" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableICMPRedirect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableMultiCastForwarding" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnablePMTUBHDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnablePMTUDiscovery" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableRSS" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableSecurityFilters" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "EnableWsd" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "ForwardBroadcasts" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "IGMPLevel" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "IPEnableRouter" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "KeepAliveInterval" /T REG_DWORD /D "1000" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "KeepAliveTime" /T REG_DWORD /D "300000" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "NoNameReleaseOnDemand" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "PMTUBlackHoleDetect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "PerformRouterDiscovery" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "SackOpts" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "SynAttackProtect" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCP1323Opts" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPMaxConnectResponseRetransmissions" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPMaxDataRetransmissions" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPMaxDupAcks" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPMaxHalOpen" /T REG_DWORD /D "64" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPMaxHalOpenRetired" /T REG_DWORD /D "50" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPMaxPortsExhausted" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPTimedWaitDelay" /T REG_DWORD /D "30" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPUseRFC1122UrgentPointer" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "TCPWindowSize" /T REG_DWORD /D "2238" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "UseDomainNameDevolution" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "UseZeroBroadCast" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DisableTaskOffload" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths" /V "\\*\NETLOGON" /T REG_SZ /D "RequireMutualAuthentication=1, RequireIntegrity=1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths" /V "\\*\SYSVOL" /T REG_SZ /D "RequireMutualAuthentication=1, RequireIntegrity=1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters" /V "DevicePKInitEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters" /V "SupportedEncryptionTypes" /T REG_DWORD /D "2147483640" /F >NUL 2>&1

:: TCP Timestamps
NETSH Int TCP Set Global TimeStamps=Disabled >NUL 2>&1
:: Terminal Server Shadowing
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "Shadow" /T REG_DWORD /D "0" /F >NUL 2>&1
:: VPN related
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PolicyAgent" /V "AssumeUDPEncapsulationContextOnSendRule" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\Parameters" /V "DisableIKENameEkuCheck" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\Parameters" /V "NegotiateDH2048_AES256" /T REG_DWORD /D "2" /F >NUL 2>&1
:: WaitNetworkStartup
REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Winlogon\SyncForegroundPolicy" /F >NUL 2>&1
:: WiFi Sense and Hot Spot
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /V "value" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Default\WiFi\AllowWiFiHotSpotReporting" /V "value" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\Tethering" /V "RemoteStartupDisabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager" /V "WiFiSenseCredShared" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager" /V "WiFiSenseOpen" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Config" /V "AutoConnectAllowedOEM" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Config" /V "DefaultAutoConnectSharedState" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Config" /V "WiFiSenseAllowed" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Config" /V "WiFiSharingFacebookInitial" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Config" /V "WiFiSharingOutlookInitial" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Config" /V "WiFiSharingSkypeInitial" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\crowdsrcplugin" /V "EnableWiFiCrowdsourcing" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Features\S-1-5-21-3752830748-2673197281-2103194476-1000\SocialNetworks\ABCH" /V "OptInStatus" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Features\S-1-5-21-3752830748-2673197281-2103194476-1000\SocialNetworks\ABCH-SKYPE" /V "OptInStatus" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\WiFiNetworkManager\Features\S-1-5-21-3752830748-2673197281-2103194476-1000\SocialNetworks\FACEBOOK" /V "OptInStatus" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy" /V "fBlockNonDomain" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy" /V "fMinimizeConnections" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Windows Connect Now
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /V "DisableFlashConfigRegistrar" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /V "DisableInBand802DOT11Registrar" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /V "DisableUPnPRegistrar" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /V "DisableWPDRegistrar" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\Registrars" /V "EnableRegistrars" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WCN\UI" /V "DisableWcnUi" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Windows Mail
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Mail" /V "DisableCommunities" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Mail" /V "ManualLaunchAllowed" /T REG_DWORD /D "0" /F >NUL 2>&1
:: SCHANNEL
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server" /V "DisabledByDefault" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client" /V "DisabledByDefault" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server" /V "DisabledByDefault" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client" /V "DisabledByDefault" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" /V "DisabledByDefault" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" /V "DisabledByDefault" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" /V "DisabledByDefault" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" /V "DisabledByDefault" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.2\Client" /V "DisabledByDefault" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.2\Client" /V "Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.2\Server" /V "DisabledByDefault" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.2\Server" /V "Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client" /V "Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client" /V "DisabledByDefault" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" /V "Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" /V "DisabledByDefault" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.3\Client" /V "DisabledByDefault" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.3\Client" /V "Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.3\Server" /V "DisabledByDefault" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\DTLS 1.3\Server" /V "Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Client" /V "Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Client" /V "DisabledByDefault" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Server" /V "Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.3\Server" /V "DisabledByDefault" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 64/128" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 128/128" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 40/128" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 56/128" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 64/128" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\DES 56/56" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168/168" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\MD5" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\SHA" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\PKCS" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: EccCurves
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002" /V "EccCurves" /T REG_MULTI_SZ /D "NistP384 NistP256" /F >NUL 2>&1


ECHO :::::::: Personalization
:: Night Light
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Current\default$windows.data.bluelightreduction.bluelightreductionstate\windows.data.bluelightreduction.bluelightreductionstate" /V "Data" /T REG_BINARY /D "43 42 01 00 0A 02 01 00 2A 06 99 AC D5 8F 06 2A" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Current\default$windows.data.bluelightreduction.bluelightreductionstate\windows.data.bluelightreduction.bluelightreductionstate" /V "Data" /T REG_BINARY /D "43 42 01 00 0A 02 01 00 2A 06 9C AC D5 8F 06 2A" /F >NUL 2>&1
:: HDR Streaming
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\VideoSettings" /V "EnableHDRForPlayback" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\VideoSettings" /V "EDRMaxLuminance" /T REG_DWORD /D "300" /F >NUL 2>&1
:: Auto Enhance During Playback
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\VideoSettings" /V "EnableAutoEnhanceDuringPlayback" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Allow Low Resolution
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\VideoSettings" /V "AllowLowResolution" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Disable Other Enhancements On Battery
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\VideoSettings" /V "DisableOtherEnhancementsOnBattery" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Scale Display (125%)
REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\GraphicsDrivers\ScaleFactors\SHP146A0_24_07E0_39^75456C06EC4F911F5356A9227E7D0CF6" /V "DpiValue" /T REG_DWORD /D "4294967295" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop\PerMonitorSettings\SHP146A0_24_07E0_39^75456C06EC4F911F5356A9227E7D0CF6" /V "DpiValue" /T REG_DWORD /D "4294967295" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AutoRotation" /V "LastOrientation" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Colors
:: Dark Mode
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /V "AppsUseLightTheme" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /V "SystemUsesLightTheme" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Transparency
REG ADD "HKEY_USERS\.DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /V "EnableTransparency" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /V "ColorPrevalence" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /V "EnableTransparency" /T REG_DWORD /D "0" /F >NUL 2>&1
:: DWM
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "AnimationAttributionEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "AnimationAttributionHashingEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "AlwaysHibernateThumbnails" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "Animations" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "ColorPrevalence" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "ColorizationBlurBalance" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "ColorizationGlassAttribute" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "ColorizationOpaqueBlend" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "Composition" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "DisallowAnimations" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "DisallowFlip3d" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "DisableAccentGradient" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "EnableAeroPeek" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\DWM" /V "EnableWindowColorization" /T REG_DWORD /D "1" /F >NUL 2>&1
:::: Lock Screen
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "PasswordExpiryWarning" /T REG_SZ /D "5" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "DisableAutomaticRestartSignOn" /T REG_SZ /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "DontDisplayLastUsername" /T REG_SZ /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "ParseAutoexec" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\AccessPage\Camera" /V "CameraEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "AllocateCDRoms" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "AllocateFloppies" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "AutoRestartShell" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "EnableFirstLogonAnimation" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "ParseAutoexec" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "PowerdownAfterShutdown" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "RestartApps" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "SFCDisable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" /V "DisableStartupSound" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen" /V "SlideShowDuration" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableFirstLogonAnimation" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ShutdownWithoutLogon" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "SynchronousMachineGroupPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "SynchronousUserGroupPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "UndockWithoutLogon" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "DisableAcrylicBackgroundOnLogon" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "EnableLogonOptimization" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Do not display the lock screen
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /V "NoLockScreen" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Prevent enabling lock screen camera
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /V "NoLockScreenCamera" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Prevent enabling lock screen slide show
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /V "NoLockScreenSlideshow" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Force a specific background and accent color
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /V "PersonalColors_Background" /T REG_SZ /D "" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /V "PersonalColors_Accent" /T REG_SZ /D "" /F >NUL 2>&1
:: Force a specific default lock screen and logon image
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /V "LockScreenImage" /T REG_SZ /D "" /F >NUL 2>&1
:: Turn off fun facts, tips, tricks, and more on lock screen
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /V "LockScreenOverlaysDisabled" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Force a specific Start background
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /V "ForceStartBackground" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Prevent changing lock screen and logon image
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /V "NoChangingLockScreen" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Prevent changing start menu background
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /V "NoChangingStartMenuBackground" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Prevent lock screen background motion
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /V "AnimateLockScreenBackground" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Biometrics
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics\Credential Provider" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics\Credential Provider" /V "Domain Accounts" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics\Credential Provider" /V "SwitchTimeoutInSeconds" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Biometrics\FacialFeatures" /V "EnhancedAntiSpoofing" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Logon Screen On Resume
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop" /V "ScreenSaverIsSecure" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System\Power" /V "PromptPasswordOnResume" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Welcome Screen
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoWelcomeScreen" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoWelcomeScreen" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Windows Spotlight
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableWindowsConsumerFeatures" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableTailoredExperiencesWithDiagnosticData" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "ConfigureWindowsSpotlight" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableCloudOptimizedContent" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableSoftLanding" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableThirdPartySuggestions" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableWindowsConsumerFeatures" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableWindowsSpotlightFeatures" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableWindowsSpotlightOnActionCenter" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableWindowsSpotlightOnSettings" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableWindowsSpotlightWindowsWelcomeExperience" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "IncludeEnterpriseSpotlight" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /V "DisableThirdPartySuggestions" /T REG_DWORD /D "1" /F >NUL 2>&1


ECHO :::::::: Privacy
:::: General
:: Advertising ID
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /V "DisabledByGroupPolicy" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Current\Device\Bluetooth" /V "AllowAdvertising" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Current\Device\Browser" /V "AllowAddressBarDropdown" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Let Websites Provide Locally Relevant Content By Accessing My Language List
REG ADD "HKEY_USERS\.Default\Control Panel\International\User Profile" /V "HttpAcceptLanguageOptOut" /T REG_DWORD /D "1" /F >NUL 2>&1
:::: Speech

:::: Diagnostics ^& Feedback
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Diagnostics\Performance" /V "DisableDiagnosticTracing" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Diagnostics\Performance\BootCKCLSettings" /V Start /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Diagnostics\Performance\SecondaryLogonCKCLSettings" /V Start /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Diagnostics\Performance\ShutdownCKCLSettings" /V Start /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\ScheduledDiagnostics" /V "EnabledExecution" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EventLog\Application" /V "MaxSize" /T REG_DWORD /D "32768" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EventLog\Security" /V "MaxSize" /T REG_DWORD /D "1024000" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EventLog\System" /V "MaxSize" /T REG_DWORD /D "32768" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EventLog\ProtectedEventLogging" /V "EnableProtectedEventLogging" /T REG_DWORD /D "2" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\ScriptedDiagnostics" /V "EnableDiagnostics" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\ScriptedDiagnostics" /V "ValidateTrust" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\ScriptedDiagnosticsProvider\Policy" /V "DisableQueryRemoteServer" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{C295FBBA-FD47-46AC-8BEE-B1715EC634E5}" /V "DownloadToolsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{C295FBBA-FD47-46AC-8BEE-B1715EC634E5}" /V "ScenarioExecutionEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{EB73B633-3F4E-4BA0-8F60-8F3C6F53168F}" /V "EnabledScenarioExecutionLevel" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{EB73B633-3F4E-4BA0-8F60-8F3C6F53168F}" /V "ScenarioExecutionEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Microsoft Help and Feedback
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /V "PeriodInNanoSeconds" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules" /V "NumberOfSIUFInPeriod" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /V "NoActiveHelp" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /V "NoExplicitFeedback" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /V "NoImplicitFeedback" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /V "NoOnlineAssist" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /V "NoActiveHelp" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /V "NoExplicitFeedback" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /V "NoImplicitFeedback" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /V "NoOnlineAssist" /T REG_DWORD /D "1" /F >NUL 2>&1
:: F1 key - Help and Support
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\Win32" /VE /T REG_SZ /D "" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Classes\Typelib\{8cec5860-07a1-11d9-b15e-000d56bfe6ee}\1.0\0\Win64" /VE /T REG_SZ /D "" /F >NUL 2>&1
TASKLIST | FIND /I "HelpPane.exe" /F >NUL 2>&1 && TASKKILL /F /IM HelpPane.exe >NUL 2>&1
IF EXIST %SYSTEMROOT%\HelpPane.exe (TAKEOWN /F %SYSTEMROOT%\HelpPane.exe && ICACLS %SYSTEMROOT%\HelpPane.exe /INHERITANCE:R /REMOVE Administrators) >NUL 2>&1
:: Telemetry
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "AllowTelemetry" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "DisableDiagnosticDataViewer" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "DoNotShowFeedbackNotifications" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /V "ShowedToastAtLevel" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "AllowCommercialDataPipeline" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "AllowDesktopAnalyticsProcessing" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "AllowDeviceNameInDiagnosticData" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "AllowDeviceNameInTelemetry" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "AllowUpdateComplianceProcessing" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "AllowWUfBCloudProcessing" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "ConfigureMicrosoft365UploadEndpointValue" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "DisableTelemetryOptInChangeNotification" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /V "LimitEnhancedDiagnosticDataWindowsAnalytics" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /V "DiagTrackAuthorization" /T REG_DWORD /D "7" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /V "AllowTelemetry" /T REG_DWORD /D "0" /F >NUL 2>&1
:: .NET Core CLI telemetry
SETX DOTNET_CLI_TELEMETRY_OPTOUT 1 >NUL 2>&1
:: PowerShell 7^+ telemetry
SETX POWERSHELL_TELEMETRY_OPTOUT 1 >NUL 2>&1
:: Windows Messaging and Customer Experience Improvement Program (CEIP)
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Messenger\Client" /V "CEIP" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Messenger\Client" /V "PreventRun" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\IE" /V "CEIPEnable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\IE" /V "SqmLoggerRunning" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\Reliability" /V "CEIPEnable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\Reliability" /V "SqmLoggerRunning" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\Windows" /V "CEIPEnable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\Windows" /V "DisableOptinExperience" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SQMClient\Windows" /V "SqmLoggerRunning" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppV\CEIP" /V "CEIPEnable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Messenger\Client" /V "CEIP" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Messenger\Client" /V "PreventAutoRun" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Messenger\Client" /V "PreventRun" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /V "CEIPEnable" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Windows Performance PerfTrack Log
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{9C5A40DA-B965-4FC3-8781-88DD50A6299D}" /V "ScenarioExecutionEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Tailored Experiences
REG ADD "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Privacy" /V "TailoredExperiencesWithDiagnosticDataEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /V "TailoredExperiencesWithDiagnosticDataEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /V "TailoredExperiencesWithDiagnosticDataEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Activity History (Activity Feed / Timeline)
:: App Permissions
:: Location Tracking and Sensors
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /V "SensorPermissionState" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /V "DisableLocation" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /V "DisableLocationScripting" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /V "DisableSensors" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /V "DisableWindowsLocationProvider" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /V "Status" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Activity" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\AppDiagnostics" /V "Value" /T REG_SZ /D "Deny" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Appointments" /V "Value" /T REG_SZ /D "Deny" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Bluetooth" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\BluetoothSync" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\BroadFileSystemAccess" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\CellularData" /V "Value" /T REG_SZ /D "Deny" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Chat" /V "Value" /T REG_SZ /D "Deny" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Contacts" /V "Value" /T REG_SZ /D "Deny" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\DocumentsLibrary" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Email" /V "Value" /T REG_SZ /D "Deny" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\GazeInput" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\HumanInterfaceDevice" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Location" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Microphone" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\PhoneCall" /V "Value" /T REG_SZ /D "Deny" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\PhoneCallHistory" /V "Value" /T REG_SZ /D "Deny" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\PicturesLibrary" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Radios" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Sensors.Custom" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\SerialCommunication" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Usb" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\UserAccountInformation" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\UserDataTasks" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\UserNotificationListener" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\VideosLibrary" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\Webcam" /V "Value" /T REG_SZ /D "Deny" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\WiFiData" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\WiFiDirect" /V "Value" /T REG_SZ /D "Allow" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /V "LetAppsActivateWithVoiceAboveLock" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /V "LetAppsActivateWithVoice" /T REG_DWORD /D "2" /F >NUL 2>&1


ECHO :::::::: System
:::: Notifications ^& Actions
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /V "NoToastApplicationNotification" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /V "NoToastApplicationNotificationOnLockScreen" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\System" /V "DisableLockScreenAppNotifications" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /V "UseActionCenterExperience" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "DisableNotificationCenter" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /V "NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /V "NOC_GLOBAL_SETTING_ALLOW_Notification_SOUND" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /V "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /V "NOC_GLOBAL_SETTING_TOASTS_ENABLED" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /V "AudioEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /V "LockScreenToastEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /V "NoCloudApplicationNotification" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /V "NoTileApplicationNotification" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /V "NoToastApplicationNotification" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /V "ToastEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Power ^& Sleep
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51" /V "ACSettingIndex" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51" /V "DCSettingIndex" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Get Rid of Fast StartUp, Hibernation and Sleep functions (4 minutes monitor off)
::POWERCFG /SetActive 381B4222-F694-41F0-9685-FF5BB260DF2E >NUL 2>&1
::POWERCFG /H OFF >NUL 2>&1
::POWERCFG /SETACVALUEINDEX SCHEME_CURRENT SUB_BUTTONS SBUTTONACTION 0 >NUL 2>&1
::POWERCFG /SETDCVALUEINDEX SCHEME_CURRENT SUB_BUTTONS SBUTTONACTION 0 >NUL 2>&1
::POWERCFG /X -Disk-TimeOut-AC 0 >NUL 2>&1
::POWERCFG /X -Disk-TimeOut-DC 0 >NUL 2>&1
::POWERCFG /X -Hibernate-TimeOut-AC 0 >NUL 2>&1
::POWERCFG /X -Hibernate-TimeOut-DC 0 >NUL 2>&1
::POWERCFG /X -Monitor-TimeOut-AC 4 >NUL 2>&1
::POWERCFG /X -Monitor-TimeOut-DC 4 >NUL 2>&1
::POWERCFG /X -Standby-TimeOut-AC 0 >NUL 2>&1
::POWERCFG /X -Standby-TimeOut-DC 0 >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "HiberbootEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /V "HiberbootEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /V "HibernateEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /V "HibernateEnabledDefault" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Start Menu Options
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /V "ShowHibernateOption" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /V "ShowSleepOption" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /V "ShowLockOption" /T REG_DWORD /D "1" /F >NUL 2>&1
:: WinHTTP Registrations
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Mappings" /V "CleanupLeakedContainerRegistrations" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" /V "CleanupLeakedContainerRegistrations" /T REG_DWORD /D "1" /F >NUL 2>&1
:::: Storage
:: Storage Sense
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense" /F >NUL 2>&1
:: Enhanced Storage Devices
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EnhancedStorageDevices" /V "TCGSecurityActivationDisabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Disable Reserved Storage
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /V "MiscPolicyInfo" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /V "PassedPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ReserveManager" /V "ShippedWithReserves" /T REG_DWORD /D "0" /F >NUL 2>&1
DISM /Online /Set-ReservedStorageState /State:Disabled >NUL 2>&1
:::: Tablet
:: Multitasking (Snap windows - refer to explorer customizations)
:: Activity Feed / Timeline
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "EnableActivityFeed" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\System" /V "PublishUserActivities" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\System" /V "UploadUserActivities" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Shared Experiences
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "EnableCdp" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "EnableMmx" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /V "CDPSessionUserAuthzPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /V "NearShareChannelUserAuthzPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /V "RomeSDKChannelUserAuthzPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP\SettingsPage" /V "BluetoothLastDisabledNearShare" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP\SettingsPage" /V "NearShareChannelUserAuthzPolicy" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Clipboard
:: Clipboard History
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Clipboard" /V "EnableClipboardHistory" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\System" /V "AllowClipboardHistory" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\System" /V "AllowCrossDeviceClipboard" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "AllowClipboardHistory" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "AllowCrossDeviceClipboard" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Remote Desktop
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule" /V "DisableRPCoverTCP" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "CallSecurity" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "MaxFileSendSize" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "MaximumBandwidth" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoAddingDirectoryServers" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoAdvancedCalling" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoAllowControl" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoAppSharing" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoAudio" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoAudioPage" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoAutoAcceptCalls" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoChangeDirectSound" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoChangingCallMode" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoChat" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoDirectoryServices" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoFullDuplex" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoGeneralPage" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoNewWhiteBoard" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoOldWhiteBoard" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoRDS" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoReceivingFiles" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoReceivingVideo" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoSecurityPage" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoSendingFiles" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoSendingVideo" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoSharing" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoSharingDesktop" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoSharingDosWindows" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoSharingExplorer" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoTrueColorSharing" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoVideoPage" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "NoWebDirectory" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "PersistAutoAcceptCalls" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Conferencing" /V "Use AutoConfig" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Terminal Server Shadowing
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "AllowSignedFiles" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "AllowUnsignedFiles" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "CreateEncryptedOnlyTickets" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "DisablePasswordSaving" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "fAllowFullControl" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "AllowTSConnections" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "fAllowToGetHelp" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "fAllowUnsolicited" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "fAllowUnsolicitedFullControl" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "fAllowUnlistedRemotePrograms" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "fDenyTSConnections" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "fDisableCDM" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "fDisableClip" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "fEncryptRPCTraffic" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "Shadow" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "TSAppCompat" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "TSEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "TSUserEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "fPromptForPassword" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /V "MinEncryptionLevel" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client" /V "fEnableUsbBlockDeviceBySetupClass" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client" /V "fEnableUsbNoAckIsochWriteToDevice" /T REG_DWORD /D "50" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client" /V "fEnableUsbSelectDeviceByInterface" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Client" /V "fUsbRedirectionEnableMode" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client" /V "AllowBasic" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client" /V "AllowDigest" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client" /V "AllowUnencryptedTraffic" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" /V "AllowBasic" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" /V "AllowDigest" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" /V "AllowUnencryptedTraffic" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" /V "DisableRunAs" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service\WinRS" /V "AllowRemoteShellAccess" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /V "AllowRemoteRPC" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /V "StartRCM" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /V "TSUserEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /V "fDenyTSConnections" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /V "fSingleSessionPerUser" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-TCP" /V "UserAuthentication" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-TCP" /V "fDisableEncryption" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Remote Assistance
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /V "AllowRemoteRPC" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /V "CreateEncryptedOnlyTickets" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /V "fAllowFullControl" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /V "fAllowToGetHelp" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance" /V "fEnableChatControl" /T REG_DWORD /D "0" /F >NUL 2>&1

:::: Crash Control
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "AlwaysKeepMemoryDump" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "AutoReboot" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "CrashDumpEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "DisplayParameters" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "DumpLogLevel" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "EnableLogFile" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "LogEvent" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "MinidumpsCount" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "Overwrite" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl" /V "SendAlert" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl\StorageTelemetry" /V "DeviceDumpEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: DISM Servicing Options
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /V "EnableDpxLog" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /V "EnableLog" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /V "DisableRemovePayload" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /V "DisableComponentBackups" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /V "DisableResetBase" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /V "LatentActions" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /V "NumCBSPersistLogs" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide\Configuration" /V "SupersededActions" /T REG_DWORD /D "1" /F >NUL 2>&1
:::: Memory Management
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "SystemPages" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization" /V "MinVmVersionForCpuBasedMitigations" /T REG_SZ /D "1.0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /V "CWDIllegalInDllSearch" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /V "ProtectionMode" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /V "SafeDLLSearchMode" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /V "SafeProcessSearchMode" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /V "StartRunNoHOMEPATH" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /V "DisableExceptionChainValidation" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /V "RestrictAnonymousSAM" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "ClearPageFileAtShutdown" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "DisablePagingExecutive" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "Featuresettings" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "FeaturesettingsOverride" /T REG_DWORD /D "72" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "FeaturesettingsOverrideMask" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "LargeSystemCache" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /V "SwapFileControl" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: OOBE
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /V "ScoobeSystemSettingEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\OOBE" /V "DisablePrivacyExperience" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OOBE" /V "DisablePrivacyExperience" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "DisableVoice" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "HideEULAPage" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "HideLocalAccountScreen" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "HideOEMRegistrationScreen" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "HideOnlineAccountScreens" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "HideWirelessSetupInOOBE" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "SkipMachineOOBE" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "SkipUserOOBE" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "ProtectYourPC" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /V "UnattendEnableRetailDemo" /T REG_DWORD /D "0" /F >NUL 2>&1
:::: Windows Explorer Clean and Speed UP
:: Active Desktop (obsolete in Win10?)
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /V "NoADDingComponents" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /V "NoClosingComponents" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /V "NoComponents" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /V "NoDeletingComponents" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /V "NoEditingComponents" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /V "NoHTMLWallPaper" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "ForceActiveDesktopOn" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoActiveDesktop" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoActiveDesktopChanges" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Application Suggestions and Automatic Installation (ContentDeliveryManager)
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy" /V "Disabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "ContentDeliveryAllowed" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "FeatureManagementEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "OemPreInstalledAppsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "PreInstalledAppsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "PreInstalledAppsEverEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "ReInstalledAppsEverEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "RotatingLockScreenEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "RotatingLockScreenOverlayEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SilentInstalledAppsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SlideShowEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SoftlandingEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-202913Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-202914Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280797Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280810Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280811Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280812Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280813Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280814Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280815Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-280817Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-310091Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-310092Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Let’s finish setting up your device
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-310093Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-310094Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-314558Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-314559Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-314562Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-314563Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-314566Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-314567Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338380Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338381Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338382Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338386Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338387Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338388Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338389Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-338393Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-346480Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-346481Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-353694Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-353695Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-353696Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-353697Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-353698Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-353699Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000044Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000045Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000105Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000106Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000161Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000162Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000163Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000164Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000165Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SubscribedContent-88000166Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SystemPaneSuggestionsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\202914" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\202914" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\280815" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\280815" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\310091" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\310091" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\310093" /V "AllowPartialContentAvailability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\310093" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\310093" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\314559" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\314559" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\338387" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\338387" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\338388" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\338388" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\338389" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\338389" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\353694" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\353694" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\353698" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\353698" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000045" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000045" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000105" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000105" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000161" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000161" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000163" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000163" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000165" /V "Availability" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions\88000165" /V "HasContent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SilentInstalledAppsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /V "SilentInstalledAppsEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /F >NUL 2>&1
:: Automatic Refresh (F5)
REG ADD "HKEY_CLASSES_ROOT\CLSID\{BDEADE7F-C265-11D0-BCED-00A0C90AB50F}\Instance" /V "DontRefresh" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\WoW6432Node\CLSID\{BDEADE7F-C265-11D0-BCED-00A0C90AB50F}\Instance" /V "DontRefresh" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\EXPLORER.EXE" /V "DontUseDesktopChangeRouter" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoRemoteChangeNotIFy" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoRemoteRecursiveEvents" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop" /V "ExplorerRefreshOnRename" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Update" /V "UpdateMode" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Automatically Hide Scroll Bars
REG ADD "HKEY_CURRENT_USER\Control Panel\Accessibility" /V "DynamicScrollbars" /T REG_DWORD /D "0" /F >NUL 2>&1
:: PowerShell
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DontUsePowerShellOnWinX" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DontUsePowerShellOnWinX" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription" /V "EnableTranscripting" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell" /V "EnableScripts" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /V "__PSLockDownPolicy" /T REG_SZ /D "4" /F >NUL 2>&1
:: Confirm DELETE Dialog Box
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "ConfirmFileDelete" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "ConfirmFileDelete" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Default Drag n Drop
:: 0 or DELETE = Default action / 1 = Always copy / 2 = Always move / 4 = Always create shortcut
::REG ADD "HKEY_CLASSES_ROOT\AllFileSystemObjects" /V "DefaultDropEffect" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Desktop Gadgets
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /V "DisableCharmsHint" /F >NUL 2>&1
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /V "DisableTLCorner" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /V "DisableCharmsHint" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /V "DisableTLCorner" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Windows\Sidebar" /V "TurnOffSidebar" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Windows\Sidebar" /V "TurnOffUnsignedGadgets" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Windows\Sidebar" /V "TurnOffUserInstalledGadgets" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Sidebar\Settings" /V "AllowElevatedProcess" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Desktop Icons
:: My Computer on Desktop
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Recycled Bin on Desktop
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{645FF040-5081-101B-9F08-00AA002F954E}" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /V "{645FF040-5081-101B-9F08-00AA002F954E}" /T REG_DWORD /D "0" /F >NUL 2>&1
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
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134EF9C-6B18-4996-AD04-ED5912E00EB5}" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3936E9E4-D92C-4EEE-A85A-BC16D5EA0819}" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134EF9C-6B18-4996-AD04-ED5912E00EB5}" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3936E9E4-D92C-4EEE-A85A-BC16D5EA0819}" /F >NUL 2>&1
:: Remove 3D Objects
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /F >NUL 2>&1
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
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3DFDF296-DBEC-4FB4-81D1-6A3438BCF4DE}" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4EBB-811F-33C572699FDE}" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3DFDF296-DBEC-4FB4-81D1-6A3438BCF4DE}" /F >NUL 2>&1
:: Remove Pictures
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24AD3AD4-A569-4530-98E1-AB02F9417AA8}" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4CB0-BBD7-DFA0ABB5ACCA}" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24AD3AD4-A569-4530-98E1-AB02F9417AA8}" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4CB0-BBD7-DFA0ABB5ACCA}" /F >NUL 2>&1
:: Remove Videos
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43BF-BE83-3742FED03C9C}" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{F86FA3AB-70D2-4FC7-9C99-FCBF05467F3A}" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43BF-BE83-3742FED03C9C}" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{F86FA3AB-70D2-4FC7-9C99-FCBF05467F3A}" /F >NUL 2>&1
:: File Explorer Customizations
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "MapNetDrvBtn" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "ClearRecentDocsOnExit" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "DisablePersonalDirChange" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoAutoTrayNotIFy" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoChangeStartMenu" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoInstrumentation" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoRecentDocsHistory" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoStartMenuMFUprogramsList" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "PreXPSP2ShellProtocolBehavior" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "HideRecentlyADDedApps" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoNewAppAlert" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\SOFTWARE\Microsoft\Windows\Shell\Bags\AllFolders\Shell" /V "FolderType" /T REG_SZ /D "NotSpecIFied" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "AlwaysShowMenus" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "AutoCheckSelect" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisableThumbnailCache" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisallowShaking" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DontPrettyPath" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "EnableBalloonTips" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "FolderContentsInfoTip" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "Hidden" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "HideDrivesWithNoMedia" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "HideFileExt" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "HideIcons" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "HideMergeConflicts" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "IconsOnly" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "JointResize" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "LaunchTo" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ListviewAlphaSelect" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ListviewShadow" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "LockTaskbar" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NavPaneExpandToCurrentFolder" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NavPaneShowAllFolders" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NoNetCrawling" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NoSharedDocuments" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NoTaskGrouping" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "PersistBrowsers" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "SeparateProcess" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "SharingWizardOn" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowCompColor" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowInfoTip" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowPreviewHandlers" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowSecondsInSystemClock" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowStatusBar" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowSuperHidden" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowSyncProviderNotifications" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowTaskViewButton" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowTypeOverlay" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "SnapAssist" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "SnapFill" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "Start_NotifyNewApps" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "Start_SearchFiles" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "Start_TrackDocs" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "Start_TrackProgs" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "StoreAppsOnTaskbar" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "SuperHidden" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarAnimations" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarAppsVisibleInTabletMode" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarBadges" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarSizeMove" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarSmallIcons" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "UseCheckBoxes" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "WebView" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "WebViewBarricade" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisablePreviewDesktop" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /V "Append Completion" /T REG_SZ /D "No" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete" /V "AutoSuggest" /T REG_SZ /D "No" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /V "FullPath" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" /V "FullPathADDress" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /V "StartupPage" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Ribbon" /V "MinimizedStateTabletModeOff" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Ribbon" /V "MinimizedStateTabletModeOn" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "DisableIndexedLibraryExperience" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "DisableSearchBoxSuggestions" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "EnableShellExecuteFileStreamCheck" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "ExplorerRibbonStartsMinimized" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoSearchInternetTryHarderButton" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoUseStoreOpenWith" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "ShowRunAsDifferentUserInStart" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "DisableIndexedLibraryExperience" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "DisableSearchBoxSuggestions" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "EnableShellExecuteFileStreamCheck" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "ExplorerRibbonStartsMinimized" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoSearchInternetTryHarderButton" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoUseStoreOpenWith" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "ShowRunAsDIFferentUserInStart" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "ActiveSetupDisabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "ActiveSetupTaskOverride" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "DisableEdgeDesktopShortcutCreation" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "EnableAutoTray" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "ShowFrequent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "ShowRecent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "LocalKnownFoldersMigrated" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "ShowDriveLettersFirst" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "TelemetrySalt" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "EnableLegacyBalloonNotifications" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoBalloonFeatureAdvertisements" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoSMBalloonTip" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "AllowOnlineTips" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "LinkResolveIgnoreLinkInfo" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoAutoTrayNotIFy" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoCloseDragDropBands" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoDrivesInSendToMenu" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoInternetOpenWith" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoLowDiskSpaceChecks" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoOnlinePrintsWizard" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoPublishingWizard" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoRecentDocsMenu" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoResolveSearch" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoResolveTrack" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoSimpleNetIDList" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoStrCmpLogical" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoToolbarsOnTaskbar" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoWebServices" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoNetHood" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoRecentDocsNetHood" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "PreventItemCreationInUsersFilesFolder" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "TurnOffSPIAnimations" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoPreviewPane" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoReadingPane" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "NoUseStoreOpenWith" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\StigRegKey\Typing\TaskbarAvoidanceEnabled" /V "TaskbarAvoidanceEnabled" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Explorer Ribbon
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Classes\CLSID\{d93ed569-3b3e-4bff-8355-3c44f6a52bb5}\InprocServer32" /VE /T REG_SZ /D "-" /F >NUL 2>&1
:: Audit Process Creation
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit" /V "ProcessCreationIncludeCmdLine_Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
:: USB/external Duplicates
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /F >NUL 2>&1
:: File History
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\FileHistory" /V "Disabled" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\FileHistory" /V "Disabled" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Icon Cache
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "Max Cached Icons" /T REG_SZ /D "10240" /F >NUL 2>&1
:: Maintenance
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /V "MaintenanceDisabled" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Mobility Center
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\MobilityCenter" /V "NoMobilityCenter" /T REG_DWORD /D "1" /F >NUL 2>&1
:: MUI Cache
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Classes\Local Settings\MUICache" /F >NUL 2>&1
:: Notepad
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Notepad" /V "StatusBar" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Notepad" /V "fWrapAround" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\SOFTWARE\Microsoft\Notepad" /V "StatusBar" /T REG_DWORD /D "1" /F >NUL 2>&1
:: People Bar
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /V "HidePeopleBar" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /V "PeopleBand" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /V "PeopleBand" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Provide Locally Relevant Content
REG ADD "HKEY_CURRENT_USER\Control Panel\International\User Profile" /V "HttpAcceptLanguageOptOut" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Remove Icon and Thumbnail Cache
::IF EXIST %LOCALAPPDATA%\IconCache.db (ATTRIB -H %LOCALAPPDATA%\IconCache.db & DEL /F /S /Q %LOCALAPPDATA%\IconCache.db & FSUTIL File CreateNew %LOCALAPPDATA%\IconCache.db 0) >NUL 2>&1
::IF EXIST %LOCALAPPDATA%\Microsoft\Windows\Explorer\*.db (ATTRIB -H %LOCALAPPDATA%\Microsoft\Windows\Explorer\*.db & DEL /F /S /Q %LOCALAPPDATA%\Microsoft\Windows\Explorer\*.db) >NUL 2>&1
:: Remove 'Shortcut' Text and Arrow
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "Link" /T REG_BINARY /D "00 00 00 00" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" /V "ShortcutNameTemplate" /T REG_SZ /D "%s.lnk" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "Link" /T REG_BINARY /D "00 00 00 00" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates" /V "ShortcutNameTemplate" /T REG_SZ /D "%s.lnk" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "Link" /T REG_BINARY /D "00 00 00 00" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /V "29" /T REG_SZ /D "" /F >NUL 2>&1
:: Remove Video Preview Border on Navigation Pane
REG ADD "HKEY_CLASSES_ROOT\SystemFileAssociations\Image" /V "Treatment" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SystemFileAssociations\Image" /V "Treatment" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Show More Details in File Transfer Dialog
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /V "ConfirmationCheckBoxDoForAll" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /V "EnthusiastMode" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /V "ConfirmationCheckBoxDoForAll" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /V "EnthusiastMode" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Speed Up
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /V "VisualFXSetting" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "ActiveWndTrackTimeout" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "AutoColorization" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "AutoEndTasks" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "DockMoving" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "DragFromMaximize" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "DragFullWindows" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "FontSmoothing" /T REG_SZ /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "ForegroundFlashCount" /T REG_DWORD /D "5" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "HungAppTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "LowLevelHooksTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "MenuShowDelay" /T REG_SZ /D "100" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "MouseWheelRouting" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "PaintDesktopVersion" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "SmoothScroll" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "UserPreferencesMask" /T REG_BINARY /D "9812038010000000" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "WaitToKillAppTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /V "WaitToKillServiceTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop" /V "ActiveWndTrackTimeout" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop" /V "AutoColorization" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop" /V "AutoEndTasks" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop" /V "DockMoving" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop" /V "DragFromMaximize" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop" /V "DragFullWindows" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop" /V "FontSmoothing" /T REG_SZ /D "2" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop" /V "ForegroundFlashCount" /T REG_DWORD /D "5" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop" /V "HungAppTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop" /V "LowLevelHooksTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop" /V "MenuShowDelay" /T REG_SZ /D "100" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop" /V "MouseWheelRouting" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop" /V "PaintDesktopVersion" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop" /V "SmoothScroll" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop" /V "UserPrefenrencesMask" /T REG_BINARY /D "9812038010000000" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop" /V "WaitToKillAppTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop" /V "WaitToKillServiceTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /V "StartupDelayInMSec" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "AllowBlockingAppsAtShutdown" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /V "WaitToKillServiceTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control" /V "WaitToKillServiceTimeout" /T REG_SZ /D "1000" /F >NUL 2>&1
:: Keyboard Delay
REG ADD "HKEY_CURRENT_USER\Control Panel\Keyboard" /V "KeyboardDelay" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Keyboard" /V "KeyboardSpeed" /T REG_SZ /D "31" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Keyboard" /V "InitialKeyboardIndicators" /T REG_SZ /D "2147483650" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Keyboard" /V "KeyboardDelay" /T REG_SZ /D "1" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Keyboard" /V "KeyboardSpeed" /T REG_SZ /D "31" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Keyboard" /V "InitialKeyboardIndicators" /T REG_SZ /D "2147483650" /F >NUL 2>&1
:: No Beep
REG ADD "HKEY_CURRENT_USER\Control Panel\Sound" /V "Beep" /T REG_SZ /D "No" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\Control Panel\Sound" /V "ExtendedSounds" /T REG_SZ /D "No" /F >NUL 2>&1
:: Window Animations
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics" /V "MinAnimate" /T REG_SZ /D "0" /F >NUL 2>&1
REG ADD "HKEY_USERS\.Default\Control Panel\Desktop\WindowMetrics" /V "MinAnimate" /T REG_SZ /D "0" /F >NUL 2>&1
:: Task Manager More Details
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\TaskManager" /V "Preferences" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\TaskManager" /V "StartUpTab" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\TaskManager" /V "UseStatusSetting" /T REG_DWORD /D "1" /F >NUL 2>&1
:: TouchScreen
::REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Wisp\Touch" /V "TouchGate" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Windows Error Reporting
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /V "DontSendADDitionalData" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /V "LoggingDisabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /V "Disabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /V "DoReport" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /V "ForceQueueMode" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" /V "DWNoExternalURL" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" /V "DWNoFileCollection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting\DW" /V "DWNoSecondLevelCollection" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\HelpSvc" /V "Headlines" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\HelpSvc" /V "MicrosoftKBSearch" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /V "DisableSendGenericDriverNotFoundToWER" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /V "DisableSendRequestADDitionalSOFTWAREToWER" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /V "AutoApproveOSDumps" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /V "Disabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /V "DontSendADDitionalData" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /V "LoggingDisabled" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Windows Script Host
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Script Host\Settings" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Windows Administrative Tools
:: Device Manager
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /V "DEVMGR_SHOW_DETAILS" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /V "DEVMGR_SHOW_NONPRESENT_DeviceS" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Event Viewer
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EventViewer" /V "MicrosoftEventVwrDisableLinks" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Virtualization App-V
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppV\Client" /V "Enabled" /T REG_DWORD /D "0" /F >NUL 2>&1
:: DCOM
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Ole" /V "EnableDCOM" /T REG_SZ /D "N" /F >NUL 2>&1
:: AppInit_DLLs
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /V "LoadAppInit_DLLs" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /V "RequireSignedAppInit_DLLs" /T REG_DWORD /D "1" /F >NUL 2>&1
 :::: Windows Explorer Right Click Menu Enhance
:: Classic Full Context Menu
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /VE /T REG_SZ /D "-" /F >NUL 2>&1
:: 3D Edit
REG DELETE "HKEY_CLASSES_ROOT\SystemFileAssociations\.3mf\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\SystemFileAssociations\.bmp\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\SystemFileAssociations\.fbx\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\SystemFileAssociations\.gIF\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\SystemFileAssociations\.glb\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\SystemFileAssociations\.jfIF\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\SystemFileAssociations\.jpe\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\SystemFileAssociations\.jpeg\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\SystemFileAssociations\.jpg\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\SystemFileAssociations\.obj\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\SystemFileAssociations\.ply\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\SystemFileAssociations\.png\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\SystemFileAssociations\.stl\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\SystemFileAssociations\.tIF\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\SystemFileAssociations\.tIFf\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.3mf\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.bmp\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.fbx\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.gIF\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.glb\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jfIF\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpe\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpeg\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.jpg\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.obj\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.ply\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.png\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.stl\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.tIF\Shell\3D Edit" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.tIFf\Shell\3D Edit" /F >NUL 2>&1
:: ADD to 'New' Menu
IF EXIST "%APPDATA%\Microsoft\Windows\SendTo\Mail recipient.*" DEL /F /S /Q "%APPDATA%\Microsoft\Windows\SendTo\Mail recipient.*" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\.cmd\ShellNew" /V "NullFile" /T REG_SZ /D "" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\Drive\ShellEx\-ContextMenuHandlers\{FBEB8A05-BEEE-4442-804E-409D6C4515E9}" /VE /T REG_SZ /D "" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\batfile\ShellEx\-ContextMenuHandlers\Compatibility" /VE /T REG_SZ /D "{1D27F844-3A1F-4410-85AC-14651078412D}" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\cmdfile\ShellEx\-ContextMenuHandlers\Compatibility" /VE /T REG_SZ /D "{1D27F844-3A1F-4410-85AC-14651078412D}" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\exefile\ShellEx\-ContextMenuHandlers\Compatibility" /VE /T REG_SZ /D "{1D27F844-3A1F-4410-85AC-14651078412D}" /F >NUL 2>&1
:: Allow Mapped Drives in Command Prompt
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableLinkedConnections" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Cast to Device
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /V "{7AD84985-87B4-4A16-BE58-8B72A5B390F7}" /T REG_SZ /D "Play to menu" /F >NUL 2>&1
:: CD Burning
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoCDBurning" /T REG_DWORD /D "1" /F >NUL 2>&1

:: Command Prompt (Administrator)
REG DELETE "HKEY_CLASSES_ROOT\Directory\Shell\RunAs" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\Directory\Shell\RunAs" /VE /T REG_SZ /D "Command Prompt (Administrator)" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\Directory\Shell\RunAs" /V "HasLUAShield" /T REG_SZ /D "" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\Directory\Shell\RunAs\Command" /VE /T REG_SZ /D "CMD.EXE /S /K pushd \"%V\"" /F >NUL 2>&1
reg DELETE "HKEY_CLASSES_ROOT\Directory\Background\Shell\RunAs" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\Shell\RunAs" /VE /T REG_SZ /D "Command Prompt (Administrator)" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\Shell\RunAs" /V "HasLUAShield" /T REG_SZ /D "" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\Directory\Background\Shell\RunAs\Command" /VE /T REG_SZ /D "CMD.EXE /S /K pushd \"%V\"" /F >NUL 2>&1
reg DELETE "HKEY_CLASSES_ROOT\Drive\Shell\RunAs" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\Drive\Shell\RunAs" /VE /T REG_SZ /D "Command Prompt (Administrator)" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\Drive\Shell\RunAs" /V "HasLUAShield" /T REG_SZ /D "" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\Drive\Shell\RunAs\Command" /VE /T REG_SZ /D "CMD.EXE /S /K pushd \"%V\"" /F >NUL 2>&1
:: Copy as path
::REG ADD "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /V "CanonicalName" /T REG_SZ /D "{707C7BC6-685A-4A4D-A275-3966A5A3EFAA}" /F >NUL 2>&1
::REG ADD "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /V "CommandStateHandler" /T REG_SZ /D "{3B1599F9-E00A-4BBF-AD3E-B3F99FA87779}" /F >NUL 2>&1
::REG ADD "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /V "CommandStateSync" /T REG_SZ /D "" /F >NUL 2>&1
::REG ADD "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /V "Description" /T REG_SZ /D "@shell32.dll,-30336" /F >NUL 2>&1
::REG ADD "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /V "Icon" /T REG_SZ /D "Imageres.dll,-5302" /F >NUL 2>&1
::REG ADD "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /V "InvokeCommandOnSelection" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /V "MUIVerb" /T REG_SZ /D "@shell32.dll,-30329" /F >NUL 2>&1
::REG ADD "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /V "VerbHandler" /T REG_SZ /D "{F3D06E7C-1E45-4A26-847E-F9FCDEE59BE0}" /F >NUL 2>&1
::REG ADD "HKEY_CLASSES_ROOT\AllFileSystemObjects\Shell\Windows.CopyAsPath" /V "VerbName" /T REG_SZ /D "copyaspath" /F >NUL 2>&1
::REG ADD "HKEY_CLASSES_ROOT\AllfileSystemObjects\Shell\Windows.CopyAsPath" /VE /T REG_SZ /D "Copy As Path" /F >NUL 2>&1

:: Copy To / Move To
REG ADD "HKEY_CLASSES_ROOT\AllFileSystemObjects\ShellEx\ContextMenuHandlers\Copy To" /VE /T REG_SZ /D "{C2FBB630-2971-11D1-A18C-00C04FD75D13}" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\AllFileSystemObjects\ShellEx\ContextMenuHandlers\Move To" /VE /T REG_SZ /D "{C2FBB631-2971-11D1-A18C-00C04FD75D13}" /F >NUL 2>&1
:: Extract All Context Menu for ZIP Files
REG DELETE "HKEY_CLASSES_ROOT\CompressedFolder\ShellEx\ContextMenuHandlers\{B8CDCB65-B1BF-4B42-9428-1DFDB7EE92AF}" /F >NUL 2>&1
:: Give Access To
::REG DELETE "HKEY_CLASSES_ROOT\*\ShellEx\ContextMenuHandlers\Sharing" /F >NUL 2>&1
::REG DELETE "HKEY_CLASSES_ROOT\Directory\Background\ShellEx\ContextMenuHandlers\Sharing" /F >NUL 2>&1
::REG DELETE "HKEY_CLASSES_ROOT\Directory\ShellEx\ContextMenuHandlers\Sharing" /F >NUL 2>&1
::REG DELETE "HKEY_CLASSES_ROOT\Drive\ShellEx\ContextMenuHandlers\Sharing" /F >NUL 2>&1
::REG DELETE "HKEY_CLASSES_ROOT\LibraryFolder\background\ShellEx\ContextMenuHandlers\Sharing" /F >NUL 2>&1
::REG DELETE "HKEY_CLASSES_ROOT\UserLibraryFolder\ShellEx\ContextMenuHandlers\Sharing" /F >NUL 2>&1
:: Include in Libraries
REG DELETE "HKEY_CLASSES_ROOT\Folder\ShellEx\ContextMenuHandlers\Library Location" /F >NUL 2>&1
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\ShellEx\ContextMenuHandlers\Library Location" /F >NUL 2>&1
:: ISO Burn
REG DELETE "HKEY_CLASSES_ROOT\Windows.IsoFile\Shell\Burn" /F >NUL 2>&1
:: Login Without Password in "control userpasswords2" or netplwiz
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device" /V "DevicePasswordLessBuildVersion" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Meet Now
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "HideSCAMeetNow" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "HideSCAMeetNow" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Msi Extract
REG ADD "HKEY_CLASSES_ROOT\Msi.Package\Shell\Extract" /VE /T REG_SZ /D "Extract MSI" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\Msi.Package\Shell\Extract" /V "NeverDefault" /T REG_SZ /D "" /F >NUL 2>&1
REG ADD "HKEY_CLASSES_ROOT\Msi.Package\Shell\Extract\Command" /VE /T REG_SZ /D "msiexec.exe /a "%1" /qb TARGETDIR="%1 Contents"" /F >NUL 2>&1
:: 'New' Menu
REG DELETE "HKEY_CLASSES_ROOT\.contact\ShellNew" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\.library-ms\ShellNew" /F >NUL 2>&1
::REG DELETE "HKEY_CLASSES_ROOT\Folder\ShellEx\ContextMenuHandlers\Library Location" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\.rtf\ShellNew" /F >NUL 2>&1
:: Number of Selections on Explorer
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "MultipleInvokePromptMinimum" /T REG_DWORD /D "200" /F >NUL 2>&1
:: Pin to Quick Access
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\Shell\PinToHome" /F >NUL 2>&1
:: Previous Versions (File History Properties Tab)
REG DELETE "HKEY_CLASSES_ROOT\AllFilesystemObjects\ShellEx\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\ShellEx\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\Directory\ShellEx\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\Drive\ShellEx\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
:: Previous Versions (File History Context Menu)
REG DELETE "HKEY_CLASSES_ROOT\AllFilesystemObjects\ShellEx\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\ShellEx\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\Directory\ShellEx\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\Drive\ShellEx\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /F >NUL 2>&1
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
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoStartBanner" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\batfile\shell\runasuser" /V "SuppressionPolicy" /T REG_DWORD /D "4096" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\cmdfile\shell\runasuser" /V "SuppressionPolicy" /T REG_DWORD /D "4096" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\exefile\shell\runasuser" /V "SuppressionPolicy" /T REG_DWORD /D "4096" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\mscfile\shell\runasuser" /V "SuppressionPolicy" /T REG_DWORD /D "4096" /F >NUL 2>&1


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
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /V "AllowMUUpdateService" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /V "AutoInstallMinorUpdates" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /V "NoAutoRebootWithLoggedOnUsers" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Windows Store Automatic Updates
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /V "AutoDownload" /T REG_DWORD /D "2" /F >NUL 2>&1
:: Drivers Update
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /V "PreventDeviceMetadataFromNetwork" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" /V "PreventDeviceMetadataFromNetwork" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Default\Update\ExcludeWUDriversInQualityUpdate" /V "Value" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /V "ExcludeWUDriversInQualityUpdate" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Other MS Products Update
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Services\7971F918-A847-4430-9279-4A52D1EFE18D" /V "RegisteredWithAU" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Maps
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\Maps" /V "AutoUpdateEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps" /V "AutoDownloadAndUpdateMapData" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Maps" /V "AllowUntriggeredNetworkTrafficOnSettingsPage" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Delivery Optimization
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /V "DODownloadMode" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /V "DODownloadMode" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_USERS\S-1-5-20\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /V "DownloadMode" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /V "SystemSettingsDownloadMode" /T REG_DWORD /D "0" /F >NUL 2>&1
:::::::: Windows Security
:: Windows Defender
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender" /V "DisableAntiVirus" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features" /V "TamperProtection" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" /V "SubmitSamplesConsent" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows Security Health\State" /V "AccountProtection_MicrosoftAccount_Disconnected" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows Security Health\State" /V "AppAndBrowser_StoreAppsSmartScreenOff" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /V "DontOfferThroughWUAU" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /V "DontReportInfectionInformation" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" /V "DisableEnhancedNotifications" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" /V "DisableNotifications" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Virus and Threat Protection" /V "SummaryNotificationDisabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" /V "MpEnablePus" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /V "DisableGenericReports" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /V "CheckForSignaturesBeforeRunningScan" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" /V "DisableBlockAtFirstSeen" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" /V "LocalSettingOverrideSpyNetReporting" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" /V "SpyNetReporting" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" /V "SpyNetReportingLocation" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Network Protection
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Network Protection" /V "EnableNetworkProtection" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Core Isolation / Device Guard
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /V "EnableVirtualizationBasedSecurity" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /V "HypervisorEnforcedCodeIntegrity" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /V "RequirePlatformSecurityFeatures" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard" /V "Locked" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /V "Enabled" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /V "Locked" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /V "LsaCfgFlags" /T REG_DWORD /D "1" /F >NUL 2>&1

BCDEDIT /SET HYPERVISORSCHEDULERTYPE CORE >NUL 2>&1

:: Application Guard
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppHVSI" /V "AllowAppHVSI_ProviderSet" /T REG_DWORD /D "3" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppHVSI" /V "BlockNonEnterpriseContent" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppHVSI" /V "AllowCameraMicrophoneRedirection" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppHVSI" /V "AllowPersistence" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppHVSI" /V "AllowVirtualGPU" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppHVSI" /V "AuditApplicationGuard" /T REG_DWORD /D "0" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppHVSI" /V "SaveFilesToHost" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppHVSI" /V "FileTrustCriteria" /T REG_DWORD /D "2" /F >NUL 2>&1
:: SmartScreen
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "EnableSmartScreen" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /V "ContentEvaluation" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /V "EnableWebContentEvaluation" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "SmartScreenEnabled" /T REG_SZ /D "On" /F >NUL 2>&1
:: Boot-Start Driver Initialization Policy
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Policies\EarlyLaunch" /V "DriverLoadPolicy" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Windows Insider Program
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Current\Device\System" /V "AllowExperimentation" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Default\System\AllowExperimentation" /V "Value" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /V "HideInsiderPage" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /V "HideInsiderPage" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX" /V "InsiderProgramEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /V "AllowBuildPreview" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /V "EnableConfigFlighting" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /V "EnableExperimentation" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /V "InsiderProgramEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /V "ManagePreviewBuilds" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /V "ManagePreviewBuildsPolicyValue" /T REG_DWORD /D "0" /F >NUL 2>&1
:: License Telemetry
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" /V "NoGenTicket" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /V "NoGenTicket" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" /V "AllowWindowsEntitlementReactivation" /T REG_DWORD /D "1" /F >NUL 2>&1


ECHO :::::::: Windows Search, Cortana, Indexing/Prefetch
TASKLIST | FIND /I "SearchUI.exe" /F >NUL 2>&1 && TASKKILL /F /IM SearchUI.exe >NUL 2>&1
IF EXIST "%SYSTEMROOT%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy" RD /S /Q "%SYSTEMROOT%\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy" /F >NUL 2>&1
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Cortana.exe" /V "Debugger" /T REG_SZ /D "%SYSTEMROOT%\System32\taskkill.exe" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Search\Gather\Windows\SystemIndex" /V "EnableFindMyFiles" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ShowCortanaButton" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "AllowSearchToUseLocation" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "BingSearchEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "CanCortanaBeEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "CortanaConsent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "CortanaEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "CortanaInAmbientMode" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "CortanaSpeechAllowedOverLockScreen" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "DeviceHistoryEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "HasCortanaBeenEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "HistoryViewEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "SearchboxTaskbarMode" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /V "VoiceShortcut" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Windows Search" /V "CortanaConsent" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "AllowCloudSearch" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "AllowCortana" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "AllowCortanaAboveLock" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "AllowCortanaInAAD" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "AllowCortanaInAADPathOOBE" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "AllowIndexingEncryptedStoresOrItems" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "AllowSearchToUseLocation" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "AlwaysUseAutoLangDetection" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "AutoIndexSharedFolders" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "BingSearchEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "ConnectedSearchPrivacy" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "ConnectedSearchSafeSearch" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "ConnectedSearchUseWeb" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "ConnectedSearchUseWebOverMeteredConnections" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "DisableBackoff" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "DisableRemovableDriveIndexing" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "DisableWebSearch" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "EnableIndexingDelegateMailboxes" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "PreventIndexingEmailAttachments" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "PreventIndexingLowDiskSpaceMB" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "PreventIndexingOfflineFiles" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "PreventIndexingOutlook" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "PreventIndexingPublicFolders" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "PreventIndexingUncachedExchangeFolders" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "PreventIndexOnBattery" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "PreventRemoteQueries" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "PreventUnwantedAddIns" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /V "PreventUsingAdvancedIndexingOptions" /T REG_DWORD /D "1" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /V "IsAADCloudSearchEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /V "IsDeviceSearchHistoryEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /V "IsMSACloudSearchEnabled" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" /V "SafeSearchMode" /T REG_DWORD /D "0" /F >NUL 2>&1
:: Search Companion
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SearchCompanion" /V "DisableContentFileUpdates" /T REG_DWORD /D "1" /F >NUL 2>&1
:: Prefetch
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /V "EnableBootTrace" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /V "EnablePrefetcher" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /V "EnableSuperfetch" /T REG_DWORD /D "0" /F >NUL 2>&1

:::::::: Settings Control Panel Clean-Up
::REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "SettingsPageVisibility" /T REG_SZ /D "hide:gaming-broadcasting;gaming-gamebar;gaming-gamedvr;gaming-gamemode;gaming-xboxnetworking;holographic-audio;holographic-headset;holographic-management;privacy-holographic-environment;maps;mobile-Devices;remotedesktop;windowsinsider" /F >NUL 2>&1


:::: AutoLogger
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /V "Start" /T REG_DWORD /D "0" /F >NUL 2>&1


ECHO :::::::: Scheduled Tasks
::SCHTASKS /CHANGE /DISABLE /TN "MicrosoftEdgeUpdateTaskMachineCore" >NUL 2>&1
::SCHTASKS /CHANGE /DISABLE /TN "MicrosoftEdgeUpdateTaskMachineUA" >NUL 2>&1
::SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" >NUL 2>&1
::SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\PI\Secure-Boot-Update" >NUL 2>&1
::SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\PI\Sqm-Tasks" >NUL 2>&1
::SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" >NUL 2>&1
::SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\PushToInstall\Registration" >NUL 2>&1
::SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\RecoveryEnvironment\VerifyWinRE" >NUL 2>&1
::SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Setup\SetupCleanupTask" >NUL 2>&1
::SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Sysmain\WsSwapAssessmentTask" >NUL 2>&1
::SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\TPM\Tpm-HASCertRetr" >NUL 2>&1
::SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\TPM\Tpm-Maintenance" >NUL 2>&1
::SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\WCM\WifiTask" >NUL 2>&1
::SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\WDI\ResolutionHost" >NUL 2>&1
::SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Wininet\CacheTask" >NUL 2>&1
::SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\WlanSvc\CDSSync" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Active Directory Rights Management Services Client\AD RMS Rights Policy Template Management (Automated)" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Active Directory Rights Management Services Client\AD RMS Rights Policy Template Management (Manual)" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\AppID\EDP Policy Manager" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\AppID\SmartScreenSpecific" >NUL 2>&1
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
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\ApplicationData\appuriverifierdaily" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\ApplicationData\appuriverifierinstall" >NUL 2>&1
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
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Device Information\Device User" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Device Information\Device" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Device User" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Device" >NUL 2>&1
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
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Flighting\OneSettings\RefreshCache" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\HelloFace\FODCleanupTask" >NUL 2>&1
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
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Management\Provisioning\MdmDiagnosticsCleanup" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Maps\MapsToastTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Maps\MapsUpdateTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Mobile Broadband Accounts\MNO Metadata Parser" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\NlaSvc\WifiTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Offline Files\Synchronization" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\PerfTrack\BackgroundConfigSurveyor" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\PushToInstall\LoginCheck" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Ras\MobilityManager" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\RetailDemo\CleanupOfflineContent" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\SettingSync\BackgroundUploadTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\SettingSync\BackgroundUploadTaskDisabled" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\SettingSync\BackupTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\SettingSync\NetworkStateChangeTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\SetupSQMTask" >NUL 2>&1
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
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Task Manager\Interactive" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\TextServicesFramework\MsCtfMonitor" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\WS\WSTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Windows Error Reporting\QueueReportingDisabled" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\Windows Media Sharing\UpdateLibrary" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\WwanSvc\NotificationTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Windows\WwanSvc\OobeDiscovery" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\XblGameSave\Xbgm" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\XblGameSave\XblGameSaveTask" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\XblGameSave\XblGameSaveTaskLogon" >NUL 2>&1
::SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Office\Office Automatic Updates 2.0" >NUL 2>&1
::SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Office\Office Feature Updates Logon" >NUL 2>&1
::SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Office\Office Feature Updates" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Office\Office ClickToRun Service Monitor" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Office\OfficeTelemetryAgentFallBack2016" >NUL 2>&1
SCHTASKS /CHANGE /DISABLE /TN "Microsoft\Office\OfficeTelemetryAgentLogOn2016" >NUL 2>&1


ECHO :::::::: Services
::for /D%%G in (CertPropSvc,CDPSvc,CDPUserSvc,CscService,DiagTrack,DoSvc,DevicesFlow,DevicesFlowUserSvc,DevQueryBroker,DsmSvc,DusmSvc,DPS,diagnosticshub.standardcollector.service,dmwappushservice,MapsBroker,MessagingService,OneSyncSvc,PimIndexMaintenanceSvc,PrintWorkflowUserSvc,PcaSvc,RemoteRegistry,SmsRouter,Spooler,TrkWks,StiSvc,SecurityHealthService,Sense,UnistoreSvc,UserDataSvc,WpnUserService,WerSvc,WMPNetworkSvc,WSearch,WdNisDrv,WdNisSvc,WinDefend) do (
::sc Config %%G start= disabled )
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CertPropSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\CredentialEnrollmentManagerUserSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Customer Experience Improvement Program\Consolidator" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Customer Experience Improvement Program\KernelCeipTask" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Customer Experience Improvement Program\UsbCeip" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DeviceAssociationBrokerSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DiagSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DiagTrack" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HelloFace\FODCleanupTask" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MapsBroker" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Maps\MapsToastTask" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Maps\MapsUpdateTask" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MessagingService" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MsLldp" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Ndu" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBIOS" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetTCPPortSharing" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PhoneSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PrintWorkflowUserSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sense" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SensorDataService" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SgrmBroker" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SysMain" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UnistoreSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UserDataSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\idsvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\iphlpsvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mrxsmb" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mrxsmb10" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mrxsmb\Parameters" /V "RefuseReset" /T REG_DWORD /D "1" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ms_lltdio" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ms_msclient" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ms_pacer" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ms_rspndr" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\perceptionsimulation" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicguestinterface" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicheartbeat" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmickvpexchange" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicrdv" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicshutdown" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmictimesync" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicvmsession" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vmicvss" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
::REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wlidsvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\AJRouter" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ALG" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Application Experience\Microsoft Compatibility Appraiser" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Application Experience\ProgramDataUpdater" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Application Experience\StartupAppTask" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Clip\License Validation" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DmWapPushService" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DoSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DuSmSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EdgeUpdate" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EdgeUpdateM" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EntAppSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FDResPub" /V "Start" /T REG_DWORD /D "2" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManworkstation" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanServer" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MSiSCSI" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MixedRealityOpenXRSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NaturalAuthentication" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PcaSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ProfSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\QWave" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RemoteAccess" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RemoteRegistry" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RetailDemo" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SEMgrSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SHPamSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SMSRouter" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SNMPTRAP" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecLogon" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SessionEnv" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedRealitySvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Spectrum" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TabletInputService" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TermService" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UmRdpService" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WMPNetworkSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WSearch" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WbioSrvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WerSvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinRM" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WpcMonSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XblAuthManager" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XblGameSave" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XboxGipSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XboxGipSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XboxNetApiSvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\icssvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lfsvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wcncsvc" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wercplsupport" /V "Start" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wisvc" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\xbgm" /V "Start" /T REG_DWORD /D "4" /F >NUL 2>&1


:::: Microsoft Office
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\office\16.0\common\qmenable" /T REG_DWORD /D "0" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\office\common\clienttelemetry\sendtelemetry" /T REG_DWORD /D "3" /F >NUL 2>&1
REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\office\16.0\common\sendcustomerdata" /T REG_DWORD /D "0" /F >NUL 2>&1


ECHO. & ECHO Tweaks Have Been Completed Successfully.
ECHO. & ECHO ADDitionally you can run a script to remove unnecessary Windows Features and Windows UWP Applications.
CHOICE /T 15 /C YN /D N /M "Would you like to REMOVE these Features?"
IF %ERRORLEVEL%==1 (GOTO :Bloatware) ELSE (GOTO :Reboot)

:Reboot
ECHO. & ECHO Your SYSTEM needs to reboot for changes to take effect. & choice.exe /T 15 /C YN /D N /M "Would you like to REBOOT now?"
IF %ERRORLEVEL%==1 (SHUTDOWN /R /F /D P:4:1 /T 5 /C "Windows 10 C-OL - Custom Tweaks Collection Script") ELSE (CALL EXPLORER.EXE)
GOTO :EOF

:Bloatware
ECHO. & ECHO NOTICE: It can take some time while all Features are been removed. & ECHO.
ECHO :::::::: Windows Capabilities
::PowerShell -Command "Get-WindowsCapability -Online -Name "Language.Basicen-US*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
::PowerShell -Command "Get-WindowsCapability -Online -Name "Media.WindowsMediaPlayer~0.0.12.0 >NUL 2>&1
::PowerShell -Command "Get-WindowsCapability -Online -Name "Microsoft.Windows.MSPaint*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
::PowerShell -Command "Get-WindowsCapability -Online -Name "Microsoft.Windows.Notepad*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
::PowerShell -Command "Get-WindowsCapability -Online -Name "Microsoft.Windows.PowerShell.ISE*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
::PowerShell -Command "Get-WindowsCapability -Online -Name "Rsat.ServerManager.Tools*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
::PowerShell -Command "Get-WindowsCapability -Online -Name "RSAT.ActiveDirectory.DS-LDS.Tools*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
::PowerShell -Command "Get-WindowsCapability -Online -Name "Windows.Client.ShellComponents*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "Analog.Holographic.Desktop*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "App.StepsRecorder*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "App.Support.QuickAssist*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "Browser.InternetExplorer*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "Hello.Face*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "Language.Handwritingen-US*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "Language.OCRen-US*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "Language.Speechen-US*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "Language.TextToSpeechen-US*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "MathRecognizer*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "Microsoft.Windows.PowerShell.ISE*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "Microsoft.Windows.WordPad*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "OneCoreUAP.OneSync*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "OpenSSH.Client*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "OpenSSH.Server*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "Print.Fax.Scan*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "RSAT*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "RSAT.ActiveDirectory.DS-LDS.Tools*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "RSAT.ServerManager.Tools*" | Remove-WindowsCapability -Online" /F >NUL 2>&1
PowerShell -Command "Get-WindowsCapability -Online -Name "XPS.Viewer*" | Remove-WindowsCapability -Online" /F >NUL 2>&1

ECHO :::::::: Windows Features
::PowerShell -Command "Get-WindowsOptionalFeature -Online | select featurename"
:: Disable-WindowsOptionalFeature -Remove -Online = Removes Payload from Disk
::PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "SearchEngine-Client-Package" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
::PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
::PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "MediaPlayback*" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "*Hyper-V*" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "Internet-Explorer*" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "Client-ProjFS" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "DirectPlay*" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "FaxServicesClientPackage" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "HypervisorPlatform" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "IIS*" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "LegacyComponents*" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "MicrosoftWindowsPowerShellV2*" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "MSMQ*" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "MSRDC*" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "NetFx3*" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "NetFx4-AdvSrvs" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "NetFx4Extended-ASPNET45" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "Printing-Foundation*" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "Printing-XPSServices*" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "ScanManagementConsole" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "SimpleTCP" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol*" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "TelnetClient" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "TFTP" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "TIFFIFilter" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "VirtualMachinePlatform" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "WAS*" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "WCF*" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "Windows-Identity-Foundation" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "WorkFolders-Client" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1
PowerShell -Command "Get-WindowsOptionalFeature -Online -FeatureName "XPS-Foundation-XPS-Viewer" | Disable-WindowsOptionalFeature -Online -NoRestart" /F >NUL 2>&1

ECHO :::::::: Windows UWP Applications
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.3DBuilder* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.549981C3F5F10* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Advertising.Xaml* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Appconnector* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.BingFinance* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.BingFoodAndDrink* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.BingHealthAndFitness* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.BingMaps* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.BingNews* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.BingSports* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.BingTranslator* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.BingTravel* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.BingWeather* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.CommsPhone* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.ConnectivityStore* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.FreshPaint* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.GetHelp* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.GetStarted* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Groove* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.HelpAndTips* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Media.PlayReadyClient* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Messaging* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Microsoft3DViewer* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.MicrosoftEdge* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.MicrosoftEdgeDevToolsClient* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.MicrosoftPowerBIForWindows* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.MixedReality.Portal* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.MSPaint* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Office.OneNote* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Office.Sway* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.OfficeLens* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.OneConnect* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.People* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Print3D* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Reader* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.RemoteDesktop* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.ScreenSketch* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.SkypeApp* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Todos* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Wallet* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Whiteboard* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.windowscommunicationsapps* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.WindowsMaps* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.WindowsPhone* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.WindowsReadingList* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.WindowsScan* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.WindowsSoundRecorder* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.WinJS.1.0* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.WinJS.2.0* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.Xbox.TCUI* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.XboxApp* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.XboxGamingOverlay* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.XboxIdentityProvider* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.XboxSpeechToTextOverlay* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.YourPhone* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.ZuneMusic* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *Microsoft.ZuneVideo* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
PowerShell -Command "Get-AppXPackage -AllUsers *XboxOneSmartGlass* | Remove-AppxPackage -AllUsers" /F >NUL 2>&1
ECHO :::::::: Windows UWP Provisioned Applications
::PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WebMediaExtensions*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
::PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Windows.Photos*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
::PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WindowsAlarms*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
::PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WindowsCamera*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.3DBuilder*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.549981C3F5F10*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Advertising.Xaml*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Appconnector*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.BingFinance*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.BingFoodAndDrink*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.BingHealthAndFitness*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.BingMaps*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.BingNews*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.BingSports*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.BingTranslator*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.BingTravel*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.BingWeather*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.CommsPhone*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.ConnectivityStore*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.FreshPaint*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.GetHelp*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.GetStarted*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Groove*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.HelpAndTips*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Media.PlayReadyClient*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Messaging*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Microsoft3DViewer*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.MicrosoftEdge*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.MicrosoftEdgeDevToolsClient*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.MicrosoftOfficeHub*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.MicrosoftPowerBIForWindows*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.MicrosoftSolitaireCollection*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.MicrosoftStickyNotes*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.MixedReality.Portal*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.MSPaint*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Office.OneNote*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Office.Sway*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.OfficeLens*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.OneConnect*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.People*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Print3D*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Reader*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.RemoteDesktop*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.ScreenSketch*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.SkypeApp*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Todos*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Wallet*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Whiteboard*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.windowscommunicationsapps*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WindowsFeedbackHub*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WindowsMaps*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WindowsPhone*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WindowsReadingList*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WindowsScan*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WindowsSoundRecorder*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WinJS.1.0*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.WinJS.2.0*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.Xbox.TCUI*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.XboxApp*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.XboxGamingOverlay*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.XboxIdentityProvider*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.XboxSpeechToTextOverlay*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.YourPhone*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.ZuneMusic*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*Microsoft.ZuneVideo*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
PowerShell -Command "Get-AppXProvisionedPackage -Online | Where-Object {$_.PackageName -Like '*XboxOneSmartGlass*'} | Remove-AppXProvisionedPackage -Online" /F >NUL 2>&1
GOTO :Reboot

:EOF
EXIT
