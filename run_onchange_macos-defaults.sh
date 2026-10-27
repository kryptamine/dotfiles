#!/bin/bash
# macOS settings that live outside dotfiles. Rerun by chezmoi when this file changes.

# Fast key repeat, no accent popup on hold
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15
defaults write -g ApplePressAndHoldEnabled -bool false

# No autocorrect, auto-capitalization or double-space period
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false

# No font smoothing: on Retina it only thickens glyphs
defaults -currentHost write -g AppleFontSmoothing -int 0

# Disable Ctrl+Space / Ctrl+Opt+Space input source switching (Karabiner Shift taps do it)
for id_mods in 60:262144 61:786432; do
  id=${id_mods%%:*}
  mods=${id_mods##*:}
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$id" \
    "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>$mods</integer></array><key>type</key><string>standard</string></dict></dict>"
done
# Dark mode and an auto-hidden menu bar; System Events applies both at once,
# a bare defaults write left the menu bar shown
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'
osascript -e 'tell application "System Events" to tell dock preferences to set autohide menu bar to true'

# Dock: hidden, small, on the left, no recent apps, minimize into the app icon
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 37
defaults write com.apple.dock orientation -string left
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock minimize-to-application -bool true
# Keep Spaces in a fixed order, no Quick Note on the bottom-right hot corner
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock wvous-br-corner -int 1

# Finder: path and status bars, folders first, new windows open Downloads,
# no warning when changing an extension
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder NewWindowTarget -string PfLo
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/Downloads/"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# No gaps between windows tiled by macOS
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false

/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
killall Dock Finder
