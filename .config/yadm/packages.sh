#!/usr/bin/env bash

PACKAGES=(
    # general
    git
    curl
    bat

    # for neovim
    ripgrep
    nodejs
    npm
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

    # Fix for ARM systems to manually install clangd for Mason
    ARCH=$(uname -m)
    if [[ "$ARCH" == "aarch64" ]]; then
        # From https://github.com/mason-org/mason.nvim/issues/1578#issuecomment-2455253723
        eval "$PKG_MGR_CMD mason clangd jq"
        mkdir -p ~/.local/share/nvim/mason/packages/clangd/mason-schemas
        cd ~/.local/share/nvim/mason/packages/clangd
        curl https://raw.githubusercontent.com/clangd/vscode-clangd/master/package.json \
            | jq .contributes.configuration > mason-schemas/lsp.json
        echo '{"schema_version":"1.1","primary_source":{"type":"local"},"name":"clangd","links":{"share":{"mason-schemas/lsp/clangd.json":"mason-schemas/lsp.json"}}}' \
            > mason-receipt.json
        cd -
    fi
}
