#!/bin/bash

TARGET_DIR=$1

#check if the directory exists

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' does not exist."
    exit 1
fi

for file in "$TARGET_DIR"/*; do
    [ -d "$file" ] && continue

    filename=$(basename -- "$file")
    extension="${filename##*.}"

    if [ "$filename" == "$extension" ]; then
    extension="misc"
    fi

    if [[ "$filename" == .* ]]; then
    extension="hidden"
    fi


    subdir="$TARGET_DIR/$extension"
    [ ! -d "$subdir" ] && mkdir -p "$subdir"

    mv "$file" "$subdir/"


done

echo "Files in '$TARGET_DIR' have been organized."