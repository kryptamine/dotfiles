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

# Disable Ctrl+Space / Ctrl+Opt+Space input source switching (Karabiner Shift taps do it)
for id_mods in 60:262144 61:786432; do
  id=${id_mods%%:*}
  mods=${id_mods##*:}
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$id" \
    "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>$mods</integer></array><key>type</key><string>standard</string></dict></dict>"
done
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
