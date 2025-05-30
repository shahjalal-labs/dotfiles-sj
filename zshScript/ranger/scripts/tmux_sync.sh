current_path="$1"
tmux_windows=$(tmux list-panes -F '#P')

for pane in $tmux_windows; do
    # Skip the current pane
    if [ "$pane" != "$(tmux display-message -p '#P')" ]; then
        tmux send-keys -t "$pane" "cd $current_path" C-m
    fi
done

