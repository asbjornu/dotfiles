#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin main;

function doIt() {
    rsync --exclude ".git/" \
          --exclude ".DS_Store" \
		  --exclude ".osx" \
          --exclude "bootstrap.sh" \
          --exclude "README.md" \
          --exclude "LICENSE-MIT.txt" \
          -avh \
          --no-perms . ~;

    source ~/.bash_profile;
}

if [ ! -f .extra ]; then
    echo ''
    echo "Warning! No .extra file found. This may lead to anonymous Git commits and other problems."
    echo "If you want to avoid these problems, please add an .extra file as described in the README."
    echo ''
fi

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt;
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt;
    fi;
fi;
unset doIt;
