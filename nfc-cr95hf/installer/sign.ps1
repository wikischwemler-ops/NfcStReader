# Signiert App und Installer mit dem selbst-signierten Code-Signing-Zertifikat "CN=wikischwemler".
# Erstellt das Zertifikat beim ersten Lauf (10 Jahre gueltig) und exportiert den oeffentlichen Teil.
# Aufruf:  powershell -ExecutionPolicy Bypass -File sign.ps1
param(
    [string]$Subject = 'CN=wikischwemler',
    [string]$TimestampServer = 'http://timestamp.digicert.com'
)
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

$cert = Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert | Where-Object Subject -eq $Subject | Select-Object -First 1
if (-not $cert) {
    Write-Host "Erstelle Zertifikat $Subject ..."
    $cert = New-SelfSignedCertificate -Type CodeSigningCert -Subject $Subject -KeyUsage DigitalSignature `
        -FriendlyName 'wikischwemler Code Signing' -CertStoreLocation Cert:\CurrentUser\My `
        -KeyExportPolicy Exportable -KeyAlgorithm RSA -KeyLength 3072 -NotAfter (Get-Date).AddYears(10) -HashAlgorithm SHA256
    Export-Certificate -Cert $cert -FilePath (Join-Path $here 'wikischwemler-codesign.cer') -Force | Out-Null
}

$targets = @(
    (Resolve-Path (Join-Path $here '..\pc\bin\Release\net10.0-windows\win-x64\publish\Cr95hfTool.exe') -ErrorAction SilentlyContinue),
    (Join-Path $here 'Output\CR95HF-NFC-Tool-Setup.exe')
) | Where-Object { $_ -and (Test-Path $_) }

foreach ($t in $targets) {
    $r = Set-AuthenticodeSignature -FilePath $t -Certificate $cert -TimestampServer $TimestampServer -HashAlgorithm SHA256
    "{0,-12} {1}" -f $r.Status, (Split-Path $t -Leaf)
}
Write-Host "`nHinweis: Status 'UnknownError' heisst nur, dass dieser PC dem Zertifikat noch nicht vertraut."
Write-Host "Zum Vertrauen auf eigenen PCs (Admin-PowerShell):"
Write-Host "  Import-Certificate -FilePath wikischwemler-codesign.cer -CertStoreLocation Cert:\LocalMachine\Root"
Write-Host "  Import-Certificate -FilePath wikischwemler-codesign.cer -CertStoreLocation Cert:\LocalMachine\TrustedPublisher"
