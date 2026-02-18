# n8n + HTTPS (nginx reverse proxy)

Run n8n with HTTPS using nginx as a reverse proxy. Works on localhost or your home network.

## Prerequisites

- Docker & Docker Compose
- SSL certificates in `certs/` (see below)

## Quick start

### 1. Generate or add SSL certificates

You need `cert.pem` and `key.pem` in the `certs/` folder.

**Self-signed (local / home network):**

```powershell
# Windows (requires Git for Windows or OpenSSL - script auto-detects Git's OpenSSL)
.\generate-certs.ps1
```

```bash
# Linux / Mac / WSL
chmod +x generate-certs.sh
./generate-certs.sh
```

**Windows without Git?** Use [WSL](https://learn.microsoft.com/en-us/windows/wsl/) and run the bash script above.

See `certs/CERTSREADME.md` for more options (Let's Encrypt, etc.).

### 2. Set your hostname (optional)

Create a `.env` file from the example:

```bash
cp .env.example .env
```

Edit `.env` and set `N8N_HOST` and `WEBHOOK_URL` to how you'll access n8n:

- **localhost only:** `N8N_HOST=localhost` (default)
- **Home network:** `N8N_HOST=your-pc-name` or `N8N_HOST=192.168.1.100`

### 3. Run

```bash
docker compose up -d
```

- **HTTPS:** https://localhost (or https://your-hostname)
- **HTTP:** http://localhost → redirects to HTTPS
- **Direct n8n:** http://localhost:5678 (bypasses nginx)

## Files

| File | Purpose |
|------|---------|
| `docker-compose.yml` | n8n + nginx services |
| `nginx.conf` | Reverse proxy, SSL, HTTP→HTTPS redirect |
| `certs/` | Put `cert.pem` and `key.pem` here |
| `.env` | Override `N8N_HOST` and `WEBHOOK_URL` |

## Notes

- Self-signed certs: browsers will show a security warning—click through or add an exception.
- For webhooks from external services, use a hostname/IP they can reach (e.g. your public IP or a domain with port forwarding).
- Ensure your hostname resolves: add it to `/etc/hosts` (or `C:\Windows\System32\drivers\etc\hosts`) or use your machine's IP.
