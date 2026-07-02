import shutil
import sys
import subprocess

# get package manager
PACKAGE_MANAGER = None
def detect_package_manager():
    global PACKAGE_MANAGER

    # detect package manager (right now, only apt/dnf supported since that's all I use)
    for manager in ["apt", "dnf"]:
        if shutil.which(manager):
            PACKAGE_MANAGER = manager

    if PACKAGE_MANAGER == None:
        print("Unsupported package manager")
        sys.exit(1)

# function to install system package
def install_package(package_name):
    global PACKAGE_MANAGER
    print(f"Installing '{package_name}'...")

    # get installation command from system package manager (assumes 'detect_package_manager()' was run previously)
    install_cmd = []
    match PACKAGE_MANAGER:
        case "apt":
            install_cmd = ["sudo", "apt", "install", "-y", package_name]
        case "dnf":
            install_cmd = ["sudo", "dnf", "install", "-y", package_name]
    
    if install_cmd == []:
        print(f"Error installing '{package_name}': empty install command (unsupported package manager?")
        sys.exit(1)

    # try to install the package
    return_code = subprocess.run(install_cmd).returncode
    if return_code != 0:
        print(f"Error installing '{package_name}': code {return_code}")
        sys.exit(return_code)
