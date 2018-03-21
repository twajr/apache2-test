#!/bin/bash

if [ -f "/var/lib/apache/.mounts" ] && [ ! -e "/restarted" ]; then
  touch "/restarted"
  while read p; do
    src=$(echo $p | cut -f1 -d:)
    dst=$(echo $p | cut -f2 -d:)

    # Removes existing files and directories without existing symlinks as a precaution
    if [[ !(-L "$dst") && -e "$dst" ]]; then
      rm -fR "$dst"
    fi

    # Make sure the directory one level above $dest so the simbolic link will not fail
    mkdir -p ${dst%/*}

    ln -sf $src $dst
    echo $src $dst
  done </var/lib/apache/.mounts
fi