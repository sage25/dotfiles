#!/bin/bash
set -e


DOTDIR="$HOME/dotfiles"

mkdir -p $HOME/.vim
ln -sf $DOTDIR/linux/vim/coc-config/coc-settings.json $HOME/.vim/coc-settings.json
ln -sf $DOTDIR/linux/.vimrc $HOME/.vimrc

echo "Linux dotfiles 部署完成！"
