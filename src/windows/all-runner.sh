#!/bin/bash

selected_name=$1
selected_path=$2
action=$3

session_initializer_dir="$TW_CONFIG/$selected_name"

if [ ! -d "$session_initializer_dir" ]; then
    exit 0
fi

dir_name=$(dirname $0)

for dir in $session_initializer_dir/*; do
    sh $dir_name/key-sender.sh $dir $selected_name $selected_path
    file="$dir/$action.sh"
    if [ -e "$file" ]; then
        sh $dir_name/key-sender.sh $dir $selected_name $selected_path "source $file"
    fi
done
