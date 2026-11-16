; Inno Setup Skript für das CR95HF NFC-Tool (MB1054A).
; Baut eine Setup.exe aus dem eigenständigen Release (self-contained, kein .NET nötig).
;
; Vorher einmalig das Release erzeugen:
;   dotnet publish ..\pc -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true
; Dann diese Datei mit Inno Setup öffnen und "Compile", oder:
;   "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" Cr95hfTool.iss

#define AppName "CR95HF NFC-Tool"
#define AppVersion "1.0"
#define AppExe "Cr95hfTool.exe"
#define Publisher "wikischwemler"
#define PublishDir "..\pc\bin\Release\net10.0-windows\win-x64\publish"

[Setup]
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher={#Publisher}
DefaultDirName={autopf}\CR95HF NFC-Tool
DefaultGroupName=CR95HF NFC-Tool
UninstallDisplayIcon={app}\{#AppExe}
OutputBaseFilename=CR95HF-NFC-Tool-Setup
Compression=lzma2
SolidCompression=yes
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
PrivilegesRequired=admin
WizardStyle=modern

[Languages]
Name: "de"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
Source: "{#PublishDir}\{#AppExe}"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExe}"
Name: "{group}\{cm:UninstallProgram,{#AppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExe}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#AppExe}"; Description: "{cm:LaunchProgram,{#AppName}}"; Flags: nowait postinstall skipifsilent
