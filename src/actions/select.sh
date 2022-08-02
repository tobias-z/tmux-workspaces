#!/bin/bash

if [ $# -eq 1 ]; then
    selected=$1
else
    selected=$(find $TW_PATHS -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [ -z $selected ]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)
path=$(dirname $(realpath $0))

if [ -z $TMUX ] && [ -z $tmux_running ]; then
    tmux new-session -s $selected_name -c $selected -n $TW_MAIN_WINDOW
    exit 0
fi

initialize="0"

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected -n $TW_MAIN_WINDOW
    initialize="1"
fi

tmux switch-client -t $selected_name

if [ "$initialize" = "1" ]; then
    shift
    sh $path/../windows/all-runner.sh $selected_name $selected start $@
fi
