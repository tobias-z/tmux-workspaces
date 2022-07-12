#!/bin/bash

branch_name=$(basename $1)
session_name=$2
clean_name=$(echo $branch_name | tr "./" "__")
target="$session_name:$clean_name"

if ! tmux has-session -t $target 2> /dev/null; then
    selected_path=$3
    tmux neww -dn $clean_name -t $session_name -c "$selected_path"
    shift
    sleep 1
fi

shift 2

if [ "$branch_name" = "$TW_MAIN_WINDOW" ]; then
    shift
fi

tmux send-keys -t $target C-c
tmux send-keys -t $target "$*" Enter
