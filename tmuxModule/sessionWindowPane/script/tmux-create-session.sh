#!/usr/bin/env bash
set -euo pipefail

SESSION="${1:-}"
[ -z "$SESSION" ] && exit 0

# read tmux pane base (0 or 1)
PANE_BASE=$(tmux show -gv pane-base-index 2>/dev/null || echo 0)

# helper: find a window index in session by its name
# prints nothing if not found
get_win_index() {
  local session="$1"; local name="$2"
  tmux list-windows -t "$session" -F '#{window_index} #{window_name}' 2>/dev/null \
    | awk -v nm="$name" '$2==nm {print $1; exit}'
}

# create-or-find-window and return its index in WIN_IDX var
create_or_find_window() {
  local session="$1"; local name="$2"
  WIN_IDX=$(get_win_index "$session" "$name" || true)
  if [ -z "$WIN_IDX" ]; then
    tmux new-window -t "$session" -n "$name"
    # give tmux a tiny moment to register the new window
    sleep 0.02
    WIN_IDX=$(get_win_index "$session" "$name")
  fi
  echo "$WIN_IDX"
}

# create 3 vertically stacked panes in window (by window index),
# run zsh in the FIRST pane (pane base index), and select that pane.
setup_window_panes() {
  local session="$1"; local win_idx="$2"

  # ensure the window is selected before splitting
  tmux select-window -t "${session}:${win_idx}"

  # create two vertical splits (resulting 3 stacked panes)
  tmux split-window -v -t "${session}:${win_idx}"
  tmux split-window -v -t "${session}:${win_idx}"

  # allow tmux to settle
  sleep 0.06

  # make them even vertical for predictable layout
  tmux select-layout -t "${session}:${win_idx}" even-vertical || true

  # send zsh command to the first pane (respect pane-base-index)
  tmux send-keys -t "${session}:${win_idx}.${PANE_BASE}" "zsh -i -c tr" C-m

  # ensure focus on that first pane inside the window
  tmux select-pane -t "${session}:${win_idx}.${PANE_BASE}"
}

# if session exists just switch to it and exit
if tmux has-session -t "$SESSION" 2>/dev/null; then
  tmux switch-client -t "$SESSION"
  exit 0
fi

# create session with first window named after the session
tmux new-session -d -s "$SESSION" -n "$SESSION"

# find index of first window (the one we just created)
FIRST_IDX=$(get_win_index "$SESSION" "$SESSION")
if [ -z "$FIRST_IDX" ]; then
  echo "Failed to find newly created window for session $SESSION" >&2
  exit 1
fi

# setup first window panes
setup_window_panes "$SESSION" "$FIRST_IDX"

# create and setup windows "2" and "3"
for WIN_NAME in 2 3; do
  NEW_IDX=$(create_or_find_window "$SESSION" "$WIN_NAME")
  setup_window_panes "$SESSION" "$NEW_IDX"
done

# finally, ensure we're focused on first window first pane then switch client
tmux select-window -t "${SESSION}:${FIRST_IDX}"
tmux select-pane -t "${SESSION}:${FIRST_IDX}.${PANE_BASE}"
sleep 0.05
tmux switch-client -t "$SESSION"

