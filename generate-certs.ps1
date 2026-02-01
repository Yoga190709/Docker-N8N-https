# Generate self-signed SSL certificate for n8n HTTPS
# Run from project root: .\generate-certs.ps1

$certsDir = Join-Path $PSScriptRoot "certs"
$certPath = Join-Path $certsDir "cert.pem"
$keyPath = Join-Path $certsDir "key.pem"

if (-not (Test-Path $certsDir)) {
    New-Item -ItemType Directory -Path $certsDir | Out-Null
}

# Find OpenSSL (PATH, or Git for Windows)
$openssl = Get-Command openssl -ErrorAction SilentlyContinue
if (-not $openssl) {
    $gitPaths = @(
        "$env:ProgramFiles\Git\usr\bin\openssl.exe",
        "${env:ProgramFiles(x86)}\Git\usr\bin\openssl.exe"
    )
    foreach ($p in $gitPaths) {
        if (Test-Path $p) { $openssl = $p; break }
    }
}
$opensslExe = if ($openssl -is [string]) { $openssl } elseif ($openssl) { $openssl.Source } else { $null }

if (-not $opensslExe) {
    Write-Host "OpenSSL not found." -ForegroundColor Red
    Write-Host "Options:" -ForegroundColor Yellow
    Write-Host "  1. Install Git for Windows (https://git-scm.com) - includes OpenSSL, then run again"
    Write-Host "  2. Install OpenSSL (https://slproweb.com/products/Win32OpenSSL.html)"
    Write-Host "  3. Use WSL or run generate-certs.sh in Git Bash"
    exit 1
}

& $opensslExe req -x509 -nodes -days 365 -newkey rsa:2048 `
    -keyout $keyPath -out $certPath `
    -subj "/CN=localhost"

Write-Host "Done! Created cert.pem and key.pem in certs/" -ForegroundColor Green
