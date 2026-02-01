#!/bin/bash
# Generate self-signed SSL certificate for n8n HTTPS
# Run from project root: ./generate-certs.sh

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CERTS="$DIR/certs"

mkdir -p "$CERTS"

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "$CERTS/key.pem" -out "$CERTS/cert.pem" \
  -subj "/CN=localhost"

echo "Done! Created cert.pem and key.pem in certs/"
