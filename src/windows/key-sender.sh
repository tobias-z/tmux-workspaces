#!/bin/bash

branch_name=$(basename $1)
session_name=$2
selected_path=$3
clean_name=$(echo $branch_name | tr "./" "__")
target="$session_name:$clean_name"

if ! tmux has-session -t $target 2> /dev/null; then
    tmux neww -dn $clean_name -t $session_name -c "$selected_path"
    sleep 1
fi

shift 3
tmux send-keys -t $target C-c C-d
tmux send-keys -t $target "$*" Enter
