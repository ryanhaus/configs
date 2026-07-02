import os
import subprocess

from package_manager import install_package

def install_neovim():
    print("Installing Neovim and related items...")

    # install nvim
    install_package("neovim")

    # install lazy.nvim
    lazy_install_dir = "~/.local/share/nvim/lazy/lazy.nvim"

    if not os.path.exists(lazy_install_dir):
        subprocess.run([
            "git",
            "clone",
            "https://github.com/folke/lazy.nvim.git",
            lazy_install_dir
        ], check=True)
