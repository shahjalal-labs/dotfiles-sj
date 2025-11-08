#!/bin/bash

selected=$(cliphist list | rofi -dmenu -i -p "📋 Clipboard" | cut -d' ' -f1)

if [[ -n "$selected" ]]; then
  cliphist decode "$selected" | wl-copy --type text/plain
  # notify-send "✅ Copied to clipboard"
fi
