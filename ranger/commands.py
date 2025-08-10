
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
