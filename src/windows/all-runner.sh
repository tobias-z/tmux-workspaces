#!/bin/bash

workspace_dir=$(echo "$TMUX_WORKSPACES")
selected_name=$1
action=$2

session_initializer_dir="$workspace_dir/$selected_name"

if [ ! -d "$session_initializer_dir" ]; then
    exit 0
fi

dir_name=$(dirname $0)

for dir in $session_initializer_dir/*; do
    sh $dir_name/key-sender.sh $dir $selected_name
    file="$dir/$action"
    if [ -e "$file" ]; then
        while read line; do
            sh $dir_name/key-sender.sh $dir $selected_name "$line"
        done < $file
    fi
done
