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

set_env() {
    local the_file=$1
    if [ -f "$the_file" ]; then
        while read -r line; do
            tmux send-keys -t $target "export $line" Enter
        done <$the_file
    fi
}

load_env_files() {
    session_env_file="$TW_CONFIG/$session_name/.env"
    branch_env_file="$TW_CONFIG/$session_name/$branch_name/.env"
    set_env $session_env_file
    set_env $branch_env_file
}

case $last in
    "envmain")
        load_env_files
        ;;
esac

case $last in
    *start*)
        load_env_files
        tmux send-keys -t $target "$last" Enter
        ;;
    *stop*)
        tmux send-keys -t $target C-c
        tmux send-keys -t $target "$last" Enter
        ;;
esac
