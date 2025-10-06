#!/usr/bin/env bash

# 🧠 Task Summary:
# This script:
# 1. Captures the current pane's working directory
# 2. Prompts for a target pane number (default: 1)
# 3. Sends 'cd <pwd>' to ALL panes in current window
# 4. If target pane doesn't exist → creates one
# 5. Sends 'nvim' in target pane
# 6. Focuses the target pane

# 📂 Step 1: Get the working directory of the current pane
pwd=$(tmux display -p -F "#{pane_current_path}")
window_id=$(tmux display -p "#{window_id}")

if [ -z "$pwd" ]; then
  tmux display-message "❌ Failed to get working directory."
  exit 1
fi

# 📝 Step 2: Temporary file to hold user input
tmpfile="/tmp/tmux-pane-input-$$"
echo "" > "$tmpfile"

# 🧾 Step 3: Prompt user for target pane
tmux command-prompt -p "Target Pane (default: 1):" \
  "run-shell 'echo %% > $tmpfile'"

# ⏳ Step 4: Wait for input to complete
sleep 0.3

# 📖 Step 5: Read user input or default
pane=$(cat "$tmpfile" 2>/dev/null || echo "")
rm -f "$tmpfile"
[ -z "$pane" ] && pane="1"

# 🔁 Step 6: Send `cd <pwd>` to all panes in the current window
for target_pane in $(tmux list-panes -t "$window_id" -F "#{pane_index}"); do
  tmux send-keys -t "$target_pane" "cd \"$pwd\"" C-m
done

# 🛠️ Step 7: Check if target pane exists; create if not
if ! tmux list-panes -t "$window_id" -F '#{pane_index}' | grep -q "^$pane$"; then
  tmux display-message "⚠️ Pane $pane not found. Creating a new one..."
  pane=$(tmux split-window -v -P -F "#{pane_index}")
fi

# 🚀 Step 8: Send `nvim` to the selected pane
tmux send-keys -t "$pane" "nvim" C-m

# 🎯 Step 9: Focus the target pane
tmux select-pane -t "$pane"

