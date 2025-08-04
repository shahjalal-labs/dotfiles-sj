You are a **senior full-stack developer**.

## 📌 Task

You are given a real-world code module located at:

```
/home/sj/.config/yazi
```

Refactor the entire codebase **without modifying any UI or changing behavior**. Instead, improve it using:

- ✅ Clear separation of concerns
- ✅ Consistent, semantic naming conventions
- ✅ Modular architecture (hooks, services, utils, components)
- ✅ Scalable file/folder structure
- ✅ Industry-standard project layout and architecture
- ✅ Readable, testable, production-grade code
- ✅ 100% behavior and API compatibility

👉 Output the refactored code to a new folder: `yazi_refactored`

Also return a `.sh` script that will:
- Create that folder
- Write all refactored files
- Run `git add` and `git commit` with message: `refactor: added improved yazi version`

---

## 🌲 Full Project Structure (cwd)

```bash
/home/sj/.config/yazi
├── keymap.toml
├── theme.toml
└── yazi.toml

1 directory, 3 files
```

## 📁 Target Module Tree (yazi)

```bash
/home/sj/.config/yazi
├── keymap.toml
├── theme.toml
└── yazi.toml

1 directory, 3 files
```

## 📄 Module Files & Contents

### `yazi.toml`
```toml
# A TOML linter such as https://taplo.tamasfe.dev/ can use this schema to validate your config.
# If you encounter any issues, please make an issue at https://github.com/yazi-rs/schemas.
"$schema" = "https://yazi-rs.github.io/schemas/yazi.json"

[mgr]
ratio          = [ 1, 4, 3 ]
sort_by        = "alphabetical"
sort_sensitive = false
sort_reverse 	 = false
sort_dir_first = true
sort_translit  = false
linemode       = "none"
show_hidden    = false
show_symlink   = true
scrolloff      = 5
mouse_events   = [ "click", "scroll" ]
title_format   = "Yazi: {cwd}"

[preview]
wrap            = "no"
tab_size        = 2
max_width       = 600
max_height      = 900
cache_dir       = ""
image_delay     = 30
image_filter    = "triangle"
image_quality   = 75
sixel_fraction  = 15
ueberzug_scale  = 1
ueberzug_offset = [ 0, 0, 0, 0 ]

[opener]
edit = [
	{ run = '${EDITOR:-vi} "$@"', desc = "$EDITOR", block = true, for = "unix" },
	{ run = 'code %*',    orphan = true, desc = "code",           for = "windows" },
	{ run = 'code -w %*', block = true,  desc = "code (block)",   for = "windows" },
]
open = [
	{ run = 'xdg-open "$1"',                desc = "Open", for = "linux" },
	{ run = 'open "$@"',                    desc = "Open", for = "macos" },
	{ run = 'start "" "%1"', orphan = true, desc = "Open", for = "windows" },
]
reveal = [
	{ run = 'xdg-open "$(dirname "$1")"',           desc = "Reveal", for = "linux" },
	{ run = 'open -R "$1"',                         desc = "Reveal", for = "macos" },
	{ run = 'explorer /select,"%1"', orphan = true, desc = "Reveal", for = "windows" },
	{ run = '''exiftool "$1"; echo "Press enter to exit"; read _''', block = true, desc = "Show EXIF", for = "unix" },
]
extract = [
	{ run = 'ya pub extract --list "$@"', desc = "Extract here", for = "unix" },
	{ run = 'ya pub extract --list %*',   desc = "Extract here", for = "windows" },
]
play = [
	{ run = 'mpv --force-window "$@"', orphan = true, for = "unix" },
	{ run = 'mpv --force-window %*', orphan = true, for = "windows" },
	{ run = '''mediainfo "$1"; echo "Press enter to exit"; read _''', block = true, desc = "Show media info", for = "unix" },
]

[open]
rules = [
	# Folder
	{ name = "*/", use = [ "edit", "open", "reveal" ] },
	# Text
	{ mime = "text/*", use = [ "edit", "reveal" ] },
	# Image
	{ mime = "image/*", use = [ "open", "reveal" ] },
	# Media
	{ mime = "{audio,video}/*", use = [ "play", "reveal" ] },
	# Archive
	{ mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}", use = [ "extract", "reveal" ] },
	# JSON
	{ mime = "application/{json,ndjson}", use = [ "edit", "reveal" ] },
	{ mime = "*/javascript", use = [ "edit", "reveal" ] },
	# Empty file
	{ mime = "inode/empty", use = [ "edit", "reveal" ] },
	# Fallback
	{ name = "*", use = [ "open", "reveal" ] },
]

[tasks]
micro_workers    = 10
macro_workers    = 10
bizarre_retry    = 3
image_alloc      = 536870912  # 512MB
image_bound      = [ 0, 0 ]
suppress_preload = false

[plugin]

fetchers = [
	# Mimetype
	{ id = "mime", name = "*", run = "mime", if = "!mime", prio = "high" },
]
spotters = [
	{ name = "*/", run = "folder" },
	# Code
	{ mime = "text/*", run = "code" },
	{ mime = "*/{xml,javascript,wine-extension-ini}", run = "code" },
	# Image
	{ mime = "image/{avif,hei?,jxl,svg+xml}", run = "magick" },
	{ mime = "image/*", run = "image" },
	# Video
	{ mime = "video/*", run = "video" },
	# Fallback
	{ name = "*", run = "file" },
]
preloaders = [
	# Image
	{ mime = "image/{avif,hei?,jxl,svg+xml}", run = "magick" },
	{ mime = "image/*", run = "image" },
	# Video
	{ mime = "video/*", run = "video" },
	# PDF
	{ mime = "application/pdf", run = "pdf" },
	# Font
	{ mime = "font/*", run = "font" },
	{ mime = "application/ms-opentype", run = "font" },
]
previewers = [
	{ name = "*/", run = "folder", sync = true },
	# Code
	{ mime = "text/*", run = "code" },
	{ mime = "*/{xml,javascript,wine-extension-ini}", run = "code" },
	# JSON
	{ mime = "application/{json,ndjson}", run = "json" },
	# Image
	{ mime = "image/{avif,hei?,jxl,svg+xml}", run = "magick" },
	{ mime = "image/*", run = "image" },
	# Video
	{ mime = "video/*", run = "video" },
	# PDF
	{ mime = "application/pdf", run = "pdf" },
	# Archive
	{ mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}", run = "archive" },
	{ mime = "application/{debian*-package,redhat-package-manager,rpm,android.package-archive}", run = "archive" },
	{ name = "*.{AppImage,appimage}", run = "archive" },
	# Virtual Disk / Disk Image
	{ mime = "application/{iso9660-image,qemu-disk,ms-wim,apple-diskimage}", run = "archive" },
	{ mime = "application/virtualbox-{vhd,vhdx}", run = "archive" },
	{ name = "*.{img,fat,ext,ext2,ext3,ext4,squashfs,ntfs,hfs,hfsx}", run = "archive" },
	# Font
	{ mime = "font/*", run = "font" },
	{ mime = "application/ms-opentype", run = "font" },
	# Empty file
	{ mime = "inode/empty", run = "empty" },
	# Fallback
	{ name = "*", run = "file" },
]

[input]
cursor_blink = false

# cd
cd_title  = "Change directory:"
cd_origin = "top-center"
cd_offset = [ 0, 2, 50, 3 ]

# create
create_title  = [ "Create:", "Create (dir):" ]
create_origin = "top-center"
create_offset = [ 0, 2, 50, 3 ]

# rename
rename_title  = "Rename:"
rename_origin = "hovered"
rename_offset = [ 0, 1, 50, 3 ]

# filter
filter_title  = "Filter:"
filter_origin = "top-center"
filter_offset = [ 0, 2, 50, 3 ]

# find
find_title  = [ "Find next:", "Find previous:" ]
find_origin = "top-center"
find_offset = [ 0, 2, 50, 3 ]

# search
search_title  = "Search via {n}:"
search_origin = "top-center"
search_offset = [ 0, 2, 50, 3 ]

# shell
shell_title  = [ "Shell:", "Shell (block):" ]
shell_origin = "top-center"
shell_offset = [ 0, 2, 50, 3 ]

[confirm]
# trash
trash_title 	= "Trash {n} selected file{s}?"
trash_origin	= "center"
trash_offset	= [ 0, 0, 70, 20 ]

# delete
delete_title 	= "Permanently delete {n} selected file{s}?"
delete_origin	= "center"
delete_offset	= [ 0, 0, 70, 20 ]

# overwrite
overwrite_title   = "Overwrite file?"
overwrite_content = "Will overwrite the following file:"
overwrite_origin  = "center"
overwrite_offset  = [ 0, 0, 50, 15 ]

# quit
quit_title   = "Quit?"
quit_content = "The following task is still running, are you sure you want to quit?"
quit_origin  = "center"
quit_offset  = [ 0, 0, 50, 15 ]

[pick]
open_title  = "Open with:"
open_origin = "hovered"
open_offset = [ 0, 1, 50, 7 ]

[which]
sort_by      	 = "none"
sort_sensitive = false
sort_reverse 	 = false
sort_translit  = false

[keys.normal]
# w = { exec = "/run/media/sj/developer/zshScript/shellScript/lf_fm_shell_script/dev-launch.sh '{{file}}'", desc = "Dev Launch in tmux panes" }

w = { exec = "sh -c '/run/media/sj/developer/zshScript/shellScript/lf_fm_shell_script/dev-launch.sh \"$YAZI_FILE\"'", desc = "Dev Launch in tmux panes" }

```

### `keymap.toml`
```toml
# A TOML linter such as https://taplo.tamasfe.dev/ can use this schema to validate your config.
# If you encounter any issues, please make an issue at https://github.com/yazi-rs/schemas.
"$schema" = "https://yazi-rs.github.io/schemas/keymap.json"

[mgr]

keymap = [
	{ on = "<Esc>", run = "escape",             desc = "Exit visual mode, clear selected, or cancel search" },
	{ on = "<C-[>", run = "escape",             desc = "Exit visual mode, clear selected, or cancel search" },
	{ on = "q",     run = "quit",               desc = "Quit the process" },
	{ on = "Q",     run = "quit --no-cwd-file", desc = "Quit the process without outputting cwd-file" },
	{ on = "<C-c>", run = "close",              desc = "Close the current tab, or quit if it's last" },
	{ on = "<C-z>", run = "suspend",            desc = "Suspend the process" },

	# Hopping
	{ on = "k", run = "arrow -1", desc = "Move cursor up" },
	{ on = "j", run = "arrow 1",  desc = "Move cursor down" },

	{ on = "<Up>",    run = "arrow -1", desc = "Move cursor up" },
	{ on = "<Down>",  run = "arrow 1",  desc = "Move cursor down" },

	{ on = "<C-u>", run = "arrow -50%",  desc = "Move cursor up half page" },
	{ on = "<C-d>", run = "arrow 50%",   desc = "Move cursor down half page" },
	{ on = "<C-b>", run = "arrow -100%", desc = "Move cursor up one page" },
	{ on = "<C-f>", run = "arrow 100%",  desc = "Move cursor down one page" },

	{ on = "<S-PageUp>",   run = "arrow -50%",  desc = "Move cursor up half page" },
	{ on = "<S-PageDown>", run = "arrow 50%",   desc = "Move cursor down half page" },
	{ on = "<PageUp>",     run = "arrow -100%", desc = "Move cursor up one page" },
	{ on = "<PageDown>",   run = "arrow 100%",  desc = "Move cursor down one page" },

	{ on = [ "g", "g" ], run = "arrow -99999999", desc = "Move cursor to the top" },
 	{ on = [ "g", "j" ], run = "arrow 99999999", desc = "Move cursor to the bottom" },
  { on = "G",         run = "arrow 99999999",  desc = "Move cursor to the bottom" },


	# Navigation
	{ on = "h", run = "leave", desc = "Go back to the parent directory" },
	{ on = "l", run = "enter", desc = "Enter the child directory" },

	{ on = "<Left>",  run = "leave", desc = "Go back to the parent directory" },
	{ on = "<Right>", run = "enter", desc = "Enter the child directory" },

	{ on = "H", run = "back",    desc = "Go back to the previous directory" },
	{ on = "L", run = "forward", desc = "Go forward to the next directory" },

	# Toggle
	{ on = "<Space>", run = [ "toggle", "arrow 1" ], desc = "Toggle the current selection state" },
	{ on = "<C-a>",   run = "toggle_all --state=on", desc = "Select all files" },
	{ on = "<C-r>",   run = "toggle_all",            desc = "Invert selection of all files" },

	# Visual mode
	{ on = "v", run = "visual_mode",         desc = "Enter visual mode (selection mode)" },
	{ on = "V", run = "visual_mode --unset", desc = "Enter visual mode (unset mode)" },

	# Seeking
	{ on = "K", run = "seek -5", desc = "Seek up 5 units in the preview" },
	{ on = "J", run = "seek 5",  desc = "Seek down 5 units in the preview" },

	# Spotting
	{ on = "<Tab>", run = "spot", desc = "Spot hovered file" },

	# Operation
	{ on = "o",         run = "open",                        desc = "Open selected files" },
	{ on = "O",         run = "open --interactive",          desc = "Open selected files interactively" },
	{ on = "<Enter>",   run = "open",                        desc = "Open selected files" },
	{ on = "<S-Enter>", run = "open --interactive",          desc = "Open selected files interactively" },
	{ on = "y",         run = "yank",                        desc = "Yank selected files (copy)" },
	{ on = "x",         run = "yank --cut",                  desc = "Yank selected files (cut)" },
	{ on = "p",         run = "paste",                       desc = "Paste yanked files" },
	{ on = "P",         run = "paste --force",               desc = "Paste yanked files (overwrite if the destination exists)" },
	{ on = "-",         run = "link",                        desc = "Symlink the absolute path of yanked files" },
	{ on = "_",         run = "link --relative",             desc = "Symlink the relative path of yanked files" },
	{ on = "<C-->",     run = "hardlink",                    desc = "Hardlink yanked files" },
	{ on = "Y",         run = "unyank",                      desc = "Cancel the yank status" },
	{ on = "X",         run = "unyank",                      desc = "Cancel the yank status" },
	{ on = "D",         run = "remove",                      desc = "Trash selected files" },
	{ on = "d",         run = "remove --permanently",        desc = "Permanently delete selected files" },
	{ on = "a",         run = "create",                      desc = "Create a file (ends with / for directories)" },
	{ on = "r",         run = "rename --cursor=before_ext",  desc = "Rename selected file(s)" },
	{ on = ";",         run = "shell --interactive",         desc = "Run a shell command" },
	{ on = ":",         run = "shell --block --interactive", desc = "Run a shell command (block until finishes)" },
	{ on = ".",         run = "hidden toggle",               desc = "Toggle the visibility of hidden files" },
	{ on = "s",         run = "search --via=fd",             desc = "Search files by name via fd" },
	{ on = "S",         run = "search --via=rg",             desc = "Search files by content via ripgrep" },
	{ on = "<C-s>",     run = "escape --search",             desc = "Cancel the ongoing search" },
	{ on = "z",         run = "plugin zoxide",               desc = "Jump to a directory via zoxide" },
	{ on = "Z",         run = "plugin fzf",                  desc = "Jump to a file/directory via fzf" },

	# Linemode
	{ on = [ "m", "s" ], run = "linemode size",        desc = "Linemode: size" },
	{ on = [ "m", "p" ], run = "linemode permissions", desc = "Linemode: permissions" },
	{ on = [ "m", "b" ], run = "linemode btime",       desc = "Linemode: btime" },
	{ on = [ "m", "m" ], run = "linemode mtime",       desc = "Linemode: mtime" },
	{ on = [ "m", "o" ], run = "linemode owner",       desc = "Linemode: owner" },
	{ on = [ "m", "n" ], run = "linemode none",        desc = "Linemode: none" },

	# Copy
	{ on = [ "c", "c" ], run = "copy path",             desc = "Copy the file path" },
	{ on = [ "c", "d" ], run = "copy dirname",          desc = "Copy the directory path" },
	{ on = [ "c", "f" ], run = "copy filename",         desc = "Copy the filename" },
	{ on = [ "c", "n" ], run = "copy name_without_ext", desc = "Copy the filename without extension" },

	# Filter
	{ on = "f", run = "filter --smart", desc = "Filter files" },

	# Find
	{ on = "/", run = "find --smart",            desc = "Find next file" },
	{ on = "?", run = "find --previous --smart", desc = "Find previous file" },
	{ on = "n", run = "find_arrow",              desc = "Goto the next found" },
	{ on = "N", run = "find_arrow --previous",   desc = "Goto the previous found" },

	# Sorting
	{ on = [ ",", "m" ], run = [ "sort mtime --reverse=no", "linemode mtime" ], desc = "Sort by modified time" },
	{ on = [ ",", "M" ], run = [ "sort mtime --reverse", "linemode mtime" ],    desc = "Sort by modified time (reverse)" },
	{ on = [ ",", "b" ], run = [ "sort btime --reverse=no", "linemode btime" ], desc = "Sort by birth time" },
	{ on = [ ",", "B" ], run = [ "sort btime --reverse", "linemode btime" ],    desc = "Sort by birth time (reverse)" },
	{ on = [ ",", "e" ], run = "sort extension --reverse=no",                   desc = "Sort by extension" },
	{ on = [ ",", "E" ], run = "sort extension --reverse",                      desc = "Sort by extension (reverse)" },
	{ on = [ ",", "a" ], run = "sort alphabetical --reverse=no",                desc = "Sort alphabetically" },
	{ on = [ ",", "A" ], run = "sort alphabetical --reverse",                   desc = "Sort alphabetically (reverse)" },
	{ on = [ ",", "n" ], run = "sort natural --reverse=no",                     desc = "Sort naturally" },
	{ on = [ ",", "N" ], run = "sort natural --reverse",                        desc = "Sort naturally (reverse)" },
	{ on = [ ",", "s" ], run = [ "sort size --reverse=no", "linemode size" ],   desc = "Sort by size" },
	{ on = [ ",", "S" ], run = [ "sort size --reverse", "linemode size" ],      desc = "Sort by size (reverse)" },
	{ on = [ ",", "r" ], run = "sort random --reverse=no",                      desc = "Sort randomly" },

	# Goto
	{ on = [ "g", "h" ],       run = "cd ~",             desc = "Go home" },
 	{ on = [ "g", "t" ],       run = "cd /run/media/sj/developer/web/L1B11/1-amr-day-record/sessions/July25",  desc = "Go sessions" },
	{ on = [ "g", "l" ],       run = "cd /run/media/sj/developer/web/L1B11", desc = "Go L1B11" },
 	{ on = [ "g", "s" ],       run = "cd /run/media/sj/developer/web/L1B11/screenshots", desc = "Go to screenshots" },
 	{ on = [ "g", "i" ],       run = "cd /run/media/sj/developer/web/L1B11/4-mi-js/23-mo-javaScript-simple-coding-problems-part-2/js-problems-part2/pr/.s8cr8tN8w/ss/bestImage", desc = "Go .s8cr8t" },
	{ on = [ "g", "k" ],       run = "cd /run/media/sj/developer/web/L1B6UpdatedTo9",             desc = "L1B6 Updated to Batch 10" },
	# { on = [ "g", "l" ],       run = "cd /run/media/sj/developer",             desc = "Backup Folder" },
	{ on = [ "g", "f" ],       run = "cd /run/media/sj/developer/web/L2B4/frontend-track",             desc = "FrontEnd L2B4" },
	{ on = [ "g", "c" ],       run = "cd ~/.config",     desc = "Goto ~/.config" },
	{ on = [ "g", "d" ],       run = "cd ~/Downloads",   desc = "Goto ~/Downloads" },
	{ on = [ "g", "<Space>" ], run = "cd --interactive", desc = "Jump interactively" },

	# Tabs
	{ on = "t", run = "tab_create --current", desc = "Create a new tab with CWD" },

	{ on = "1", run = "tab_switch 0", desc = "Switch to the first tab" },
	{ on = "2", run = "tab_switch 1", desc = "Switch to the second tab" },
	{ on = "3", run = "tab_switch 2", desc = "Switch to the third tab" },
	{ on = "4", run = "tab_switch 3", desc = "Switch to the fourth tab" },
	{ on = "5", run = "tab_switch 4", desc = "Switch to the fifth tab" },
	{ on = "6", run = "tab_switch 5", desc = "Switch to the sixth tab" },
	{ on = "7", run = "tab_switch 6", desc = "Switch to the seventh tab" },
	{ on = "8", run = "tab_switch 7", desc = "Switch to the eighth tab" },
	{ on = "9", run = "tab_switch 8", desc = "Switch to the ninth tab" },

	{ on = "[", run = "tab_switch -1 --relative", desc = "Switch to the previous tab" },
	{ on = "]", run = "tab_switch 1 --relative",  desc = "Switch to the next tab" },

	{ on = "{", run = "tab_swap -1", desc = "Swap current tab with previous tab" },
	{ on = "}", run = "tab_swap 1",  desc = "Swap current tab with next tab" },

	# Tasks
	{ on = "w", run = "tasks_show", desc = "Show task manager" },

	# Help
	{ on = "~",    run = "help", desc = "Open help" },
	{ on = "<F1>", run = "help", desc = "Open help" },
]

[tasks]

keymap = [
	{ on = "<Esc>", run = "close", desc = "Close task manager" },
	{ on = "<C-[>", run = "close", desc = "Close task manager" },
	{ on = "<C-c>", run = "close", desc = "Close task manager" },
	{ on = "w",     run = "close", desc = "Close task manager" },

	{ on = "k", run = "arrow -1", desc = "Move cursor up" },
	{ on = "j", run = "arrow 1",  desc = "Move cursor down" },

	{ on = "<Up>",   run = "arrow -1", desc = "Move cursor up" },
	{ on = "<Down>", run = "arrow 1",  desc = "Move cursor down" },

	{ on = "<Enter>", run = "inspect", desc = "Inspect the task" },
	{ on = "x",       run = "cancel",  desc = "Cancel the task" },

	# Help
	{ on = "~",    run = "help", desc = "Open help" },
	{ on = "<F1>", run = "help", desc = "Open help" },
]

[spot]

keymap = [
	{ on = "<Esc>", run = "close", desc = "Close the spot" },
	{ on = "<C-[>", run = "close", desc = "Close the spot" },
	{ on = "<C-c>", run = "close", desc = "Close the spot" },
	{ on = "<Tab>", run = "close", desc = "Close the spot" },

	{ on = "k", run = "arrow -1", desc = "Move cursor up" },
	{ on = "j", run = "arrow 1",  desc = "Move cursor down" },
	{ on = "h", run = "swipe -1", desc = "Swipe to the next file" },
	{ on = "l", run = "swipe 1",  desc = "Swipe to the previous file" },

	{ on = "<Up>",    run = "arrow -1", desc = "Move cursor up" },
	{ on = "<Down>",  run = "arrow 1",  desc = "Move cursor down" },
	{ on = "<Left>",  run = "swipe -1", desc = "Swipe to the next file" },
	{ on = "<Right>", run = "swipe 1",  desc = "Swipe to the previous file" },

	# Copy
	{ on = [ "c", "c" ], run = "copy cell", desc = "Copy selected cell" },

	# Help
	{ on = "~",    run = "help", desc = "Open help" },
	{ on = "<F1>", run = "help", desc = "Open help" },
]

[pick]

keymap = [
	{ on = "<Esc>",   run = "close",          desc = "Cancel pick" },
	{ on = "<C-[>",   run = "close",          desc = "Cancel pick" },
	{ on = "<C-c>",   run = "close",          desc = "Cancel pick" },
	{ on = "<Enter>", run = "close --submit", desc = "Submit the pick" },

	{ on = "k", run = "arrow -1", desc = "Move cursor up" },
	{ on = "j", run = "arrow 1",  desc = "Move cursor down" },

	{ on = "<Up>",   run = "arrow -1", desc = "Move cursor up" },
	{ on = "<Down>", run = "arrow 1",  desc = "Move cursor down" },

	# Help
	{ on = "~",    run = "help", desc = "Open help" },
	{ on = "<F1>", run = "help", desc = "Open help" },
]

[input]

keymap = [
	{ on = "<C-c>",   run = "close",          desc = "Cancel input" },
	{ on = "<Enter>", run = "close --submit", desc = "Submit input" },
	{ on = "<Esc>",   run = "escape",         desc = "Go back the normal mode, or cancel input" },
	{ on = "<C-[>",   run = "escape",         desc = "Go back the normal mode, or cancel input" },

	# Mode
	{ on = "i", run = "insert",                              desc = "Enter insert mode" },
	{ on = "a", run = "insert --append",                     desc = "Enter append mode" },
	{ on = "I", run = [ "move -999", "insert" ],             desc = "Move to the BOL, and enter insert mode" },
	{ on = "A", run = [ "move 999", "insert --append" ],     desc = "Move to the EOL, and enter append mode" },
	{ on = "v", run = "visual",                              desc = "Enter visual mode" },
	{ on = "V", run = [ "move -999", "visual", "move 999" ], desc = "Enter visual mode and select all" },

	# Character-wise movement
	{ on = "h",       run = "move -1", desc = "Move back a character" },
	{ on = "l",       run = "move 1",  desc = "Move forward a character" },
	{ on = "<Left>",  run = "move -1", desc = "Move back a character" },
	{ on = "<Right>", run = "move 1",  desc = "Move forward a character" },
	{ on = "<C-b>",   run = "move -1", desc = "Move back a character" },
	{ on = "<C-f>",   run = "move 1",  desc = "Move forward a character" },

	# Word-wise movement
	{ on = "b",     run = "backward",              desc = "Move back to the start of the current or previous word" },
	{ on = "w",     run = "forward",               desc = "Move forward to the start of the next word" },
	{ on = "e",     run = "forward --end-of-word", desc = "Move forward to the end of the current or next word" },
	{ on = "<A-b>", run = "backward",              desc = "Move back to the start of the current or previous word" },
	{ on = "<A-f>", run = "forward --end-of-word", desc = "Move forward to the end of the current or next word" },

	# Line-wise movement
	{ on = "0",      run = "move -999", desc = "Move to the BOL" },
	{ on = "$",      run = "move 999",  desc = "Move to the EOL" },
	{ on = "<C-a>",  run = "move -999", desc = "Move to the BOL" },
	{ on = "<C-e>",  run = "move 999",  desc = "Move to the EOL" },
	{ on = "<Home>", run = "move -999", desc = "Move to the BOL" },
	{ on = "<End>",  run = "move 999",  desc = "Move to the EOL" },

	# Delete
	{ on = "<Backspace>", run = "backspace",         desc = "Delete the character before the cursor" },
	{ on = "<Delete>",    run = "backspace --under", desc = "Delete the character under the cursor" },
	{ on = "<C-h>",       run = "backspace",         desc = "Delete the character before the cursor" },
	{ on = "<C-d>",       run = "backspace --under", desc = "Delete the character under the cursor" },

	# Kill
	{ on = "<C-u>", run = "kill bol",      desc = "Kill backwards to the BOL" },
	{ on = "<C-k>", run = "kill eol",      desc = "Kill forwards to the EOL" },
	{ on = "<C-w>", run = "kill backward", desc = "Kill backwards to the start of the current word" },
	{ on = "<A-d>", run = "kill forward",  desc = "Kill forwards to the end of the current word" },

	# Cut/Yank/Paste
	{ on = "d", run = "delete --cut",                              desc = "Cut the selected characters" },
	{ on = "D", run = [ "delete --cut", "move 999" ],              desc = "Cut until the EOL" },
	{ on = "c", run = "delete --cut --insert",                     desc = "Cut the selected characters, and enter insert mode" },
	{ on = "C", run = [ "delete --cut --insert", "move 999" ],     desc = "Cut until the EOL, and enter insert mode" },
	{ on = "x", run = [ "delete --cut", "move 1 --in-operating" ], desc = "Cut the current character" },
	{ on = "y", run = "yank",                                      desc = "Copy the selected characters" },
	{ on = "p", run = "paste",                                     desc = "Paste the copied characters after the cursor" },
	{ on = "P", run = "paste --before",                            desc = "Paste the copied characters before the cursor" },

	# Undo/Redo
	{ on = "u",     run = "undo", desc = "Undo the last operation" },
	{ on = "<C-r>", run = "redo", desc = "Redo the last operation" },

	# Help
	{ on = "~",    run = "help", desc = "Open help" },
	{ on = "<F1>", run = "help", desc = "Open help" },
]

[confirm]

keymap = [
	{ on = "<Esc>",   run = "close",          desc = "Cancel the confirm" },
	{ on = "<C-[>",   run = "close",          desc = "Cancel the confirm" },
	{ on = "<C-c>",   run = "close",          desc = "Cancel the confirm" },
	{ on = "<Enter>", run = "close --submit", desc = "Submit the confirm" },

	{ on = "n", run = "close",          desc = "Cancel the confirm" },
	{ on = "y", run = "close --submit", desc = "Submit the confirm" },

	{ on = "k", run = "arrow -1", desc = "Move cursor up" },
	{ on = "j", run = "arrow 1",  desc = "Move cursor down" },

	{ on = "<Up>",   run = "arrow -1", desc = "Move cursor up" },
	{ on = "<Down>", run = "arrow 1",  desc = "Move cursor down" },

	# Help
	{ on = "~",    run = "help", desc = "Open help" },
	{ on = "<F1>", run = "help", desc = "Open help" },
]

[completion]

keymap = [
	{ on = "<C-c>",   run = "close",                                      desc = "Cancel completion" },
	{ on = "<Tab>",   run = "close --submit",                             desc = "Submit the completion" },
	{ on = "<Enter>", run = [ "close --submit", "close_input --submit" ], desc = "Submit the completion and input" },

	{ on = "<A-k>", run = "arrow -1", desc = "Move cursor up" },
	{ on = "<A-j>", run = "arrow 1",  desc = "Move cursor down" },

	{ on = "<Up>",   run = "arrow -1", desc = "Move cursor up" },
	{ on = "<Down>", run = "arrow 1",  desc = "Move cursor down" },

	{ on = "<C-p>", run = "arrow -1", desc = "Move cursor up" },
	{ on = "<C-n>", run = "arrow 1",  desc = "Move cursor down" },

	# Help
	{ on = "~",    run = "help", desc = "Open help" },
	{ on = "<F1>", run = "help", desc = "Open help" },
]

[help]

keymap = [
	{ on = "<Esc>", run = "escape", desc = "Clear the filter, or hide the help" },
	{ on = "<C-[>", run = "escape", desc = "Clear the filter, or hide the help" },
	{ on = "<C-c>", run = "close",  desc = "Hide the help" },

	# Navigation
	{ on = "k", run = "arrow -1", desc = "Move cursor up" },
	{ on = "j", run = "arrow 1",  desc = "Move cursor down" },

	{ on = "<Up>",   run = "arrow -1", desc = "Move cursor up" },
	{ on = "<Down>", run = "arrow 1",  desc = "Move cursor down" },

	# Filtering
	{ on = "f", run = "filter", desc = "Apply a filter for the help items" },
]
```

### `theme.toml`
```toml
# If the user's terminal is in dark mode, Yazi will load `theme-dark.toml` on startup; otherwise, `theme-light.toml`.
# You can override any parts of them that are not related to the dark/light mode in your own `theme.toml`.

# If you want to dynamically override their content based on dark/light mode, you can specify two different flavors
# for dark and light modes under `[flavor]`, and do so in those flavors instead.
"$schema" = "https://yazi-rs.github.io/schemas/theme.json"

# vim:fileencoding=utf-8:foldmethod=marker

# : Flavor {{{

[flavor]
dark  = ""
light = ""

# : }}}

# : Manager {{{

[mgr]
cwd = { fg = "cyan" }

# Hovered
hovered         = { reversed = true }
preview_hovered = { underline = true }

# Find
find_keyword  = { fg = "yellow", bold = true, italic = true, underline = true }
find_position = { fg = "magenta", bg = "reset", bold = true, italic = true }

# Marker
marker_copied   = { fg = "lightgreen",  bg = "lightgreen" }
marker_cut      = { fg = "lightred",    bg = "lightred" }
marker_marked   = { fg = "lightcyan",   bg = "lightcyan" }
marker_selected = { fg = "lightyellow", bg = "lightyellow" }

# Tab
tab_active   = { reversed = true }
tab_inactive = {}
tab_width    = 1

# Count
count_copied   = { fg = "white", bg = "green" }
count_cut      = { fg = "white", bg = "red" }
count_selected = { fg = "white", bg = "yellow" }

# Border
border_symbol = "│"
border_style  = { fg = "gray" }

# Highlighting
syntect_theme = ""

# : }}}


# : Mode {{{

[mode]

normal_main = { bg = "blue", bold = true }
normal_alt  = { fg = "blue", bg = "gray" }

# Select mode
select_main = { bg = "red", bold = true }
select_alt  = { fg = "red", bg = "gray" }

# Unset mode
unset_main = { bg = "red", bold = true }
unset_alt  = { fg = "red", bg = "gray" }

# : }}}


# : Status bar {{{

[status]
separator_open  = ""
separator_close = ""

# Progress
progress_label  = { bold = true }
progress_normal = { fg = "blue", bg = "black" }
progress_error  = { fg = "red", bg = "black" }

# Permissions
perm_sep   = { fg = "darkgray" }
perm_type  = { fg = "green" }
perm_read  = { fg = "yellow" }
perm_write = { fg = "red" }
perm_exec  = { fg = "cyan" }

# : }}}


# : Pick {{{

[pick]
border   = { fg = "blue" }
active   = { fg = "magenta", bold = true }
inactive = {}

# : }}}


# : Input {{{

[input]
border   = { fg = "blue" }
title    = {}
value    = {}
selected = { reversed = true }

# : }}}


# : Confirm {{{

[confirm]
border     = { fg = "blue" }
title      = { fg = "blue" }
content    = {}
list       = {}
btn_yes    = { reversed = true }
btn_no     = {}
btn_labels = [ "  [Y]es  ", "  (N)o  " ]

# : }}}


# : Completion {{{

[completion]
border   = { fg = "blue" }
active   = { reversed = true }
inactive = {}

# Icons
icon_file    = ""
icon_folder  = ""
icon_command = ""

# : }}}


# : Tasks {{{

[tasks]
border  = { fg = "blue" }
title   = {}
hovered = { fg = "magenta", underline = true }

# : }}}


# : Which {{{

[which]
cols            = 3
mask            = { bg = "black" }
cand            = { fg = "lightcyan" }
rest            = { fg = "darkgray" }
desc            = { fg = "lightmagenta" }
separator       = "  "
separator_style = { fg = "darkgray" }

# : }}}


# : Help {{{

[help]
on      = { fg = "cyan" }
run     = { fg = "magenta" }
desc    = {}
hovered = { reversed = true, bold = true }
footer  = { fg = "black", bg = "white" }

# : }}}


# : Notify {{{

[notify]
title_info  = { fg = "green" }
title_warn  = { fg = "yellow" }
title_error = { fg = "red" }

# Icons
icon_info  = ""
icon_warn  = ""
icon_error = ""

# : }}}


# : File-specific styles {{{

[filetype]

rules = [
	# Images
	{ mime = "image/*", fg = "yellow" },

	# Media
	{ mime = "{audio,video}/*", fg = "magenta" },

	# Archives
	{ mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}", fg = "red" },

	# Documents
	{ mime = "application/{pdf,doc,rtf}", fg = "cyan" },

	# Empty files
	# { mime = "inode/empty", fg = "red" },

	# Special files
	{ name = "*", is = "orphan", bg = "red" },
	{ name = "*", is = "exec"  , fg = "green" },

	# Dummy files
	{ name = "*", is = "dummy", bg = "red" },
	{ name = "*/", is = "dummy", bg = "red" },

	# Fallback
	# { name = "*", fg = "white" },
	{ name = "*/", fg = "blue" }
]

# : }}}


# : Icons {{{

[icon]

globs = []
dirs  = [
	{ name = ".config", text = "" },
	{ name = ".git", text = "" },
	{ name = "Desktop", text = "" },
	{ name = "Development", text = "" },
	{ name = "Documents", text = "" },
	{ name = "Downloads", text = "" },
	{ name = "Library", text = "" },
	{ name = "Movies", text = "" },
	{ name = "Music", text = "" },
	{ name = "Pictures", text = "" },
	{ name = "Public", text = "" },
	{ name = "Videos", text = "" },
]
files = [
	{ name = ".babelrc", text = "", fg = "#cbcb41" },
	{ name = ".bash_profile", text = "", fg = "#89e051" },
	{ name = ".bashrc", text = "", fg = "#89e051" },
	{ name = ".dockerignore", text = "󰡨", fg = "#458ee6" },
	{ name = ".ds_store", text = "", fg = "#41535b" },
	{ name = ".editorconfig", text = "", fg = "#fff2f2" },
	{ name = ".env", text = "", fg = "#faf743" },
	{ name = ".eslintignore", text = "", fg = "#4b32c3" },
	{ name = ".eslintrc", text = "", fg = "#4b32c3" },
	{ name = ".git-blame-ignore-revs", text = "", fg = "#f54d27" },
	{ name = ".gitattributes", text = "", fg = "#f54d27" },
	{ name = ".gitconfig", text = "", fg = "#f54d27" },
	{ name = ".gitignore", text = "", fg = "#f54d27" },
	{ name = ".gitlab-ci.yml", text = "", fg = "#e24329" },
	{ name = ".gitmodules", text = "", fg = "#f54d27" },
	{ name = ".gtkrc-2.0", text = "", fg = "#ffffff" },
	{ name = ".gvimrc", text = "", fg = "#019833" },
	{ name = ".justfile", text = "", fg = "#6d8086" },
	{ name = ".luaurc", text = "", fg = "#00a2ff" },
	{ name = ".mailmap", text = "󰊢", fg = "#f54d27" },
	{ name = ".npmignore", text = "", fg = "#e8274b" },
	{ name = ".npmrc", text = "", fg = "#e8274b" },
	{ name = ".nuxtrc", text = "󱄆", fg = "#00c58e" },
	{ name = ".nvmrc", text = "", fg = "#5fa04e" },
	{ name = ".prettierignore", text = "", fg = "#4285f4" },
	{ name = ".prettierrc", text = "", fg = "#4285f4" },
	{ name = ".prettierrc.cjs", text = "", fg = "#4285f4" },
	{ name = ".prettierrc.js", text = "", fg = "#4285f4" },
	{ name = ".prettierrc.json", text = "", fg = "#4285f4" },
	{ name = ".prettierrc.json5", text = "", fg = "#4285f4" },
	{ name = ".prettierrc.mjs", text = "", fg = "#4285f4" },
	{ name = ".prettierrc.toml", text = "", fg = "#4285f4" },
	{ name = ".prettierrc.yaml", text = "", fg = "#4285f4" },
	{ name = ".prettierrc.yml", text = "", fg = "#4285f4" },
	{ name = ".settings.json", text = "", fg = "#854cc7" },
	{ name = ".SRCINFO", text = "󰣇", fg = "#0f94d2" },
	{ name = ".vimrc", text = "", fg = "#019833" },
	{ name = ".Xauthority", text = "", fg = "#e54d18" },
	{ name = ".xinitrc", text = "", fg = "#e54d18" },
	{ name = ".Xresources", text = "", fg = "#e54d18" },
	{ name = ".xsession", text = "", fg = "#e54d18" },
	{ name = ".zprofile", text = "", fg = "#89e051" },
	{ name = ".zshenv", text = "", fg = "#89e051" },
	{ name = ".zshrc", text = "", fg = "#89e051" },
	{ name = "_gvimrc", text = "", fg = "#019833" },
	{ name = "_vimrc", text = "", fg = "#019833" },
	{ name = "avif", text = "", fg = "#a074c4" },
	{ name = "brewfile", text = "", fg = "#701516" },
	{ name = "bspwmrc", text = "", fg = "#2f2f2f" },
	{ name = "build", text = "", fg = "#89e051" },
	{ name = "build.gradle", text = "", fg = "#005f87" },
	{ name = "build.zig.zon", text = "", fg = "#f69a1b" },
	{ name = "cantorrc", text = "", fg = "#1c99f3" },
	{ name = "checkhealth", text = "󰓙", fg = "#75b4fb" },
	{ name = "cmakelists.txt", text = "", fg = "#6d8086" },
	{ name = "code_of_conduct", text = "", fg = "#e41662" },
	{ name = "code_of_conduct.md", text = "", fg = "#e41662" },
	{ name = "commit_editmsg", text = "", fg = "#f54d27" },
	{ name = "commitlint.config.js", text = "󰜘", fg = "#2b9689" },
	{ name = "commitlint.config.ts", text = "󰜘", fg = "#2b9689" },
	{ name = "compose.yaml", text = "󰡨", fg = "#458ee6" },
	{ name = "compose.yml", text = "󰡨", fg = "#458ee6" },
	{ name = "config", text = "", fg = "#6d8086" },
	{ name = "containerfile", text = "󰡨", fg = "#458ee6" },
	{ name = "copying", text = "", fg = "#cbcb41" },
	{ name = "copying.lesser", text = "", fg = "#cbcb41" },
	{ name = "docker-compose.yaml", text = "󰡨", fg = "#458ee6" },
	{ name = "docker-compose.yml", text = "󰡨", fg = "#458ee6" },
	{ name = "dockerfile", text = "󰡨", fg = "#458ee6" },
	{ name = "eslint.config.cjs", text = "", fg = "#4b32c3" },
	{ name = "eslint.config.js", text = "", fg = "#4b32c3" },
	{ name = "eslint.config.mjs", text = "", fg = "#4b32c3" },
	{ name = "eslint.config.ts", text = "", fg = "#4b32c3" },
	{ name = "ext_typoscript_setup.txt", text = "", fg = "#ff8700" },
	{ name = "favicon.ico", text = "", fg = "#cbcb41" },
	{ name = "fp-info-cache", text = "", fg = "#ffffff" },
	{ name = "fp-lib-table", text = "", fg = "#ffffff" },
	{ name = "FreeCAD.conf", text = "", fg = "#cb333b" },
	{ name = "gemfile$", text = "", fg = "#701516" },
	{ name = "gnumakefile", text = "", fg = "#6d8086" },
	{ name = "go.mod", text = "", fg = "#519aba" },
	{ name = "go.sum", text = "", fg = "#519aba" },
	{ name = "go.work", text = "", fg = "#519aba" },
	{ name = "gradle-wrapper.properties", text = "", fg = "#005f87" },
	{ name = "gradle.properties", text = "", fg = "#005f87" },
	{ name = "gradlew", text = "", fg = "#005f87" },
	{ name = "groovy", text = "", fg = "#4a687c" },
	{ name = "gruntfile.babel.js", text = "", fg = "#e37933" },
	{ name = "gruntfile.coffee", text = "", fg = "#e37933" },
	{ name = "gruntfile.js", text = "", fg = "#e37933" },
	{ name = "gruntfile.ts", text = "", fg = "#e37933" },
	{ name = "gtkrc", text = "", fg = "#ffffff" },
	{ name = "gulpfile.babel.js", text = "", fg = "#cc3e44" },
	{ name = "gulpfile.coffee", text = "", fg = "#cc3e44" },
	{ name = "gulpfile.js", text = "", fg = "#cc3e44" },
	{ name = "gulpfile.ts", text = "", fg = "#cc3e44" },
	{ name = "hypridle.conf", text = "", fg = "#00aaae" },
	{ name = "hyprland.conf", text = "", fg = "#00aaae" },
	{ name = "hyprlock.conf", text = "", fg = "#00aaae" },
	{ name = "hyprpaper.conf", text = "", fg = "#00aaae" },
	{ name = "i18n.config.js", text = "󰗊", fg = "#7986cb" },
	{ name = "i18n.config.ts", text = "󰗊", fg = "#7986cb" },
	{ name = "i3blocks.conf", text = "", fg = "#e8ebee" },
	{ name = "i3status.conf", text = "", fg = "#e8ebee" },
	{ name = "ionic.config.json", text = "", fg = "#4f8ff7" },
	{ name = "justfile", text = "", fg = "#6d8086" },
	{ name = "kalgebrarc", text = "", fg = "#1c99f3" },
	{ name = "kdeglobals", text = "", fg = "#1c99f3" },
	{ name = "kdenlive-layoutsrc", text = "", fg = "#83b8f2" },
	{ name = "kdenliverc", text = "", fg = "#83b8f2" },
	{ name = "kritadisplayrc", text = "", fg = "#f245fb" },
	{ name = "kritarc", text = "", fg = "#f245fb" },
	{ name = "license", text = "", fg = "#d0bf41" },
	{ name = "license.md", text = "", fg = "#d0bf41" },
	{ name = "lxde-rc.xml", text = "", fg = "#909090" },
	{ name = "lxqt.conf", text = "", fg = "#0192d3" },
	{ name = "makefile", text = "", fg = "#6d8086" },
	{ name = "mix.lock", text = "", fg = "#a074c4" },
	{ name = "mpv.conf", text = "", fg = "#3b1342" },
	{ name = "node_modules", text = "", fg = "#e8274b" },
	{ name = "nuxt.config.cjs", text = "󱄆", fg = "#00c58e" },
	{ name = "nuxt.config.js", text = "󱄆", fg = "#00c58e" },
	{ name = "nuxt.config.mjs", text = "󱄆", fg = "#00c58e" },
	{ name = "nuxt.config.ts", text = "󱄆", fg = "#00c58e" },
	{ name = "package-lock.json", text = "", fg = "#7a0d21" },
	{ name = "package.json", text = "", fg = "#e8274b" },
	{ name = "PKGBUILD", text = "", fg = "#0f94d2" },
	{ name = "platformio.ini", text = "", fg = "#f6822b" },
	{ name = "pom.xml", text = "", fg = "#7a0d21" },
	{ name = "prettier.config.cjs", text = "", fg = "#4285f4" },
	{ name = "prettier.config.js", text = "", fg = "#4285f4" },
	{ name = "prettier.config.mjs", text = "", fg = "#4285f4" },
	{ name = "prettier.config.ts", text = "", fg = "#4285f4" },
	{ name = "procfile", text = "", fg = "#a074c4" },
	{ name = "PrusaSlicer.ini", text = "", fg = "#ec6b23" },
	{ name = "PrusaSlicerGcodeViewer.ini", text = "", fg = "#ec6b23" },
	{ name = "py.typed", text = "", fg = "#ffbc03" },
	{ name = "QtProject.conf", text = "", fg = "#40cd52" },
	{ name = "rakefile", text = "", fg = "#701516" },
	{ name = "rmd", text = "", fg = "#519aba" },
	{ name = "robots.txt", text = "󰚩", fg = "#5d7096" },
	{ name = "security", text = "󰒃", fg = "#bec4c9" },
	{ name = "security.md", text = "󰒃", fg = "#bec4c9" },
	{ name = "settings.gradle", text = "", fg = "#005f87" },
	{ name = "svelte.config.js", text = "", fg = "#ff3e00" },
	{ name = "sxhkdrc", text = "", fg = "#2f2f2f" },
	{ name = "sym-lib-table", text = "", fg = "#ffffff" },
	{ name = "tailwind.config.js", text = "󱏿", fg = "#20c2e3" },
	{ name = "tailwind.config.mjs", text = "󱏿", fg = "#20c2e3" },
	{ name = "tailwind.config.ts", text = "󱏿", fg = "#20c2e3" },
	{ name = "tmux.conf", text = "", fg = "#14ba19" },
	{ name = "tmux.conf.local", text = "", fg = "#14ba19" },
	{ name = "tsconfig.json", text = "", fg = "#519aba" },
	{ name = "unlicense", text = "", fg = "#d0bf41" },
	{ name = "vagrantfile$", text = "", fg = "#1563ff" },
	{ name = "vercel.json", text = "▲", fg = "#ffffff" },
	{ name = "vlcrc", text = "󰕼", fg = "#ee7a00" },
	{ name = "webpack", text = "󰜫", fg = "#519aba" },
	{ name = "weston.ini", text = "", fg = "#ffbb01" },
	{ name = "workspace", text = "", fg = "#89e051" },
	{ name = "xmobarrc", text = "", fg = "#fd4d5d" },
	{ name = "xmobarrc.hs", text = "", fg = "#fd4d5d" },
	{ name = "xmonad.hs", text = "", fg = "#fd4d5d" },
	{ name = "xorg.conf", text = "", fg = "#e54d18" },
	{ name = "xsettingsd.conf", text = "", fg = "#e54d18" },
]
exts = [
	{ name = "3gp", text = "", fg = "#fd971f" },
	{ name = "3mf", text = "󰆧", fg = "#888888" },
	{ name = "7z", text = "", fg = "#eca517" },
	{ name = "a", text = "", fg = "#dcddd6" },
	{ name = "aac", text = "", fg = "#00afff" },
	{ name = "ai", text = "", fg = "#cbcb41" },
	{ name = "aif", text = "", fg = "#00afff" },
	{ name = "aiff", text = "", fg = "#00afff" },
	{ name = "android", text = "", fg = "#34a853" },
	{ name = "ape", text = "", fg = "#00afff" },
	{ name = "apk", text = "", fg = "#34a853" },
	{ name = "apl", text = "⍝", fg = "#ffa500" },
	{ name = "app", text = "", fg = "#9f0500" },
	{ name = "applescript", text = "", fg = "#6d8085" },
	{ name = "asc", text = "󰦝", fg = "#576d7f" },
	{ name = "ass", text = "󰨖", fg = "#ffb713" },
	{ name = "astro", text = "", fg = "#e23f67" },
	{ name = "awk", text = "", fg = "#4d5a5e" },
	{ name = "azcli", text = "", fg = "#0078d4" },
	{ name = "bak", text = "󰁯", fg = "#6d8086" },
	{ name = "bash", text = "", fg = "#89e051" },
	{ name = "bat", text = "", fg = "#c1f12e" },
	{ name = "bazel", text = "", fg = "#89e051" },
	{ name = "bib", text = "󱉟", fg = "#cbcb41" },
	{ name = "bicep", text = "", fg = "#519aba" },
	{ name = "bicepparam", text = "", fg = "#9f74b3" },
	{ name = "bin", text = "", fg = "#9f0500" },
	{ name = "blade.php", text = "", fg = "#f05340" },
	{ name = "blend", text = "󰂫", fg = "#ea7600" },
	{ name = "blp", text = "󰺾", fg = "#5796e2" },
	{ name = "bmp", text = "", fg = "#a074c4" },
	{ name = "bqn", text = "⎉", fg = "#2b7067" },
	{ name = "brep", text = "󰻫", fg = "#839463" },
	{ name = "bz", text = "", fg = "#eca517" },
	{ name = "bz2", text = "", fg = "#eca517" },
	{ name = "bz3", text = "", fg = "#eca517" },
	{ name = "bzl", text = "", fg = "#89e051" },
	{ name = "c", text = "", fg = "#599eff" },
	{ name = "c++", text = "", fg = "#f34b7d" },
	{ name = "cache", text = "", fg = "#ffffff" },
	{ name = "cast", text = "", fg = "#fd971f" },
	{ name = "cbl", text = "⚙", fg = "#005ca5" },
	{ name = "cc", text = "", fg = "#f34b7d" },
	{ name = "ccm", text = "", fg = "#f34b7d" },
	{ name = "cfg", text = "", fg = "#6d8086" },
	{ name = "cjs", text = "", fg = "#cbcb41" },
	{ name = "clj", text = "", fg = "#8dc149" },
	{ name = "cljc", text = "", fg = "#8dc149" },
	{ name = "cljd", text = "", fg = "#519aba" },
	{ name = "cljs", text = "", fg = "#519aba" },
	{ name = "cmake", text = "", fg = "#6d8086" },
	{ name = "cob", text = "⚙", fg = "#005ca5" },
	{ name = "cobol", text = "⚙", fg = "#005ca5" },
	{ name = "coffee", text = "", fg = "#cbcb41" },
	{ name = "conf", text = "", fg = "#6d8086" },
	{ name = "config.ru", text = "", fg = "#701516" },
	{ name = "cow", text = "󰆚", fg = "#965824" },
	{ name = "cp", text = "", fg = "#519aba" },
	{ name = "cpp", text = "", fg = "#519aba" },
	{ name = "cppm", text = "", fg = "#519aba" },
	{ name = "cpy", text = "⚙", fg = "#005ca5" },
	{ name = "cr", text = "", fg = "#c8c8c8" },
	{ name = "crdownload", text = "", fg = "#44cda8" },
	{ name = "cs", text = "󰌛", fg = "#596706" },
	{ name = "csh", text = "", fg = "#4d5a5e" },
	{ name = "cshtml", text = "󱦗", fg = "#512bd4" },
	{ name = "cson", text = "", fg = "#cbcb41" },
	{ name = "csproj", text = "󰪮", fg = "#512bd4" },
	{ name = "css", text = "", fg = "#42a5f5" },
	{ name = "csv", text = "", fg = "#89e051" },
	{ name = "cts", text = "", fg = "#519aba" },
	{ name = "cu", text = "", fg = "#89e051" },
	{ name = "cue", text = "󰲹", fg = "#ed95ae" },
	{ name = "cuh", text = "", fg = "#a074c4" },
	{ name = "cxx", text = "", fg = "#519aba" },
	{ name = "cxxm", text = "", fg = "#519aba" },
	{ name = "d", text = "", fg = "#427819" },
	{ name = "d.ts", text = "", fg = "#d59855" },
	{ name = "dart", text = "", fg = "#03589c" },
	{ name = "db", text = "", fg = "#dad8d8" },
	{ name = "dconf", text = "", fg = "#ffffff" },
	{ name = "desktop", text = "", fg = "#563d7c" },
	{ name = "diff", text = "", fg = "#41535b" },
	{ name = "dll", text = "", fg = "#4d2c0b" },
	{ name = "doc", text = "󰈬", fg = "#185abd" },
	{ name = "Dockerfile", text = "󰡨", fg = "#458ee6" },
	{ name = "docx", text = "󰈬", fg = "#185abd" },
	{ name = "dot", text = "󱁉", fg = "#30638e" },
	{ name = "download", text = "", fg = "#44cda8" },
	{ name = "drl", text = "", fg = "#ffafaf" },
	{ name = "dropbox", text = "", fg = "#0061fe" },
	{ name = "dump", text = "", fg = "#dad8d8" },
	{ name = "dwg", text = "󰻫", fg = "#839463" },
	{ name = "dxf", text = "󰻫", fg = "#839463" },
	{ name = "ebook", text = "", fg = "#eab16d" },
	{ name = "ebuild", text = "", fg = "#4c416e" },
	{ name = "edn", text = "", fg = "#519aba" },
	{ name = "eex", text = "", fg = "#a074c4" },
	{ name = "ejs", text = "", fg = "#cbcb41" },
	{ name = "el", text = "", fg = "#8172be" },
	{ name = "elc", text = "", fg = "#8172be" },
	{ name = "elf", text = "", fg = "#9f0500" },
	{ name = "elm", text = "", fg = "#519aba" },
	{ name = "eln", text = "", fg = "#8172be" },
	{ name = "env", text = "", fg = "#faf743" },
	{ name = "eot", text = "", fg = "#ececec" },
	{ name = "epp", text = "", fg = "#ffa61a" },
	{ name = "epub", text = "", fg = "#eab16d" },
	{ name = "erb", text = "", fg = "#701516" },
	{ name = "erl", text = "", fg = "#b83998" },
	{ name = "ex", text = "", fg = "#a074c4" },
	{ name = "exe", text = "", fg = "#9f0500" },
	{ name = "exs", text = "", fg = "#a074c4" },
	{ name = "f#", text = "", fg = "#519aba" },
	{ name = "f3d", text = "󰻫", fg = "#839463" },
	{ name = "f90", text = "󱈚", fg = "#734f96" },
	{ name = "fbx", text = "󰆧", fg = "#888888" },
	{ name = "fcbak", text = "", fg = "#cb333b" },
	{ name = "fcmacro", text = "", fg = "#cb333b" },
	{ name = "fcmat", text = "", fg = "#cb333b" },
	{ name = "fcparam", text = "", fg = "#cb333b" },
	{ name = "fcscript", text = "", fg = "#cb333b" },
	{ name = "fcstd", text = "", fg = "#cb333b" },
	{ name = "fcstd1", text = "", fg = "#cb333b" },
	{ name = "fctb", text = "", fg = "#cb333b" },
	{ name = "fctl", text = "", fg = "#cb333b" },
	{ name = "fdmdownload", text = "", fg = "#44cda8" },
	{ name = "fish", text = "", fg = "#4d5a5e" },
	{ name = "flac", text = "", fg = "#0075aa" },
	{ name = "flc", text = "", fg = "#ececec" },
	{ name = "flf", text = "", fg = "#ececec" },
	{ name = "fnl", text = "", fg = "#fff3d7" },
	{ name = "fs", text = "", fg = "#519aba" },
	{ name = "fsi", text = "", fg = "#519aba" },
	{ name = "fsscript", text = "", fg = "#519aba" },
	{ name = "fsx", text = "", fg = "#519aba" },
	{ name = "gcode", text = "󰐫", fg = "#1471ad" },
	{ name = "gd", text = "", fg = "#6d8086" },
	{ name = "gemspec", text = "", fg = "#701516" },
	{ name = "gif", text = "", fg = "#a074c4" },
	{ name = "git", text = "", fg = "#f14c28" },
	{ name = "glb", text = "", fg = "#ffb13b" },
	{ name = "gleam", text = "", fg = "#ffaff3" },
	{ name = "gnumakefile", text = "", fg = "#6d8086" },
	{ name = "go", text = "", fg = "#519aba" },
	{ name = "godot", text = "", fg = "#6d8086" },
	{ name = "gql", text = "", fg = "#e535ab" },
	{ name = "gradle", text = "", fg = "#005f87" },
	{ name = "graphql", text = "", fg = "#e535ab" },
	{ name = "gresource", text = "", fg = "#ffffff" },
	{ name = "gv", text = "󱁉", fg = "#30638e" },
	{ name = "gz", text = "", fg = "#eca517" },
	{ name = "h", text = "", fg = "#a074c4" },
	{ name = "haml", text = "", fg = "#eaeae1" },
	{ name = "hbs", text = "", fg = "#f0772b" },
	{ name = "heex", text = "", fg = "#a074c4" },
	{ name = "hex", text = "", fg = "#2e63ff" },
	{ name = "hh", text = "", fg = "#a074c4" },
	{ name = "hpp", text = "", fg = "#a074c4" },
	{ name = "hrl", text = "", fg = "#b83998" },
	{ name = "hs", text = "", fg = "#a074c4" },
	{ name = "htm", text = "", fg = "#e34c26" },
	{ name = "html", text = "", fg = "#e44d26" },
	{ name = "http", text = "", fg = "#008ec7" },
	{ name = "huff", text = "󰡘", fg = "#4242c7" },
	{ name = "hurl", text = "", fg = "#ff0288" },
	{ name = "hx", text = "", fg = "#ea8220" },
	{ name = "hxx", text = "", fg = "#a074c4" },
	{ name = "ical", text = "", fg = "#2b2e83" },
	{ name = "icalendar", text = "", fg = "#2b2e83" },
	{ name = "ico", text = "", fg = "#cbcb41" },
	{ name = "ics", text = "", fg = "#2b2e83" },
	{ name = "ifb", text = "", fg = "#2b2e83" },
	{ name = "ifc", text = "󰻫", fg = "#839463" },
	{ name = "ige", text = "󰻫", fg = "#839463" },
	{ name = "iges", text = "󰻫", fg = "#839463" },
	{ name = "igs", text = "󰻫", fg = "#839463" },
	{ name = "image", text = "", fg = "#d0bec8" },
	{ name = "img", text = "", fg = "#d0bec8" },
	{ name = "import", text = "", fg = "#ececec" },
	{ name = "info", text = "", fg = "#ffffcd" },
	{ name = "ini", text = "", fg = "#6d8086" },
	{ name = "ino", text = "", fg = "#56b6c2" },
	{ name = "ipynb", text = "", fg = "#51a0cf" },
	{ name = "iso", text = "", fg = "#d0bec8" },
	{ name = "ixx", text = "", fg = "#519aba" },
	{ name = "java", text = "", fg = "#cc3e44" },
	{ name = "jl", text = "", fg = "#a270ba" },
	{ name = "jpeg", text = "", fg = "#a074c4" },
	{ name = "jpg", text = "", fg = "#a074c4" },
	{ name = "js", text = "", fg = "#cbcb41" },
	{ name = "json", text = "", fg = "#cbcb41" },
	{ name = "json5", text = "", fg = "#cbcb41" },
	{ name = "jsonc", text = "", fg = "#cbcb41" },
	{ name = "jsx", text = "", fg = "#20c2e3" },
	{ name = "jwmrc", text = "", fg = "#0078cd" },
	{ name = "jxl", text = "", fg = "#a074c4" },
	{ name = "kbx", text = "󰯄", fg = "#737672" },
	{ name = "kdb", text = "", fg = "#529b34" },
	{ name = "kdbx", text = "", fg = "#529b34" },
	{ name = "kdenlive", text = "", fg = "#83b8f2" },
	{ name = "kdenlivetitle", text = "", fg = "#83b8f2" },
	{ name = "kicad_dru", text = "", fg = "#ffffff" },
	{ name = "kicad_mod", text = "", fg = "#ffffff" },
	{ name = "kicad_pcb", text = "", fg = "#ffffff" },
	{ name = "kicad_prl", text = "", fg = "#ffffff" },
	{ name = "kicad_pro", text = "", fg = "#ffffff" },
	{ name = "kicad_sch", text = "", fg = "#ffffff" },
	{ name = "kicad_sym", text = "", fg = "#ffffff" },
	{ name = "kicad_wks", text = "", fg = "#ffffff" },
	{ name = "ko", text = "", fg = "#dcddd6" },
	{ name = "kpp", text = "", fg = "#f245fb" },
	{ name = "kra", text = "", fg = "#f245fb" },
	{ name = "krz", text = "", fg = "#f245fb" },
	{ name = "ksh", text = "", fg = "#4d5a5e" },
	{ name = "kt", text = "", fg = "#7f52ff" },
	{ name = "kts", text = "", fg = "#7f52ff" },
	{ name = "lck", text = "", fg = "#bbbbbb" },
	{ name = "leex", text = "", fg = "#a074c4" },
	{ name = "less", text = "", fg = "#563d7c" },
	{ name = "lff", text = "", fg = "#ececec" },
	{ name = "lhs", text = "", fg = "#a074c4" },
	{ name = "lib", text = "", fg = "#4d2c0b" },
	{ name = "license", text = "", fg = "#cbcb41" },
	{ name = "liquid", text = "", fg = "#95bf47" },
	{ name = "lock", text = "", fg = "#bbbbbb" },
	{ name = "log", text = "󰌱", fg = "#dddddd" },
	{ name = "lrc", text = "󰨖", fg = "#ffb713" },
	{ name = "lua", text = "", fg = "#51a0cf" },
	{ name = "luac", text = "", fg = "#51a0cf" },
	{ name = "luau", text = "", fg = "#00a2ff" },
	{ name = "m", text = "", fg = "#599eff" },
	{ name = "m3u", text = "󰲹", fg = "#ed95ae" },
	{ name = "m3u8", text = "󰲹", fg = "#ed95ae" },
	{ name = "m4a", text = "", fg = "#00afff" },
	{ name = "m4v", text = "", fg = "#fd971f" },
	{ name = "magnet", text = "", fg = "#a51b16" },
	{ name = "makefile", text = "", fg = "#6d8086" },
	{ name = "markdown", text = "", fg = "#dddddd" },
	{ name = "material", text = "󰔉", fg = "#b83998" },
	{ name = "md", text = "", fg = "#dddddd" },
	{ name = "md5", text = "󰕥", fg = "#8c86af" },
	{ name = "mdx", text = "", fg = "#519aba" },
	{ name = "mint", text = "󰌪", fg = "#87c095" },
	{ name = "mjs", text = "", fg = "#f1e05a" },
	{ name = "mk", text = "", fg = "#6d8086" },
	{ name = "mkv", text = "", fg = "#fd971f" },
	{ name = "ml", text = "", fg = "#e37933" },
	{ name = "mli", text = "", fg = "#e37933" },
	{ name = "mm", text = "", fg = "#519aba" },
	{ name = "mo", text = "∞", fg = "#9772fb" },
	{ name = "mobi", text = "", fg = "#eab16d" },
	{ name = "mojo", text = "", fg = "#ff4c1f" },
	{ name = "mov", text = "", fg = "#fd971f" },
	{ name = "mp3", text = "", fg = "#00afff" },
	{ name = "mp4", text = "", fg = "#fd971f" },
	{ name = "mpp", text = "", fg = "#519aba" },
	{ name = "msf", text = "", fg = "#137be1" },
	{ name = "mts", text = "", fg = "#519aba" },
	{ name = "mustache", text = "", fg = "#e37933" },
	{ name = "nfo", text = "", fg = "#ffffcd" },
	{ name = "nim", text = "", fg = "#f3d400" },
	{ name = "nix", text = "", fg = "#7ebae4" },
	{ name = "nswag", text = "", fg = "#85ea2d" },
	{ name = "nu", text = ">", fg = "#3aa675" },
	{ name = "o", text = "", fg = "#9f0500" },
	{ name = "obj", text = "󰆧", fg = "#888888" },
	{ name = "ogg", text = "", fg = "#0075aa" },
	{ name = "opus", text = "", fg = "#0075aa" },
	{ name = "org", text = "", fg = "#77aa99" },
	{ name = "otf", text = "", fg = "#ececec" },
	{ name = "out", text = "", fg = "#9f0500" },
	{ name = "part", text = "", fg = "#44cda8" },
	{ name = "patch", text = "", fg = "#41535b" },
	{ name = "pck", text = "", fg = "#6d8086" },
	{ name = "pcm", text = "", fg = "#0075aa" },
	{ name = "pdf", text = "", fg = "#b30b00" },
	{ name = "php", text = "", fg = "#a074c4" },
	{ name = "pl", text = "", fg = "#519aba" },
	{ name = "pls", text = "󰲹", fg = "#ed95ae" },
	{ name = "ply", text = "󰆧", fg = "#888888" },
	{ name = "pm", text = "", fg = "#519aba" },
	{ name = "png", text = "", fg = "#a074c4" },
	{ name = "po", text = "", fg = "#2596be" },
	{ name = "pot", text = "", fg = "#2596be" },
	{ name = "pp", text = "", fg = "#ffa61a" },
	{ name = "ppt", text = "󰈧", fg = "#cb4a32" },
	{ name = "prisma", text = "", fg = "#5a67d8" },
	{ name = "pro", text = "", fg = "#e4b854" },
	{ name = "ps1", text = "󰨊", fg = "#4273ca" },
	{ name = "psb", text = "", fg = "#519aba" },
	{ name = "psd", text = "", fg = "#519aba" },
	{ name = "psd1", text = "󰨊", fg = "#6975c4" },
	{ name = "psm1", text = "󰨊", fg = "#6975c4" },
	{ name = "pub", text = "󰷖", fg = "#e3c58e" },
	{ name = "pxd", text = "", fg = "#5aa7e4" },
	{ name = "pxi", text = "", fg = "#5aa7e4" },
	{ name = "py", text = "", fg = "#ffbc03" },
	{ name = "pyc", text = "", fg = "#ffe291" },
	{ name = "pyd", text = "", fg = "#ffe291" },
	{ name = "pyi", text = "", fg = "#ffbc03" },
	{ name = "pyo", text = "", fg = "#ffe291" },
	{ name = "pyw", text = "", fg = "#5aa7e4" },
	{ name = "pyx", text = "", fg = "#5aa7e4" },
	{ name = "qm", text = "", fg = "#2596be" },
	{ name = "qml", text = "", fg = "#40cd52" },
	{ name = "qrc", text = "", fg = "#40cd52" },
	{ name = "qss", text = "", fg = "#40cd52" },
	{ name = "query", text = "", fg = "#90a850" },
	{ name = "R", text = "󰟔", fg = "#2266ba" },
	{ name = "r", text = "󰟔", fg = "#2266ba" },
	{ name = "rake", text = "", fg = "#701516" },
	{ name = "rar", text = "", fg = "#eca517" },
	{ name = "razor", text = "󱦘", fg = "#512bd4" },
	{ name = "rb", text = "", fg = "#701516" },
	{ name = "res", text = "", fg = "#cc3e44" },
	{ name = "resi", text = "", fg = "#f55385" },
	{ name = "rlib", text = "", fg = "#dea584" },
	{ name = "rmd", text = "", fg = "#519aba" },
	{ name = "rproj", text = "󰗆", fg = "#358a5b" },
	{ name = "rs", text = "", fg = "#dea584" },
	{ name = "rss", text = "", fg = "#fb9d3b" },
	{ name = "sass", text = "", fg = "#f55385" },
	{ name = "sbt", text = "", fg = "#cc3e44" },
	{ name = "sc", text = "", fg = "#cc3e44" },
	{ name = "scad", text = "", fg = "#f9d72c" },
	{ name = "scala", text = "", fg = "#cc3e44" },
	{ name = "scm", text = "󰘧", fg = "#eeeeee" },
	{ name = "scss", text = "", fg = "#f55385" },
	{ name = "sh", text = "", fg = "#4d5a5e" },
	{ name = "sha1", text = "󰕥", fg = "#8c86af" },
	{ name = "sha224", text = "󰕥", fg = "#8c86af" },
	{ name = "sha256", text = "󰕥", fg = "#8c86af" },
	{ name = "sha384", text = "󰕥", fg = "#8c86af" },
	{ name = "sha512", text = "󰕥", fg = "#8c86af" },
	{ name = "sig", text = "λ", fg = "#e37933" },
	{ name = "signature", text = "λ", fg = "#e37933" },
	{ name = "skp", text = "󰻫", fg = "#839463" },
	{ name = "sldasm", text = "󰻫", fg = "#839463" },
	{ name = "sldprt", text = "󰻫", fg = "#839463" },
	{ name = "slim", text = "", fg = "#e34c26" },
	{ name = "sln", text = "", fg = "#854cc7" },
	{ name = "slvs", text = "󰻫", fg = "#839463" },
	{ name = "sml", text = "λ", fg = "#e37933" },
	{ name = "so", text = "", fg = "#dcddd6" },
	{ name = "sol", text = "", fg = "#519aba" },
	{ name = "spec.js", text = "", fg = "#cbcb41" },
	{ name = "spec.jsx", text = "", fg = "#20c2e3" },
	{ name = "spec.ts", text = "", fg = "#519aba" },
	{ name = "spec.tsx", text = "", fg = "#1354bf" },
	{ name = "sql", text = "", fg = "#dad8d8" },
	{ name = "sqlite", text = "", fg = "#dad8d8" },
	{ name = "sqlite3", text = "", fg = "#dad8d8" },
	{ name = "srt", text = "󰨖", fg = "#ffb713" },
	{ name = "ssa", text = "󰨖", fg = "#ffb713" },
	{ name = "ste", text = "󰻫", fg = "#839463" },
	{ name = "step", text = "󰻫", fg = "#839463" },
	{ name = "stl", text = "󰆧", fg = "#888888" },
	{ name = "stp", text = "󰻫", fg = "#839463" },
	{ name = "strings", text = "", fg = "#2596be" },
	{ name = "styl", text = "", fg = "#8dc149" },
	{ name = "sub", text = "󰨖", fg = "#ffb713" },
	{ name = "sublime", text = "", fg = "#e37933" },
	{ name = "suo", text = "", fg = "#854cc7" },
	{ name = "sv", text = "󰍛", fg = "#019833" },
	{ name = "svelte", text = "", fg = "#ff3e00" },
	{ name = "svg", text = "󰜡", fg = "#ffb13b" },
	{ name = "svh", text = "󰍛", fg = "#019833" },
	{ name = "swift", text = "", fg = "#e37933" },
	{ name = "t", text = "", fg = "#519aba" },
	{ name = "tbc", text = "󰛓", fg = "#1e5cb3" },
	{ name = "tcl", text = "󰛓", fg = "#1e5cb3" },
	{ name = "templ", text = "", fg = "#dbbd30" },
	{ name = "terminal", text = "", fg = "#31b53e" },
	{ name = "test.js", text = "", fg = "#cbcb41" },
	{ name = "test.jsx", text = "", fg = "#20c2e3" },
	{ name = "test.ts", text = "", fg = "#519aba" },
	{ name = "test.tsx", text = "", fg = "#1354bf" },
	{ name = "tex", text = "", fg = "#3d6117" },
	{ name = "tf", text = "", fg = "#5f43e9" },
	{ name = "tfvars", text = "", fg = "#5f43e9" },
	{ name = "tgz", text = "", fg = "#eca517" },
	{ name = "tmux", text = "", fg = "#14ba19" },
	{ name = "toml", text = "", fg = "#9c4221" },
	{ name = "torrent", text = "", fg = "#44cda8" },
	{ name = "tres", text = "", fg = "#6d8086" },
	{ name = "ts", text = "", fg = "#519aba" },
	{ name = "tscn", text = "", fg = "#6d8086" },
	{ name = "tsconfig", text = "", fg = "#ff8700" },
	{ name = "tsx", text = "", fg = "#1354bf" },
	{ name = "ttf", text = "", fg = "#ececec" },
	{ name = "twig", text = "", fg = "#8dc149" },
	{ name = "txt", text = "󰈙", fg = "#89e051" },
	{ name = "txz", text = "", fg = "#eca517" },
	{ name = "typoscript", text = "", fg = "#ff8700" },
	{ name = "ui", text = "", fg = "#015bf0" },
	{ name = "v", text = "󰍛", fg = "#019833" },
	{ name = "vala", text = "", fg = "#7239b3" },
	{ name = "vh", text = "󰍛", fg = "#019833" },
	{ name = "vhd", text = "󰍛", fg = "#019833" },
	{ name = "vhdl", text = "󰍛", fg = "#019833" },
	{ name = "vim", text = "", fg = "#019833" },
	{ name = "vsh", text = "", fg = "#5d87bf" },
	{ name = "vsix", text = "", fg = "#854cc7" },
	{ name = "vue", text = "", fg = "#8dc149" },
	{ name = "wasm", text = "", fg = "#5c4cdb" },
	{ name = "wav", text = "", fg = "#00afff" },
	{ name = "webm", text = "", fg = "#fd971f" },
	{ name = "webmanifest", text = "", fg = "#f1e05a" },
	{ name = "webp", text = "", fg = "#a074c4" },
	{ name = "webpack", text = "󰜫", fg = "#519aba" },
	{ name = "wma", text = "", fg = "#00afff" },
	{ name = "woff", text = "", fg = "#ececec" },
	{ name = "woff2", text = "", fg = "#ececec" },
	{ name = "wrl", text = "󰆧", fg = "#888888" },
	{ name = "wrz", text = "󰆧", fg = "#888888" },
	{ name = "wv", text = "", fg = "#00afff" },
	{ name = "wvc", text = "", fg = "#00afff" },
	{ name = "x", text = "", fg = "#599eff" },
	{ name = "xaml", text = "󰙳", fg = "#512bd4" },
	{ name = "xcf", text = "", fg = "#635b46" },
	{ name = "xcplayground", text = "", fg = "#e37933" },
	{ name = "xcstrings", text = "", fg = "#2596be" },
	{ name = "xls", text = "󰈛", fg = "#207245" },
	{ name = "xlsx", text = "󰈛", fg = "#207245" },
	{ name = "xm", text = "", fg = "#519aba" },
	{ name = "xml", text = "󰗀", fg = "#e37933" },
	{ name = "xpi", text = "", fg = "#ff1b01" },
	{ name = "xul", text = "", fg = "#e37933" },
	{ name = "xz", text = "", fg = "#eca517" },
	{ name = "yaml", text = "", fg = "#6d8086" },
	{ name = "yml", text = "", fg = "#6d8086" },
	{ name = "zig", text = "", fg = "#f69a1b" },
	{ name = "zip", text = "", fg = "#eca517" },
	{ name = "zsh", text = "", fg = "#89e051" },
	{ name = "zst", text = "", fg = "#eca517" },
	{ name = "🔥", text = "", fg = "#ff4c1f" },
]
conds = [
	# Special files
	{ if = "orphan", text = "" },
	{ if = "link", text = "" },
	{ if = "block", text = "" },
	{ if = "char", text = "" },
	{ if = "fifo", text = "" },
	{ if = "sock", text = "" },
	{ if = "sticky", text = "" },
	{ if = "dummy", text = "" },

	# Fallback
	{ if = "dir", text = "󰉋" },
	{ if = "exec", text = "" },
	{ if = "!dir", text = "󰈔" },
]

# : }}}
```
