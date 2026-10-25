# Editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Homebrew (Apple Silicon): PATH, MANPATH, INFOPATH
/opt/homebrew/bin/brew shellenv fish | source

# Base PATH additions (earlier = higher priority)
# ~/.local/bin: Antigravity CLI, Hermes Agent
fish_add_path -g \
    ~/.local/bin \
    ~/.cargo/bin \
    ~/.grok/bin \
    ~/.yarn/bin \
    ~/.local/share/nvim/mason/bin \
    ~/flutter/bin \
    ~/Library/Android/sdk/platform-tools

# Go
set -gx GOPATH $HOME/go
fish_add_path -g $GOPATH/bin

# Compiler paths
set -gx CPATH /opt/homebrew/include
set -gx LIBRARY_PATH /opt/homebrew/lib

# Disable fish greeting
set -g fish_greeting

# Starship
if status is-interactive; and type -q starship
    starship init fish | source
end

# zoxide: z <dir>, zi for fzf picker
if status is-interactive; and type -q zoxide
    zoxide init fish | source
end

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
fish_add_path -g $PNPM_HOME/bin
