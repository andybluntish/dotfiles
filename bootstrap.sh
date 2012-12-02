#!/bin/bash

###
#
# bootstrap.sh
#
# Setup and sync dotfiles
#
# 1. Copy files from the local repository into ~/.dotfiles
# 2. Symlink files from ~/.dotfiles into the home directory
#    Files starting with an underscore (_) are NOT symlinked
# 3. Profit
#
###


# Change into the directory we're executing from.
cd `dirname $0`

# Make the ~/.dotfiles directory if it doesn't exist.
if [ ! -d "~/.dotfiles" ]; then
  mkdir "~/.dotfiles"
fi

# Rsync files to ~/.dotfiles, excluding: hidden files, Readme, and this script.
rsync --exclude `basename $0` --exclude ".*" --exclude "README.md" --archive --verbose --delete . ~/.dotfiles

# Loop through each file in ~/.dotfiles
for file in `ls ~/.dotfiles`; do

  # Skip files that begin with an underscore
  if [[ $file =~ ^_.* ]] || [[ $file =~ \.old$ ]]; then
    continue
  fi

  # Symlink file to the home directory
  ln -snf ~/.dotfiles/$file ~/.$file
done

# Reload the bash_profile
source ~/.bash_profile

