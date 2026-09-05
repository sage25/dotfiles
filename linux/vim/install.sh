#!/bin/bash

set -e

if [ -d "$HOME/.vim" ]; then
    if [ -d "$HOME/.vim.bak" ]; then
        rm -rf "$HOME/.vim.bak"
    fi
    mv "$HOME/.vim" "$HOME/.vim.bak"
fi

mkdir -p "$HOME/.vim"
ln -sf "$LINUXDIR/vim/coc-config/coc-settings.json" "$HOME/.vim/coc-settings.json"
ln -sf "$LINUXDIR/vim/.vimrc" "$HOME/.vimrc"

VIM_PLUG_PATH="$HOME/.vim/autoload/plug.vim"

if [ ! -f "$VIM_PLUG_PATH" ]; then
    echo "Start installing vim-plug"
    mkdir -p "$(dirname "$VIM_PLUG_PATH")"
    PLUG_URLS=(
        "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        "https://cdn.jsdelivr.net/gh/junegunn/vim-plug@master/plug.vim"
    )
    for url in "${PLUG_URLS[@]}"; do
        if wget -q -T 20 --tries 3 -O "$VIM_PLUG_PATH" "$url"; then
            echo "Successfully downloaded vim-plug"
            break
        fi
        echo "WARN: download failed: $url" >&2
    done
    if [ ! -s "$VIM_PLUG_PATH" ]; then
        echo "ERROR: all attempts to download vim-plug failed." >&2
        exit 1
    fi
fi

echo "Start installing Vim plugins"
vim -c "PlugInstall" -c "qa"


