#!/bin/sh
# Setup zsh
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Setup neovim
sudo apt install git ripgrep neovim
git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim || true

# get script directory
DIR="$(cd $(dirname $0) && pwd)"

# copy configs
mkdir -p ~/.config/nvim
ln -sf $DIR/init.lua ~/.config/nvim/init.lua

ln -sf $DIR/zshrc ~/.zshrc
