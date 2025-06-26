```sh

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Decent mouse scrolling
brew install mos
# if installed from web, whiletlist it :
cd /Applications/
xattr -d com.apple.quarantine Mos.app
# Then launch and untick ReveScroll ; set Launch on Login, Hide status bar icon

# Hide Menubar icons
brew install --cask jordanbaird-ice
# then open it to grant permissions & always show Teams, VPN, bluetooth ; hide spotlight

# Window switcher on Alt-Tab instead of Command-Tab
# https://alt-tab-macos.netlify.app/
brew install --cask alt-tab
# then open to grant permissions & set options:
# * General: Start at login, no Menubar icon
# * Appearance: AppIcons, Style: Preview selected window

# Automation, scripting, shortcuts for window switcher
brew install --cask hammerspoon

# Clipboard manager - https://maccy.app/
brew install maccy

# Quicksilver is a Stoplight replacement, on Command-space, and also helps with global shortcuts
brew install --cask quicksilver

# Anytype Note application
brew install --cask anytype

# Restore home and end
mkdir -p $HOME/Library/KeyBindings
echo '{
/* Remap Home / End keys to be correct */
"\UF729" = "moveToBeginningOfLine:"; /* Home */
"\UF72B" = "moveToEndOfLine:"; /* End */
"$\UF729" = "moveToBeginningOfLineAndModifySelection:"; /* Shift + Home */
"$\UF72B" = "moveToEndOfLineAndModifySelection:"; /* Shift + End */
"^\UF729" = "moveToBeginningOfDocument:"; /* Ctrl + Home */
"^\UF72B" = "moveToEndOfDocument:"; /* Ctrl + End */
"$^\UF729" = "moveToBeginningOfDocumentAndModifySelection:"; /* Shift +
Ctrl + Home */
"$^\UF72B" = "moveToEndOfDocumentAndModifySelection:"; /* Shift + Ctrl +
End */
}' > $HOME/Library/KeyBindings/DefaultKeyBinding.dict

# hold a modifier key (Control (⌃) + Command (⌘) instead of linux's Alt or Windows key)
# and then click and drag anywhere within a window to move it, rather than just the title bar.
defaults write -g NSWindowShouldDragOnGesture -bool true 
# (then log-out/in)

# Keyboard layout editor
brew install --cask ukelele
```

Other

* System settings
  * Battery > Options > Untick "Slightly dim the display on battery"
