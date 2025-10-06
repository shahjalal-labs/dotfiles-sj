#!/usr/bin/env zsh

# Get the current session name
current_session=$(tmux display-message -p '#S')

# Get list of all sessions (excluding the current one)
sessions=(${(f)"$(tmux list-sessions -F '#S' | grep -v "^$current_session$")"})

if (( ${#sessions} == 0 )); then
    # No other sessions exist - create a new one before killing current
    new_session="session-$(date +%s)"
    tmux new-session -d -s "$new_session"
    tmux switch-client -t "$new_session"
else
    # Switch to the most recently used session (other than current)
    tmux switch-client -l
fi

# Now kill the original session
tmux kill-session -t "$current_session"
