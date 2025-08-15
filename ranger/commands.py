#w: 1╭──────────── Block Start ────────────╮
#w: 1╰───────────── Block End ─────────────╯

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


#w: 1╭──────────── Block Start ────────────╮
# open Neovim in current pane, create total 3 panes change cwd then run `clear`
from ranger.api.commands import Command
import time

class enter_nvim_sync_tmux(Command):
    """
    :enter_nvim_sync_tmux
    Open file in Neovim in current pane (Ranger pane),
    Pane 2 runs `cd <dir>`, `tr`, `clear`, others run `cd <dir>`, `clear`.
    If fewer than 3 panes exist, splits until 3.
    Focus stays on the Neovim pane.
    """
    def execute(self):
        fobj = self.fm.thisfile
        file_path = fobj.path

        # Determine target directory
        if fobj.is_directory:
            dir_path = file_path
        else:
            dir_path = os.path.dirname(file_path)

        try:
            # Get tmux session/window/pane info
            session = subprocess.check_output(
                ["tmux", "display-message", "-p", "#S"], text=True
            ).strip()
            window = subprocess.check_output(
                ["tmux", "display-message", "-p", "#I"], text=True
            ).strip()
            current_pane = subprocess.check_output(
                ["tmux", "display-message", "-p", "#{pane_id}"], text=True
            ).strip()

            # Count existing panes
            panes = subprocess.check_output(
                ["tmux", "list-panes", "-t", f"{session}:{window}", "-F", "#{pane_id}"],
                text=True
            ).splitlines()

            # If fewer than 3 panes, create more
            while len(panes) < 3:
                subprocess.run(["tmux", "split-window", "-t", f"{session}:{window}"])
                time.sleep(0.1)  # allow tmux to register new pane
                panes = subprocess.check_output(
                    ["tmux", "list-panes", "-t", f"{session}:{window}", "-F", "#{pane_id}"],
                    text=True
                ).splitlines()

            # Send commands to each pane except the current one
            for idx, pane in enumerate(panes):
                if pane == current_pane:
                    continue  # skip current pane (will run nvim)

                if idx == 1:  # pane 2
                    subprocess.run(["tmux", "send-keys", "-t", pane, f"cd '{dir_path}'", "C-m"])
                    subprocess.run(["tmux", "send-keys", "-t", pane, "tr", "C-m"])
                    subprocess.run(["tmux", "send-keys", "-t", pane, "clear", "C-m"])
                else:  # all other panes
                    subprocess.run(["tmux", "send-keys", "-t", pane, f"cd '{dir_path}'", "C-m"])
                    subprocess.run(["tmux", "send-keys", "-t", pane, "clear", "C-m"])

            # Force focus back to current pane before opening nvim
            subprocess.run(["tmux", "select-pane", "-t", current_pane])

        except subprocess.CalledProcessError:
            self.fm.notify("❌ tmux not detected or command failed", bad=True)

        # Open Neovim in the current Ranger pane
        self.fm.run(["nvim", file_path])
#w: 1╰───────────── Block End ─────────────╯

#
# 
#

#w: 1╭──────────── Block Start ────────────╮
# open Nvim in current pane, create total 3 panes change cwd then run `bun run dev` if React/Next.js project
from ranger.api.commands import Command
import json
import time

class enter_nvim_with_bun(Command):
    """
    :enter_nvim_with_bun
    Open file in Neovim in current pane.
    Pane 2 runs `cd <dir> && tr && clear`.
    Pane 3 runs `cd <dir>` and if React/Next.js project, `bun run dev`.
    Ensures at least 3 panes exist. Focus stays in Neovim pane.
    """
    
    def detect_react_next(self, path):
        """Return True if path contains a React or Next.js project"""
        package_json_path = os.path.join(path, "package.json")
        if not os.path.exists(package_json_path):
            return False

        try:
            with open(package_json_path) as f:
                data = json.load(f)
        except Exception:
            return False

        deps = data.get("dependencies", {})
        dev_deps = data.get("devDependencies", {})

        if "react" in deps or "react" in dev_deps:
            return True
        if "next" in deps or "next" in dev_deps:
            return True
        return False

    def execute(self):
        fobj = self.fm.thisfile
        file_path = fobj.path

        # Determine directory to cd into
        if fobj.is_directory:
            dir_path = file_path
        else:
            dir_path = os.path.dirname(file_path)

        # Detect project type
        is_react_next = self.detect_react_next(dir_path)

        try:
            # Tmux session/window/pane info
            session = subprocess.check_output(["tmux", "display-message", "-p", "#S"], text=True).strip()
            window = subprocess.check_output(["tmux", "display-message", "-p", "#I"], text=True).strip()
            current_pane = subprocess.check_output(["tmux", "display-message", "-p", "#{pane_id}"], text=True).strip()

            # List panes
            panes = subprocess.check_output(
                ["tmux", "list-panes", "-t", f"{session}:{window}", "-F", "#{pane_id}"], text=True
            ).splitlines()

            # Ensure at least 3 panes
            while len(panes) < 3:
                subprocess.run(["tmux", "split-window", "-t", f"{session}:{window}"])
                time.sleep(0.1)
                panes = subprocess.check_output(
                    ["tmux", "list-panes", "-t", f"{session}:{window}", "-F", "#{pane_id}"], text=True
                ).splitlines()

            # Send commands to panes
            for idx, pane in enumerate(panes):
                if pane == current_pane:
                    continue

                if idx == 1:  # Pane 2
                    subprocess.run(["tmux", "send-keys", "-t", pane, f"cd '{dir_path}'", "C-m"])
                    subprocess.run(["tmux", "send-keys", "-t", pane, "tr", "C-m"])
                    subprocess.run(["tmux", "send-keys", "-t", pane, "clear", "C-m"])
                elif idx == 2:  # Pane 3
                    subprocess.run(["tmux", "send-keys", "-t", pane, f"cd '{dir_path}'", "C-m"])
                    if is_react_next:
                        subprocess.run(["tmux", "send-keys", "-t", pane, "bun run dev", "C-m"])
                    else:
                        subprocess.run(["tmux", "send-keys", "-t", pane, "clear", "C-m"])
                else:  # Any other pane
                    subprocess.run(["tmux", "send-keys", "-t", pane, f"cd '{dir_path}'", "C-m"])
                    subprocess.run(["tmux", "send-keys", "-t", pane, "clear", "C-m"])

            # Focus back to current pane
            subprocess.run(["tmux", "select-pane", "-t", current_pane])

        except subprocess.CalledProcessError:
            self.fm.notify("❌ tmux not detected or command failed", bad=True)

        # Open Neovim in current pane
        self.fm.run(["nvim", file_path])
#w: 1╰───────────── Block End ─────────────╯


