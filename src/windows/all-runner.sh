#!/bin/bash

selected_name=$1
action=$2

session_initializer_dir="$TW_CONFIG/$selected_name"

if [ ! -d "$session_initializer_dir" ]; then
    exit 0
fi

dir_name=$(dirname $0)

for dir in $session_initializer_dir/*; do
    sh $dir_name/key-sender.sh $dir $selected_name
    file="$dir/$action.sh"
    if [ -e "$file" ]; then
        sh $dir_name/key-sender.sh $dir $selected_name "source $file"
    fi
done
