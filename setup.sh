#!/bin/sh
# download lazy.nvim
git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim || true

# get script directory
DIR="$(cd $(dirname $0) && pwd)"

# copy neovim config
mkdir -p ~/.config/nvim
ln -s $DIR/init.lua ~/.config/nvim/init.lua
