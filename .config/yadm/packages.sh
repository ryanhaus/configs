#!/usr/bin/env bash

PACKAGES=(
    # general
    git
    curl

    # for neovim
    ripgrep
    nodejs
    npm

    # for zsh
    zsh
    bat
)

detect_package_manager() {
    if command -v apt >/dev/null; then
        PKG_MGR="apt"
        PKG_MGR_CMD="sudo apt update && sudo apt install -y "
    elif command -v dnf >/dev/null; then
        PKG_MGR="dnf"
        PKG_MGR_CMD="sudo dnf install -y "
    else
        echo "Unsupported package manager"
        exit 1
    fi
    
    echo "Detected package manager: $PKG_MGR"
}

install_packages() {
    detect_package_manager
    eval "$PKG_MGR_CMD ${PACKAGES[*]}"
}
