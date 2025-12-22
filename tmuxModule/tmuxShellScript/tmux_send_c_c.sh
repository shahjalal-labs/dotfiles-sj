#!/usr/bin/env bash

pane_number=$1
pane_number=${pane_number:-3}

tmux send-keys -t :.${pane_number} C-c
