#!/usr/bin/env bash
# tm.sh: A simple tmux session manager

sessions=($(tmux list-sessions -F "#{session_name}"))
project=$(basename $(pwd))
if [[ " ${sessions[@]} " =~ " $project " ]]; then
    tmux attach-session -t $project
else
    tmux new-session -s $project
fi
