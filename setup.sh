#!/bin/bash
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles

# Variables

dir=$HOME/dotfiles
files="vimrc vim zshrc zpreztorc"

for file in $files; do
    if [ -f $HOME/.$file ]
    then
        echo "Cowardly refusing to symlink $dir/$file to $HOME/.$file since $HOME/.$file seems to be a file."
        exit 1
    fi
    echo "Symlinking $dir/$file  ->  $HOME/.$file"
    ln -s $dir/$file $HOME/.$file
done
