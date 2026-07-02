#!/usr/bin/env python3
import questionary
import sys
import importlib

from append_bashrc import append_bashrc
from utils import detect_package_manager

# initial function calls
append_bashrc()
detect_package_manager()

# installation candidates
options = [
    {
        "name": "Text editor (Neovim)",
        "scriptName": "install_neovim",
    },
    {
        "name": "Window manager (Niri)",
        "scriptName": "install_niri",
    },
    {
        "name": "Shell (fish)",
        "scriptName": "install_fish",
    },
]

# automatically imports scripts and loads appropriate function into 'options'
# assumes function has the same name as the script
for option in options:
    module = importlib.import_module(option["scriptName"])
    option["install"] = getattr(module, option["scriptName"])

# query for wanted components
selected = questionary.checkbox(
    "Pick components to install:",
    choices = [ questionary.Choice(option["name"], option, checked=True) for option in options ]
).ask()

# confirm selections
print("Components to be installed:")
for option in selected:
    print(f" - {option['name']}")

confirmation = questionary.confirm("Continue?").ask()

if not confirmation:
    print("Exiting...")
    sys.exit(1)

# install everything
for option in selected:
    option["install"]()
