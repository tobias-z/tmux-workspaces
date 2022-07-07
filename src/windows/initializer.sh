#!/bin/bash

workspace_dir=$(echo "$TMUX_WORKSPACES")
selected_name=$1

session_initializer_dir="$workspace_dir/$selected_name"

if [ ! -d "$session_initializer_dir" ]; then
    exit 0
fi

for dir in $session_initializer_dir/*; do
    start_file="$dir/start.sh"
    if [ -e "$dir/start.sh" ]; then
        sh $start_file
    fi
done
