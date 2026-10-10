#!/bin/sh
# Re-renders the share images from the HTML sources in this folder (needs Google Chrome on macOS).
# Run from the repository root: sh marketing/src/render.sh
set -e
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
SRC="$(cd "$(dirname "$0")" && pwd)"
TMP="$(mktemp -d)"

shot() { # html, width, height, output.jpg
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 \
    --virtual-time-budget=5000 --window-size="$2,$3" --screenshot="$TMP/shot.png" "file://$SRC/$1" 2>/dev/null
  sips -s format jpeg -s formatOptions 88 "$TMP/shot.png" --out "$4" >/dev/null
}

shot og-image.html 1200 630 og-image.jpg
shot whatsapp-status.html 1080 1920 marketing/whatsapp-status-1080x1920.jpg
rm -rf "$TMP"
echo "Rendered og-image.jpg and marketing/whatsapp-status-1080x1920.jpg"
