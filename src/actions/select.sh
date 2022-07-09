#!/bin/bash

var1="$HOME/dev $HOME/dev/latex $HOME/dev/scripts $HOME/dev/npm-packages $HOME/dev/rust $HOME/dev/vscode $HOME/dev/jetbrains $HOME/config"

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find $var1 -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)
path=$(dirname $(realpath $0))
shift

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

initialize="0"

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
    initialize="1"
fi

tmux switch-client -t $selected_name

if [ "$initialize" = "1" ]; then
    sh $path/../windows/all-runner.sh $selected_name start
fi
