from utils import install_package
def install_niri():
    # for now, fedora only
    print("Installing Niri and related items...")

    install_package("niri")      # window manager
    install_package("alacritty") # terminal emulator
    install_package("hypridle")  # idle manager
    install_package("hyprlock")  # lock screen
