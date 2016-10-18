#!/usr/bin/env bash

###
#
# bootstrap.sh
#
# Symlink dotfiles to home directory.
#
###


# Change into the directory we're executing from.
cd `dirname $0`

# Loop through each file
for file in `ls .`; do

  # Skip files that begin with an underscore, readme, and the bootstrap file
  if [[ $file =~ ^_.* ]] || [[ $file =~ ^README ]] || [[ $file =~ ^bootstrap ]]; then
    continue
  fi

  # Symlink file to the home directory
  ln -snf "$PWD/$file" "$HOME/.$file"
done
