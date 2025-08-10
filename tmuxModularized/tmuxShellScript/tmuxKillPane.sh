#!/bin/bash

# tmuxKillPane.sh - Interactive pane killer for tmux popup
# Save to: /home/sj/.config/tmux/tmuxShellScript/tmuxKillPane.sh

# Show current panes
echo "Current panes:"
tmux list-panes -F "#{pane_index}: #{pane_title}" -t "$TMUX_PANE"
echo ""

# Prompt for input
echo -n "Kill pane [current]: "
read pane_input

# Handle input
if [[ -z "$pane_input" ]]; then
    # Empty - kill current pane
    tmux kill-pane -t "$TMUX_PANE"
    echo "Killed current pane"
elif [[ "$pane_input" =~ ^[0-9]+$ ]]; then
    # Numeric input - kill specific pane
    if tmux kill-pane -t ".$pane_input" 2>/dev/null; then
        echo "Killed pane $pane_input"
    else
        echo "Error: Pane $pane_input not found"
    fi
else
    echo "Cancelled"
fi

# Brief pause to see the result
sleep 0.3
