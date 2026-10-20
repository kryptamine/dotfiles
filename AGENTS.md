# Dotfiles agent notes

macOS dotfiles managed by chezmoi in **symlink mode**: most files in `~` are symlinks into this repo, so editing either side edits the same file. Templates (`*.tmpl`, e.g. `dot_gitconfig.tmpl`, `.chezmoi.toml.tmpl`) render into real files: edit them here, then `chezmoi apply <target>`.

## Applying

Run `chezmoi diff` before `chezmoi apply`, and apply only the targets you changed (`chezmoi apply ~/.config/foo`). A full apply overwrites anything on this machine that drifted from the repo.

## What belongs in the repo

The repo is public and shared by a personal and a work laptop. Track configs that are the same on both. Keep per-machine state and secrets out, listed in `.chezmoiignore` (gh `hosts.yml`, fish `fish_variables`). Per-machine values (git name and email) come from `.chezmoi.toml.tmpl` prompts.

Any repo-only file (docs, hooks) needs a `.chezmoiignore` entry, or chezmoi copies it into `~`. Dotfiles at the repo root (`.githooks/`) are skipped automatically.

## Packages and plugins

- New tool: add it to `dot_Brewfile`; `run_onchange_install-packages.sh.tmpl` reruns `brew bundle` when the Brewfile changes.
- Fish plugins are vendored fisher files (`fish_plugins` lists them). Install with `fisher install`, then `chezmoi add` the new files; after `fisher remove`, delete the plugin files from the repo too.

## Committing

Run `.githooks/pre-commit` (fish_indent, stylua, shellcheck) before committing. Write one commit per logical change with a descriptive imperative message.
