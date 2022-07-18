#!/bin/bash

branch_name=$(basename $1)
session_name=$2
clean_name=$(echo $branch_name | tr "./" "__")
target="$session_name:$clean_name"

if ! tmux has-session -t $target 2> /dev/null; then
    selected_path=$3
    tmux neww -dn $clean_name -t $session_name -c "$selected_path"
fi

sleep 1

for last; do true; done

case $last in
    "envmain")
        tmux send-keys -t $target "export FOO=BAR" Enter
        ;;
esac

case $last in
    *start*)
        tmux send-keys -t $target "export FOO=BAR" Enter
        tmux send-keys -t $target "$last" Enter
        ;;
    *stop*)
        tmux send-keys -t $target C-c
        tmux send-keys -t $target "$last" Enter
        ;;
esac
