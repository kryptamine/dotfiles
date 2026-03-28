#!/bin/bash

if command -v brew >/dev/null; then
  brew bundle --file="$HOME/.Brewfile"
fi
