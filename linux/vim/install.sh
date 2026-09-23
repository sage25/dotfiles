#!/bin/bash

set -e

source "$HOME/.bashrc"

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
        "https://cdn.jsdelivr.net/gh/junegunn/vim-plug@master/plug.vim"
        "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
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
        rm -f "$VIM_PLUG_PATH"
        exit 1
    fi
fi

echo "Start installing Vim plugins"

if ! GIT_CONFIG_COUNT=1 \
    GIT_CONFIG_KEY_0="url.https://ghfast.top/https://github.com/.insteadOf" \
    GIT_CONFIG_VALUE_0="https://github.com/" \
    timeout 120 vim -es -u "$HOME/.vimrc" \
        -c "PlugInstall --sync" \
        -c "qa!" </dev/null
then
    echo "WARN: Vim plugin installation failed or timed out" >&2
fi

echo "Start installing Coc plugins"

while IFS= read -r plugin; do
    [[ -z "$plugin" || "$plugin" == \#* ]] && continue

    echo "Installing: $plugin"

    if ! vim -es -u "$HOME/.vimrc" \
        -c "CocInstall $plugin" \
        -c "qa!" </dev/null
    then
        echo "WARN: failed to install Coc plugin: $plugin" >&2
    fi
done < "$LINUXDIR/vim/coc-config/plug-list"

echo "Vim installation completed"
