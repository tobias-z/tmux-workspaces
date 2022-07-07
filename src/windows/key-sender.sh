#!/bin/bash

branch_name=$(basename $1)
session_name=$2
clean_name=$(echo $branch_name | tr "./" "__")
target="$session_name:$clean_name"

if ! tmux has-session -t $target 2> /dev/null; then
    tmux neww -dn $clean_name -t $session_name
fi

shift 2
tmux send-keys -t $target "$*" Enter
