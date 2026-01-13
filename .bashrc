# Exit if not interactive
case $- in
    *i*) ;;
      *) return;;
esac

# History
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=10000

# Resize handling
shopt -s checkwinsize

# Environment label (chroot / container)
if [ -z "${SHELL_ENV:-}" ]; then
    if [ -r /etc/debian_chroot ]; then
        SHELL_ENV=$(cat /etc/debian_chroot)
    elif [ -n "$container" ]; then
        SHELL_ENV=container
    fi
fi

# Prompt
PS1='${SHELL_ENV:+($SHELL_ENV)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Terminal title
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${SHELL_ENV:+($SHELL_ENV)}\u@\h: \w\a\]$PS1"
    ;;
esac

# Bash completion
if ! shopt -oq posix; then
    for bc in \
        /usr/share/bash-completion/bash_completion \
        /etc/bash_completion
    do
        [ -r "$bc" ] && . "$bc" && break
    done
fi

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vi='nvim'

# WSL-specific
if [ -n "$WSL_DISTRO_NAME" ]; then
    WINDOWS_USER_DIR="$(wslpath "$(wslvar USERPROFILE)")"
    if [ -x "$WINDOWS_USER_DIR/uncap.exe" ]; then
        pgrep -f uncap.exe >/dev/null || \
            "$WINDOWS_USER_DIR/uncap.exe" >/dev/null 2>&1 &
    fi
fi
