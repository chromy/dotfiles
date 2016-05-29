#!/bin/bash
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles

# Variables

dir=$HOME/dotfiles
files="vimrc vim zshrc zpreztorc zprezto zlogin zlogout zprezto zpreztorc zprofile zshenv zshrc"

for file in $files; do
    if [ -f $HOME/.$file ] && [ ! -L $HOME/.$file ]
    then
        echo "Cowardly refusing to symlink $dir/$file to $HOME/.$file since $HOME/.$file seems to be a file."
        exit 1
    fi
    echo "Symlinking $HOME/.$file to $dir/$file"
    ln -sf $dir/$file $HOME/.$file
done
