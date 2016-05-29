#!/bin/bash

get_abs_filename() {
    # $1 : relative filename
    echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

ZSH=zsh
RUNCOMS=zsh/zprezto.symlink/runcoms
FILES="zlogin zlogout zpreztorc zprofile zshenv zshrc"
for file in $FILES
do
    to=`get_abs_filename "$RUNCOMS/$file"`
    from=$HOME/.$file
    echo "link" $from "->" $to
    ln -s $to $from
done
