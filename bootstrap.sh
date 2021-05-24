#!/usr/bin/env bash

set -euo pipefail
[[ ${DEBUG:-} ]] && set -x

function link() {
  source=$PWD/$1
  target=${2:-$HOME/.$1}

  echo "Linking $source -> $target"

  ln -snf $source $target
}

function install_vim_plug() {
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  nvim +PlugUpgrade +PlugInstall +PlugUpdate +PlugClean! +qa
}

mkdir -p $HOME/.config/fish/functions
mkdir -p $HOME/.config/nvim

link config/fish/config.fish $HOME/.config/fish/
link config/nvim/init.vim $HOME/.config/nvim/
link config/nvim/coc-settings.json $HOME/.config/nvim/
link config/starship.toml $HOME/.config/

link base.sh
link bash_profile
link bashrc
link bin
link gemrc
link gitconfig
link gitignore
link hushlogin
link inputrc
link irbrc
link zshrc

install_vim_plug
