#!/usr/bin/env bash

# Night modern aesthetic clipboard picker with inline thumbnail preview
THEME_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/clipboard.rasi"
CACHE_DIR="/tmp/cliphist_thumbs"
TEXT_ICON="$HOME/dotfiles-sj/rofi/icons/text.png"

mkdir -p "$CACHE_DIR"

# Generate list with 40x40 thumbnails
# Binary image data entries get decoded once and cached in /tmp/cliphist_thumbs (in RAM tmpfs)
feed_rofi() {
    cliphist list | while IFS= read -r line; do
        if [[ "$line" =~ ^([0-9]+)[[:space:]]+binary[[:space:]]+data ]]; then
            id="${BASH_REMATCH[1]}"
            thumb="$CACHE_DIR/${id}.png"
            if [[ ! -f "$thumb" ]]; then
                printf "%s\n" "$line" | cliphist decode > "$thumb" 2>/dev/null
            fi
            printf "%s\0icon\x1f%s\n" "$line" "$thumb"
        else
            printf "%s\0icon\x1f%s\n" "$line" "$TEXT_ICON"
        fi
    done
}

selected_row_arg=()

while true; do
    selected=$(feed_rofi | rofi -dmenu -i \
        -matching fuzzy \
        -sorting-method fzf \
        -theme "$THEME_PATH" \
        -p "📋 Clipboard" \
        -show-icons \
        -kb-custom-1 "Alt+Delete" \
        -kb-custom-2 "Control+p" \
        "${selected_row_arg[@]}")

    exit_code=$?

    case "$exit_code" in
        0)
            # Enter -> Copy selected item to clipboard and exit
            if [ -n "$selected" ]; then
                echo "$selected" | cliphist decode | wl-copy
            fi
            break
            ;;
        10)
            # Alt+Delete -> Remove from cliphist history, then re-open rofi at same position
            if [ -n "$selected" ]; then
                row_idx=$(cliphist list | grep -n -F "$selected" | head -n1 | cut -d: -f1)
                echo "$selected" | cliphist delete
                if [[ "$selected" =~ ^([0-9]+)[[:space:]] ]]; then
                    rm -f "$CACHE_DIR/${BASH_REMATCH[1]}.png"
                fi
                command -v notify-send >/dev/null && notify-send -u low "Clipboard" "Deleted entry from history"
                if [ -n "$row_idx" ] && [ "$row_idx" -gt 0 ]; then
                    selected_row_arg=(-selected-row "$((row_idx - 1))")
                else
                    selected_row_arg=()
                fi
            else
                break
            fi
            ;;
        11)
            # Control+p -> Open large image preview with eog, wait for close, then re-open rofi!
            if [ -n "$selected" ]; then
                # Copy to clipboard immediately
                echo "$selected" | cliphist decode | wl-copy

                # Remember current row so rofi returns to the exact same position
                row_idx=$(cliphist list | grep -n -F "$selected" | head -n1 | cut -d: -f1)
                if [ -n "$row_idx" ] && [ "$row_idx" -gt 0 ]; then
                    selected_row_arg=(-selected-row "$((row_idx - 1))")
                fi

                if [[ "$selected" =~ ^([0-9]+)[[:space:]]+binary[[:space:]]+data ]]; then
                    id="${BASH_REMATCH[1]}"
                    img_file="$CACHE_DIR/${id}.png"
                    if [[ ! -f "$img_file" ]]; then
                        echo "$selected" | cliphist decode > "$img_file" 2>/dev/null
                    fi
                    # Open with eog and wait until user closes/escapes the preview
                    eog -n "$img_file" >/dev/null 2>&1
                else
                    command -v notify-send >/dev/null && notify-send -u low "Clipboard" "Copied to clipboard (text entry)"
                fi
            else
                break
            fi
            ;;
        *)
            # Esc / click outside -> exit cleanly
            break
            ;;
    esac
done
