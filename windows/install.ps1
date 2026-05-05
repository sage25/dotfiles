$dotdir = "$HOME\dotfiles"

New-Item -ItemType SymbolicLink -Force -Path "$HOME\APPDATE"           -Target "$dotdir\windows\_vimrc"
