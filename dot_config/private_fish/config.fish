# Editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# fzf: fzf.fish's own defaults plus the gruber-darker-renaissance palette.
# fzf-lua inherits this too, but passes its own --border, --height and colors.
set -gx FZF_DEFAULT_OPTS (string join ' ' -- \
    --cycle --layout=reverse --border=sharp --height=90% --info=inline-right \
    --preview-window=wrap '--marker=*' \
    --color=fg:#d2d2cc,bg:-1,hl:#efd45b,fg+:#ebebe6,bg+:#1e1e1e,hl+:#efd45b \
    --color=info:#8c8c8c,prompt:#efd45b,pointer:#efd45b,marker:#8ac568 \
    --color=spinner:#9e95c7,header:#9fb2d6,border:#555555,label:#8c8c8c \
    --color=gutter:-1,separator:#555555,scrollbar:#555555,query:#d2d2cc)

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
