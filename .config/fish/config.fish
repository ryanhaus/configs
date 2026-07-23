if status is-interactive
    # set EDITOR to neovim
    set -gx EDITOR nvim
    set -gx VISUAL nvim

    # initialize zoxide
    zoxide init fish | source
end
fish_add_path $HOME/.local/bin
