#!/usr/bin/env bash

# kill all panes except the first 3 => which are index 1,2,3

# Get all pane indexes in the current window
panes=$(tmux list-panes -F '#{pane_index}')

for pane in $panes; do
  # Skip first three panes (1, 2, 3)
  if [ "$pane" -gt 3 ]; then
    tmux kill-pane -t "$pane"
  fi
done
