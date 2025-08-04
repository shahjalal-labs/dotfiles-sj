
#!/bin/bash

# If $1 is passed, use its dirname, otherwise use current pane's CWD
if [[ -n "$1" ]]; then
  DIR="$(realpath "$1")"
else
  DIR="$PWD"
fi

LAYOUT="main-horizontal"
REACT_MARKER="bun.lockb"

# Check if it's a React project
if [[ ! -f "$DIR/$REACT_MARKER" && ! -f "$DIR/package.json" ]]; then
  echo "Not a React project in $DIR" && exit 1
fi

# Get current tmux session and window
SESSION=$(tmux display-message -p '#S')
WINDOW=$(tmux display-message -p '#I')

# Count panes
PANE_COUNT=$(tmux list-panes | wc -l)

# If less than 3 panes, create them
if [ "$PANE_COUNT" -lt 3 ]; then
  tmux split-window -v -c "$DIR"    # Pane 2
  tmux split-window -h -t "${SESSION}:${WINDOW}.1" -c "$DIR"  # Pane 3
fi

# Reapply layout
tmux select-layout "$LAYOUT"

# Send commands
tmux send-keys -t "${SESSION}:${WINDOW}.1" "cd '$DIR' && nvim ." C-m
tmux send-keys -t "${SESSION}:${WINDOW}.2" "cd '$DIR' && yazi" C-m
tmux send-keys -t "${SESSION}:${WINDOW}.3" "cd '$DIR' && bun run dev" C-m

