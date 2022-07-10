#!/bin/bash

action=$1
specific_window=$2
selected_name=$(tmux display-message -p "#S")
path=$(dirname $(realpath $0))

if [ -n "$specific_window" ]; then
    script="$TW_CONFIG/$selected_name/$specific_window/$action.sh"

    if [ -e "$script" ]; then
        sh $path/../windows/key-sender.sh $specific_window $selected_name "source $script"
    fi
else
    sh $path/../windows/all-runner.sh $(tmux display-message -p "#S") $action
fi
