#!/usr/bin/env bash
set -euo pipefail
[[ ${DEBUG:-} ]] && set -x

function link() {
  source=$PWD/$1
  target=${2:-$HOME/.$1}

  echo "Linking $source -> $target"

  ln -snf $source $target
}

mkdir -p $HOME/.config/fish
mkdir -p $HOME/.config/nvim

link bin
link gemrc
link gitconfig
link gitignore
link hushlogin
link init.vim $HOME/.config/nvim/init.vim
link tmux.conf
