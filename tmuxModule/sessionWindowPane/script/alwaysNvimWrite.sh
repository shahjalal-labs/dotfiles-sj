#!/usr/bin/env bash

SESSION="alwaysNvim"
FILE="/run/media/sj/developer/web/L1B11/textNvim.md"

# Check if tmux session exists
if ! tmux has-session -t "$SESSION" 2>/dev/null; then
    # Session doesn't exist → create it with Neovim
    tmux new-session -ds "$SESSION" "nvim +startinsert $FILE"
    tmux switch-client -t "$SESSION"
    exit 0
fi

# Session exists → check if nvim is running in any pane
NVIM_RUNNING=$(tmux list-panes -t "$SESSION" -F "#{pane_pid}" | xargs -I{} ps -o comm= -p {} | grep -w nvim)

if [[ -n "$NVIM_RUNNING" ]]; then
    # Neovim is running → just switch to the session
    tmux switch-client -t "$SESSION"
else
    # Neovim is not running → switch and start it
    tmux switch-client -t "$SESSION"
    tmux send-keys -t "$SESSION" "nvim +startinsert $FILE" C-m
fi

