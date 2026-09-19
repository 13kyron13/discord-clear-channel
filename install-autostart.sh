#!/bin/bash

set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
LABEL="com.user.discordclear"
PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"

if [ ! -f "$DIR/.env" ]; then
  echo "ERROR: .env not found in $DIR"
  echo "Copy .env.example to .env and add your bot settings first."
  exit 1
fi

mkdir -p "$HOME/Library/LaunchAgents"

cat > "$PLIST" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>$LABEL</string>
  <key>ProgramArguments</key>
  <array>
    <string>$DIR/run.sh</string>
  </array>
  <key>WorkingDirectory</key>
  <string>$DIR</string>
  <key>RunAtLoad</key>
  <true/>
  <key>KeepAlive</key>
  <true/>
  <key>StandardOutPath</key>
  <string>$DIR/out.log</string>
  <key>StandardErrorPath</key>
  <string>$DIR/err.log</string>
</dict>
</plist>
PLIST

chmod +x "$DIR/run.sh"

launchctl bootout "gui/$(id -u)" "$PLIST" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$PLIST"

echo "Discord auto-clear bot installed and started."
echo "Logs:"
echo "  $DIR/out.log"
echo "  $DIR/err.log"
