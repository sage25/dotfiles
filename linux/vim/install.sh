#!/bin/bash

set -e

if [ -d "$HOME/.vim" ]; then
    if [ -d "$HOME/.vim.bak" ]; then
        rm -rf "$HOME/.vim.bak"
    fi
    mv "$HOME/.vim" "$HOME/.vim.bak"
fi

mkdir -p "$HOME/.vim"
ln -sf "$LINUXDOTDIR/vim/coc-config/coc-settings.json" "$HOME/.vim/coc-settings.json"
ln -sf "$LINUXDOTDIR/.vimrc" "$HOME/.vimrc"

VIM_PLUG_PATH="$HOME/.vim/autoload/plug.vim"

if [ ! -f "$VIM_PLUG_PATH" ];
then
    echo "Start installing vim-plug"
    {
        # wget is available
        wget -O ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    } >/dev/null 2>&1

    ret=$?
    if [ $ret -ne 0 ]; then
        echo "ERROR: wget download vim‑plug failed."
        exit 1
    fi
    echo "Successfully downloaded vim-plug"
fi

echo "Start installing Vim plugins"
vim -c "PlugInstall" -c "qa" 

