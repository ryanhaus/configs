#!/bin/sh
# get script directory
DIR="$(cd $(dirname $0) && pwd)"

# copy neovim config
mkdir -p ~/.config/nvim
ln -s $DIR/init.vim ~/.config/nvim/init.vim
