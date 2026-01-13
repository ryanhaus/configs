# Aliases
alias vi=nvim

# WSL-only commands
if [ -n "$WSL_DISTRO_NAME" ]; then
    WINDOWS_USER_DIR="$(wslpath $(wslvar USERPROFILE))"

    # Run uncap, which should be in user profile folder
    eval "$WINDOWS_USER_DIR/uncap.exe &"
fi
