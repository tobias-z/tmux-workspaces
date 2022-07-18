#!/bin/bash

selected_name=$1
selected_path=$2

if [[ $selected_path == "unused" ]]; then
    selected_path=""
fi

action=$3

session_initializer_dir="$TW_CONFIG/$selected_name"

if [ ! -d "$session_initializer_dir" ]; then
    exit 0
fi

dir_name=$(dirname $0)

main_window=$session_initializer_dir/$TW_MAIN_WINDOW

if [ ! -d "$main_window" ]; then
    if [[ $action == "start" ]]; then
        sh $dir_name/key-sender.sh $main_window $selected_name "envmain"
    fi
fi

for dir in $session_initializer_dir/*; do
    if [[ $action == "start" ]]; then
        sh $dir_name/key-sender.sh $dir $selected_name $selected_path
    fi
    file="$dir/$action.sh"
    if [ -e "$file" ]; then
        sh $dir_name/key-sender.sh $dir $selected_name $selected_path "source $file"
    fi
done
