# SSL Certificates

This folder must contain your SSL certificates for HTTPS:

- `cert.pem` — SSL certificate
- `key.pem` — Private key

## Option 1: Generate self-signed cert (local / home network)

**Windows (PowerShell):**

```powershell
# From the project root:
.\generate-certs.ps1
```

The script looks for OpenSSL in your PATH or in Git for Windows (`C:\Program Files\Git\usr\bin\`). If you don't have OpenSSL, install [Git for Windows](https://git-scm.com) or use [WSL](https://learn.microsoft.com/en-us/windows/wsl/) and run the bash script instead.

**Linux / Mac / WSL / Git Bash:**

```bash
./generate-certs.sh
```

Or manually with OpenSSL:

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout certs/key.pem -out certs/cert.pem \
  -subj "/CN=localhost"
```

## Option 2: Use your own certificates

Place your `cert.pem` and `key.pem` in this folder.  
(e.g. from Let's Encrypt, your domain provider, etc.)
