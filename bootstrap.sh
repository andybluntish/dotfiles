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

link config/fish/config.fish $HOME/.config/fish/
link fish_prompt.fish $HOME/.config/fish/functions/
link config/fish/functions/initialize_abbrs.fish $HOME/.config/fish/functions/
link bin
link gemrc
link gitconfig
link gitignore
link hushlogin
link config/nvim/init.vim $HOME/.config/nvim/
link tmux.conf
