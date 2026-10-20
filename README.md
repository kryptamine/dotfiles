# dotfiles

My dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## What's inside

- **fish** shell config
- **neovim** config
- **ghostty** and **kitty** terminals
- **herdr** agent multiplexer, **hunk** diff viewer
- **lazygit**, **gh** CLI
- **karabiner** key remaps
- **starship** prompt
- **Brewfile** with all packages (brew, casks, go tools); `brew bundle` reruns on every Brewfile change
- **git** and **ssh** config

## Setup

```sh
chezmoi init --apply https://github.com/kryptamine/dotfiles
```

`init` asks for the git name and email for this machine.
