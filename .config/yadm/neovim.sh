#!/usr/bin/env bash

install_neovim_bin() {
    ARCH=$(uname -m)
    case "$ARCH" in
        x86_64) NVIM_ARCH="linux-x86_64" ;;
        aarch64) NVIM_ARCH="linux-arm64" ;;
        *)
            echo "Unsupported architecture $ARCH"
            exit 1
            ;;
    esac

    LATEST=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest \
        | grep '"tag_name"' \
        | sed -E 's/.*"v([^"]+)".*/\1/')
    URL="https://github.com/neovim/neovim/releases/download/v$LATEST/nvim-$NVIM_ARCH.tar.gz"

    TMP=$(mktemp -d)
    curl -L "$URL" -o "$TMP/nvim.tar.gz"

    sudo tar xzf "$TMP/nvim.tar.gz" -C /usr/local --strip-components=1
    rm -rf "$TMP"
}

install_lazy_nvim() {
    git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim || true
}

install_neovim() {
    install_neovim_bin
    install_lazy_nvim
}
