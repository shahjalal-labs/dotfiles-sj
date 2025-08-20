#!/bin/bash
session=$(tmux list-sessions -F "#{session_last_attached} #{session_name}" | sort -nr | awk 'NR==3 {print $2}')
tmux switch-client -t "$session"
