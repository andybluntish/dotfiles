#!/usr/bin/env bash

###
#
# bootstrap.sh
#
# Setup and sync dotfiles
#
# 1. Copy files from the local repository into ~/.dotfiles
# 2. Symlink files from ~/.dotfiles into the home directory
#    Files starting with an underscore (_) are NOT symlinked
#
###


# Change into the directory we're executing from.
cd `dirname $0`

# Make the ~/.dotfiles directory if it doesn't exist.
if [ ! -d "$HOME/.dotfiles" ]; then
  mkdir "$HOME/.dotfiles"
fi

# Rsync files to ~/.dotfiles, excluding: hidden files, Readme, and this script.
rsync --exclude `basename $0` --exclude ".*" --exclude "README.md" --archive --verbose --delete --no-perms . $HOME/.dotfiles

# Loop through each file in ~/.dotfiles
for file in `ls $HOME/.dotfiles`; do

  # Skip files that begin with an underscore
  if [[ $file =~ ^_.* ]] || [[ $file =~ \.old$ ]]; then
    continue
  fi

  # Symlink file to the home directory
  ln -snf $HOME/.dotfiles/$file $HOME/.$file
done

# Reload the bash_profile
source $HOME/.bash_profile

# Install VIM plugins with Vundle
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall
