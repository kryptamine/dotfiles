# Editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Homebrew (Apple Silicon): PATH, MANPATH, INFOPATH
/opt/homebrew/bin/brew shellenv fish | source

# Base PATH additions (earlier = higher priority). fish_add_path skips
# directories that don't exist, so machine-specific ones are safe here.
# ~/.local/bin: Antigravity CLI, Hermes Agent
fish_add_path -g \
    ~/.local/bin \
    ~/.cargo/bin \
    ~/.grok/bin \
    ~/.yarn/bin \
    ~/.local/share/nvim/mason/bin

# Go
set -gx GOPATH $HOME/go
fish_add_path -g $GOPATH/bin

# Disable fish greeting
set -g fish_greeting

# Theme: generated from the gruber-darker-renaissance palette
if status is-interactive
    fish_config theme choose gruber-darker-renaissance
end

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
