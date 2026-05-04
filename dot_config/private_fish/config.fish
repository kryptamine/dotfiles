# Editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Homebrew (Apple Silicon)
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_NO_AUTO_UPDATE 1

# Base PATH additions (prepend = higher priority)
fish_add_path -g ~/.local/bin
fish_add_path -g ~/go/bin
fish_add_path -g /opt/homebrew/bin
fish_add_path -g /usr/local/bin
fish_add_path -g ~/.cargo/bin

# node_modules binaries (local project)
if test -d ./node_modules/.bin
    fish_add_path ./node_modules/.bin
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

# Pyenv (only interactive)
if status is-interactive
    if type -q pyenv
        pyenv init --path | source
    end
end

