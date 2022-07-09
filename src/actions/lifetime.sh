#!/bin/bash

action=$1
specific_window=$2
selected_name=$(tmux display-message -p "#S")
path=$(dirname $(realpath $0))

if [ -n "$specific_window" ]; then
    script="$TMUX_WORKSPACES/$selected_name/$specific_window/$action"

    if [ -e "$script" ]; then
        while read line; do
            sh $path/../windows/key-sender.sh $specific_window $selected_name "$line"
        done < $script
    fi
else
    sh $path/../windows/all-runner.sh $(tmux display-message -p "#S") $action
fi
