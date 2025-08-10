## 🌲 Full Project Structure (cwd)

```bash
/home/sj/.config/ranger
├── commands.py
├── keybindings
│   └── navigation.conf
├── rc.conf
├── scope.sh
└── structure.md

2 directories, 5 files
```

## 📁 Target Module Tree (ranger)

```bash
/home/sj/.config/ranger
├── commands.py
├── keybindings
│   └── navigation.conf
├── rc.conf
├── scope.sh
└── structure.md

2 directories, 5 files
```

## 📄 Module Files & Contents

### `keybindings/navigation.conf`

```conf
# =====================================
# PROJECT-SPECIFIC NAVIGATION
# =====================================
# Learning projects

# Method 1: Using eval with fm.cd() - Direct navigation
map xt eval fm.cd('/run/media/sj/developer/web/L1B11/1-amr-day-record/sessions/July25')
map xl eval fm.cd('/run/media/sj/developer/web/L1B11')
map xa eval fm.cd('/run/media/sj/developer/web/L1B11/screenshots')
map xi eval fm.cd('/run/media/sj/developer/web/L1B11/4-mi-js/23-mo-javaScript-simple-coding-problems-part-2/js-problems-part2/pr/.s8cr8tN8w/ss/bestImage')
map xk eval fm.cd('/run/media/sj/developer/web/L1B6UpdatedTo9')
map xf eval fm.cd('/run/media/sj/developer/web/L2B4/frontend-track')

# Alternative Method 2: Using console with immediate execution
# map xst console cd /run/media/sj/developer/web/L1B11/1-amr-day-record/sessions/July25%key Return
# map xsl console cd /run/media/sj/developer/web/L1B11%key Return

# Batch shortcuts (can add more)
# map xb1 cd /run/media/sj/developer/web/L1B11
# map xb2 cd /run/media/sj/developer/web/L2B4
# map xb6 cd /run/media/sj/developer/web/L1B6UpdatedTo9
# Batch shortcuts (can add more)
# map xb1 cd /run/media/sj/developer/web/L1B11
# map xb2 cd /run/media/sj/developer/web/L2B4
# map xb6 cd /run/media/sj/developer/web/L1B6UpdatedTo9
#
```

### `structure.md`

````md
# 📁 Project Structure

```bash
.
├── commands.py
├── keybindings
│   └── navigation.conf
├── rc.conf
├── scope.sh
└── structure.md

2 directories, 5 files
```
````

````

### `scope.sh`
```sh
#!/usr/bin/env bash

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

FILE_PATH="${1}"
PV_WIDTH="${2:-80}"
PV_HEIGHT="${3:-24}"
IMAGE_CACHE_PATH="${4}"
PV_IMAGE_ENABLED="${5:-False}"

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER="$(printf "%s" "${FILE_EXTENSION}" | tr '[:upper:]' '[:lower:]')"

# Handle different file types
handle_extension() {
    case "${FILE_EXTENSION_LOWER}" in
        ## Archive
        a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
        rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
            atool --list -- "${FILE_PATH}" && exit 5
            bsdtar --list --file "${FILE_PATH}" && exit 5
            exit 1;;

        ## Text/Code files (ADD THIS SECTION)
        js|jsx|ts|tsx|json|html|htm|css|scss|sass|less|vue|py|rb|go|rs|c|cpp|h|hpp|\
        java|php|sh|bash|zsh|fish|vim|lua|sql|yaml|yml|toml|ini|conf|config|\
        txt|md|markdown|rst|org|tex|log|xml|svg)
            # Syntax highlight if available
            if command -v highlight >/dev/null 2>&1; then
                highlight --replace-tabs=8 --out-format=ansi --style=pablo --force -- "${FILE_PATH}" && exit 5
            elif command -v bat >/dev/null 2>&1; then
                bat --style=numbers --color=always --pager=never -- "${FILE_PATH}" && exit 5
            fi
            # Fallback to cat
            cat "${FILE_PATH}" && exit 5
            exit 2;;

        ## PDF
        pdf)
            # Try to extract text
            pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | \
                fmt -w "${PV_WIDTH}" && exit 5
            # Fallback to image preview
            [ "$PV_IMAGE_ENABLED" = 'True' ] && \
                pdftoppm -f 1 -l 1 -scale-to-x 1920 -scale-to-y -1 -singlefile -jpeg -tiffcompression jpeg -- "${FILE_PATH}" "${IMAGE_CACHE_PATH%.*}" && \
                exit 6
            exit 1;;

        ## Video
        avi|mp4|wmv|dat|3gp|ogv|mkv|mpg|mpeg|vob|fl[icv]|m2v|mov|webm|ts|mts|m4v|r[am]|qt|divx|as[fx])
            # Thumbnail for video
            [ "$PV_IMAGE_ENABLED" = 'True' ] && \
                ffmpegthumbnailer -i "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}" -s 0 && \
                exit 6
            # Fallback to mediainfo
            mediainfo "${FILE_PATH}" && exit 5
            exit 1;;

        ## Audio
        aac|flac|m4a|mid|midi|mpa|mp2|mp3|ogg|wav|wma|wv|opus)
            mediainfo "${FILE_PATH}" && exit 5
            exit 1;;

        ## Image
        bmp|jpg|jpeg|png|gif|webp|tiff|tif|ico)
            [ "$PV_IMAGE_ENABLED" = 'True' ] && \
                exit 6  # Let ranger handle image display
            # Fallback to image info
            identify "${FILE_PATH}" && exit 5
            exit 1;;
    esac
}

handle_mime() {
    local mimetype="${1}"
    case "${mimetype}" in
        ## Text
        text/* | */xml | application/javascript | application/json)
            # Syntax highlight
            if command -v highlight >/dev/null 2>&1; then
                highlight --replace-tabs=8 --out-format=ansi --style=pablo --force -- "${FILE_PATH}" && exit 5
            elif command -v bat >/dev/null 2>&1; then
                bat --style=numbers --color=always --pager=never -- "${FILE_PATH}" && exit 5
            fi
            # Fallback to cat
            cat "${FILE_PATH}" && exit 5
            exit 2;;

        ## Image
        image/*)
            [ "$PV_IMAGE_ENABLED" = 'True' ] && exit 6
            identify "${FILE_PATH}" && exit 5
            exit 1;;

        ## Video
        video/*)
            [ "$PV_IMAGE_ENABLED" = 'True' ] && \
                ffmpegthumbnailer -i "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}" -s 0 && \
                exit 6
            mediainfo "${FILE_PATH}" && exit 5
            exit 1;;

        ## PDF
        application/pdf)
            pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | \
                fmt -w "${PV_WIDTH}" && exit 5
            exit 1;;
    esac
}

# Get MIME type
MIMETYPE="$( file --dereference --brief --mime-type -- "${FILE_PATH}" )"

# Try extension first, then MIME type
handle_extension
handle_mime "${MIMETYPE}"

# Fallback
echo '----- File Type Classification -----' && file --dereference --brief -- "${FILE_PATH}" && exit 5
exit 1
````

### `rc.conf`

```conf
# =====================================
# TMUX + DEVELOPMENT WORKFLOW
# =====================================
map <C-r> react_setup
map <C-t> shell tmux split-window -h 'nvim %s'
map <C-v> shell tmux split-window -v
map xy switch_to_yazi
# =====================================
# BASIC RANGER SETTINGS
# =====================================
set show_hidden true
set colorscheme default
set mouse_enabled true
set display_size_in_main_column true
set display_size_in_status_bar true

# =====================================
# PREVIEW SETTINGS
# =====================================
set preview_images true
set preview_images_method w3m
set use_preview_script true
set preview_script ~/.config/ranger/scope.sh
set preview_max_size 0
set preview_directories true
set collapse_preview true
set automatically_count_files true

# =====================================
# WEB DEVELOPMENT SHORTCUTS
# =====================================
set show_cursor true
set sort natural

source /home/sj/.config/ranger/keybindings/navigation.conf
```

### `commands.py`

```py

import os
import subprocess
from ranger.api.commands import Command

class react_setup(Command):
    """:react_setup
    Setup React development environment in tmux panes
    """
    def execute(self):
        cwd = self.fm.thisdir.path

        # Check for React project
        if not (os.path.exists(f"{cwd}/bun.lockb") or os.path.exists(f"{cwd}/package.json")):
            self.fm.notify("❌ Not a React project!", bad=True)
            return

        # Execute tmux setup script
        script = f'''
        cd "{cwd}"
        SESSION=$(tmux display-message -p '#S')
        WINDOW=$(tmux display-message -p '#I')
        PANE_COUNT=$(tmux list-panes | wc -l)

        # Create panes if needed
        if [ "$PANE_COUNT" -lt 3 ]; then
            tmux split-window -v -c "{cwd}"
            tmux split-window -h -c "{cwd}"
        fi

        # Apply layout
        tmux select-layout main-horizontal

        # Start nvim in pane 2 and bun dev in pane 3
        tmux send-keys -t 2 "cd '{cwd}' && nvim ." C-m
        tmux send-keys -t 3 "cd '{cwd}' && bun run dev" C-m

        # Now swap pane 1 (ranger) with pane 2 (nvim)
        tmux swap-pane -s 1 -t 2

        # Focus ranger pane (now in pane 2 after swap)
        tmux select-pane -t 2
        '''

        try:
            subprocess.run(["bash", "-c", script], check=True)
            self.fm.notify("🚀 React environment setup complete!")
        except subprocess.CalledProcessError:
            self.fm.notify("❌ Failed to setup tmux environment", bad=True)

## switch to yazi

import tempfile
from ranger.api.commands import Command

class switch_to_yazi(Command):
    """:switch_to_yazi
    Switch from ranger to yazi with path synchronization
    When you quit yazi, ranger will cd to yazi's last location
    """
    def execute(self):
        current_path = self.fm.thisdir.path

        # Create temporary file to store yazi's final path
        with tempfile.NamedTemporaryFile(mode='w', delete=False, suffix='.yazi_cwd') as tmp:
            tmp_path = tmp.name

        try:
            # Run yazi with --cwd-file to capture final directory
            subprocess.run([
                'yazi',
                current_path,  # Start yazi in current ranger directory
                '--cwd-file', tmp_path  # Save final directory to temp file
            ], check=True)

            # Read the final path from yazi
            if os.path.exists(tmp_path):
                with open(tmp_path, 'r') as f:
                    final_path = f.read().strip()

                # Change ranger to yazi's final directory
                if final_path and os.path.exists(final_path) and final_path != current_path:
                    self.fm.cd(final_path)
                    self.fm.notify(f"📁 Yazi → {os.path.basename(final_path)}")
                else:
                    self.fm.notify("📁 Returned from yazi")
            else:
                self.fm.notify("📁 Returned from yazi")

        except subprocess.CalledProcessError:
            self.fm.notify("❌ Failed to launch yazi", bad=True)
        except FileNotFoundError:
            self.fm.notify("❌ Yazi not found. Install with: cargo install --locked yazi-fm", bad=True)
        except Exception as e:
            self.fm.notify(f"❌ Error: {e}", bad=True)
        finally:
            # Clean up temp file
            if os.path.exists(tmp_path):
                os.unlink(tmp_path)
```
