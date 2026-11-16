# Installer

Erzeugt eine `Setup.exe` für die PC-Software. Die Anwendung wird als eigenständiges
Release gebaut (self-contained), läuft also **ohne installiertes .NET**.

## Voraussetzung

[Inno Setup](https://jrsoftware.org/isdl.php) installieren, z. B.:

```bash
winget install JRSoftware.InnoSetup
```

Der CR95HF meldet sich als USB-CDC (virtueller COM-Port) über den in Windows 10/11
enthaltenen Treiber `usbser.sys`. Ein zusätzlicher Treiber ist nicht nötig.

## Bauen

```bash
dotnet publish nfc-cr95hf/pc -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true
```

```bash
"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" nfc-cr95hf/installer/Cr95hfTool.iss
```

Die fertige `CR95HF-NFC-Tool-Setup.exe` liegt danach in `nfc-cr95hf/installer/Output/`.
Sie installiert das Programm nach `Programme`, legt Startmenü- und optional eine
Desktop-Verknüpfung an und bringt einen Deinstaller mit.
