```sh

# Homebrew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Hide Menubar icons

brew install --cask jordanbaird-ice

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
```
