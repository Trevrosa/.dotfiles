#!/usr/bin/env bash

apply() {
    read -p "apply patch .${file#$DIR}? [y/N] " -r 
    if [[ $REPLY =~ ^[yY]$ ]]; then
        $1 < $file
    else
        echo "skipping"    
    fi
}

DIR=$(realpath "$(dirname "$0")/../patches")

for file in "$DIR"/root/*.patch; do
    if [ -f "$file" ]; then
        apply "sudo patch -d / -p0 -b"
    fi
done


