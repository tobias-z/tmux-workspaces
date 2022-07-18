#!/bin/bash

action=$1
specific_window=$2
selected_name=$(tmux display-message -p "#S")
path=$(dirname $(realpath $0))

if [ -n "$specific_window" ]; then
    script="$TW_CONFIG/$selected_name/$specific_window/$action.sh"

    if [ -e "$script" ]; then
        sh $path/../windows/key-sender.sh $specific_window $selected_name "source $script"
    else
        main_window="$TW_CONFIG/$selected_name/$TW_MAIN_WINDOW"
        if [ ! -d "$main_window" ]; then
            if [[ $action == "start" ]]; then
                sh $path/../windows/key-sender.sh $main_window $selected_name $selected_path "envmain"
            fi
        fi
    fi
else
    sh $path/../windows/all-runner.sh $selected_name "unused" $action
fi
