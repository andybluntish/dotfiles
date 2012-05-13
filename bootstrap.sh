#!/bin/bash

###
#
# bootstrap.sh
#
# Setup and sync dotfiles
#
# 1. Copy files from the local repository into ~/.init
# 2. Symlink files from ~/.init into the home directory
#    Files starting with an underscore (_) are NOT symlinked
# 3. Profit
#
###


# Change into the directory we're executing from.
cd `dirname $0`

# Make the ~/.init directory if it doesn't exist.
if [ ! -d "~/.init" ]; then
  mkdir "~/.init"
fi

# Rsync files to ~/.init, excluding: git files, Readme, and this script.
rsync --exclude `basename $0` --exclude ".*" --exclude "README.md" --archive --verbose --delete . ~/.init

# Loop through each file in ~/.init
for file in `ls ~/.init`; do

  # Skip files that begin with an underscore
  if [[ $file =~ ^_.* ]]; then
    continue
  fi

  # Symlink file to the home directory
  ln -snf ~/.init/$file ~/.$file
done

# Reload the bash_profile
source ~/.bash_profile

