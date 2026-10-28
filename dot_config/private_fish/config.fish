# Editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Homebrew (Apple Silicon): what `brew shellenv fish` prints, inlined because
# running it costs 20-30 ms on every shell start
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
fish_add_path -g -m -P /opt/homebrew/bin /opt/homebrew/sbin
if test -n "$MANPATH"
    set -gx MANPATH (string replace -r '^:*(.*?):*$' ':$1' -- "$MANPATH")
end
set -q INFOPATH; or set INFOPATH ''
contains /opt/homebrew/share/info $INFOPATH
or set -gx INFOPATH /opt/homebrew/share/info $INFOPATH

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

# Source `<tool> init fish` from a cache, regenerated when the resolved binary
# path changes (a brew upgrade moves it to a new Cellar version)
function _source_cached_init -a tool
    set -l bin (command -s $tool); or return
    set -l real (path resolve $bin)
    set -l cache ~/.cache/fish/$tool-init.fish
    if not test -f $cache; or test (head -n1 $cache) != "# $real"
        mkdir -p (path dirname $cache)
        begin
            echo "# $real"
            $bin init fish $argv[2..]
        end >$cache
    end
    source $cache
end

if status is-interactive
    _source_cached_init starship --print-full-init
    # zoxide: z <dir>, zi for fzf picker
    _source_cached_init zoxide
end
functions -e _source_cached_init

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
fish_add_path -g $PNPM_HOME/bin
