import subprocess
from utils import install_package, run_web_script, pull_git_repo

def install_neovim():
    print("Installing Neovim and related items...")

    # install node.js (see node.js/org/en/download, ported to python from bash)
    run_web_script("https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh")
    subprocess.run(["bash", "-c", "source ~/.nvm/nvm.sh && nvm install 24"])

    # install nvim & other necessary packages
    install_package("neovim")
    install_package("ripgrep")

    # install lazy.nvim
    pull_git_repo(
        "https://github.com/folke/lazy.nvim.git",
        "~/.local/share/nvim/lazy/lazy.nvim"
    )
