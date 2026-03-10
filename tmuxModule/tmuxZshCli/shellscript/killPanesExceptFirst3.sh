#!/usr/bin/env bash
# kill all panes except the first 3 => which are index 1,2,3

# Get pane index + pane id pairs
# Format: index:id
panes=$(tmux list-panes -F '#{pane_index}:#{pane_id}')

# Loop through panes
for pane in $panes; do
  index="${pane%%:*}"
  id="${pane##*:}"

  # Skip first three panes (index starts from 1)
  if [ "$index" -gt 3 ]; then
    tmux kill-pane -t "$id"
  fi
done

# Run tr function in pane 2 (index 2)
tmux send-keys -t 2 'tr' C-m
