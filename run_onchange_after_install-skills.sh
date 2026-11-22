#!/bin/bash
# Installs global agent skills via the skills CLI (vercel-labs/skills) into ~/.agents/skills,
# linked into ~/.claude/skills. Reruns whenever this file changes, so edit the list below to add a skill.
# Plugin-provided skills live in .chezmoitemplates/claude-settings.json, not here.

set -euo pipefail

if ! command -v bunx >/dev/null; then
  echo "bunx not found, skipping skills install (bun comes from the Brewfile)" >&2
  exit 0
fi

# source repo | skill name
skills=(
  "vercel-labs/skills|find-skills"
  "cursor/plugins|thermo-nuclear-code-quality-review"
)

for entry in "${skills[@]}"; do
  bunx skills add "${entry%%|*}" --skill "${entry##*|}" -g -a claude-code -y
done
