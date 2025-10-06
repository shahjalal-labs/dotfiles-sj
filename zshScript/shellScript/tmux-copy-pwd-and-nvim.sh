#!/usr/bin/env bash

# 🧠 Task Summary:
# This script is triggered via a Tmux keybinding.
# It:
# 1. Captures the current pane's working directory
# 2. Prompts for a target pane number (with fallback to default: 1)
# 3. If the pane doesn't exist → creates a new one
# 4. Sends `cd <pwd> && nvim` to the target pane
# 5. Focuses that target pane after sending the command

# 📂 Step 1: Get the working directory of the current pane
pwd=$(tmux display -p -F "#{pane_current_path}")

if [ -z "$pwd" ]; then
  tmux display-message "❌ Failed to get working directory."
  exit 1
fi

# 📝 Step 2: Use a temporary file to store the user input
tmpfile="/tmp/tmux-pane-input-$$"
echo "" > "$tmpfile"

# 🧾 Step 3: Prompt user to enter target pane number
tmux command-prompt -p "Target Pane (default: 1):" \
  "run-shell 'echo %% > $tmpfile'"

# ⏳ Step 4: Wait a moment for prompt to finish
sleep 0.3

# 📖 Step 5: Read the entered value
pane=$(cat "$tmpfile" 2>/dev/null || echo "")
rm -f "$tmpfile"

# 🔁 Step 6: Use pane 1 if no input was given
[ -z "$pane" ] && pane="1"

# 🛠️ Step 7: Check if the target pane exists
if ! tmux list-panes -F '#{pane_index}' | grep -q "^$pane$"; then
  tmux display-message "⚠️ Pane $pane not found. Creating a new one..."
  pane=$(tmux split-window -v -P -F "#{pane_index}")
fi

# 🚀 Step 8: Send the command to the chosen or created pane
tmux send-keys -t "$pane" "cd \"$pwd\" && nvim" C-m

# 🎯 Step 9: Focus the target pane
tmux select-pane -t "$pane"

