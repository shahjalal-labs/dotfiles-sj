#!/usr/bin/env zsh
# ===================================================
# cd_pane_sync.sh
#
# Purpose:
#   Copy the current pane's working directory,
#   prompt for a target pane number, and:
#     - If the pane exists: switch focus and cd there
#     - If it doesn't exist: create a new pane, cd, focus it
#
# Usage:
#   Run in any Tmux pane manually, or bind via Tmux.
# ===================================================

# Get current pane path
current_path=$(tmux display-message -p -F "#{pane_current_path}")

# Target pane number from Tmux command-prompt argument
target_pane="$1"

# Check if target pane exists
if tmux list-panes -F "#{pane_index}" | grep -q "^$target_pane\$"; then
    tmux send-keys -t "$target_pane" "cd $current_path" C-m
    tmux select-pane -t "$target_pane"
else
    tmux split-window -t "$(tmux display-message -p '#{pane_id}')" -c "$current_path"
fi
