#!/bin/bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/dev ~/dev/latex ~/dev/scripts ~/dev/npm-packages ~/dev/rust ~/dev/vscode ~/dev/jetbrains ~/.config -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)
full_dir=$(pwd)/$(dirname $0)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

session_exists=$(tmux has-session -t=$selected_name 2> /dev/null)

if ! $session_exists; then
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name

if ! $session_exists; then
    sh $full_dir/windows/initializer.sh $selected_name
fi
