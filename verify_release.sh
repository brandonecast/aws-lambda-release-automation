#!/bin/bash
set -e

URL=$1
EXPECTED_VERSION=$2

if [ -z "$URL" ] || [ -z "$EXPECTED_VERSION" ]; then
  echo "Usage: $0 <url> <expected_version>"
  exit 1
fi

echo "[*] Checking /health ..."
curl -s ${URL}/health

echo "[*] Checking /version ..."
RESPONSE=$(curl -s ${URL}/version)
echo "Response: $RESPONSE"

if echo "$RESPONSE" | grep -q "$EXPECTED_VERSION"; then
  echo "[✓] Release verification passed."
else
  echo "[✗] Release verification failed."
  exit 1
fi
