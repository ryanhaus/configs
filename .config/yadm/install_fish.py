from utils import install_package, run_web_script
import subprocess

def install_fish():
    # right now, fedora only, since there is no apt package for some things here
    print("Installing fish and related items...")

    subprocess.run(["sudo", "dnf", "copr", "enable", "-y", "claaj/typst"])

    install_package("fish")   # shell
    install_package("zellij") # terminal multiplexing
    install_package("zoxide") # smarter 'cd' command
    install_package("typst")  # for writing (typesetter)

    # enter fish shell & install fisher
    fisher_cmd = "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update" # from fisher github
    subprocess.run(["fish", "-c", fisher_cmd])
