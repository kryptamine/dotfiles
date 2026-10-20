# Editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Homebrew (Apple Silicon)
set -gx HOMEBREW_PREFIX /opt/homebrew

# Base PATH additions (earlier = higher priority)
fish_add_path -g \
    ~/.local/bin \
    /opt/homebrew/bin \
    /usr/local/bin \
    ~/.cargo/bin \
    ~/.grok/bin \
    ~/.yarn/bin \
    ~/.local/share/nvim/mason/bin \
    ~/flutter/bin \
    ~/Library/Android/sdk/platform-tools

# node_modules binaries (local project)
if test -d ./node_modules/.bin
    fish_add_path -g ./node_modules/.bin
end

# Go
set -gx GOPATH $HOME/go
fish_add_path -g $GOPATH/bin

# Compiler paths
set -gx CPATH /opt/homebrew/include
set -gx LIBRARY_PATH /opt/homebrew/lib

# Disable fish greeting
set -g fish_greeting

# Starship
if type -q starship
    starship init fish | source
end

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
fish_add_path -g $PNPM_HOME/bin

