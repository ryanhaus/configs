from utils import install_package
import subprocess

def install_fish():
    # right now, fedora only, since there is no apt package for some things here
    print("Installing fish and related items...")

    subprocess.run(["sudo", "dnf", "copr", "enable", "-y", "claaj/typst"])

    install_package("fish")   # shell
    install_package("zellij") # terminal multiplexing
    install_package("zoxide") # smarter 'cd' command
    install_package("typst")  # for writing (typesetter)
