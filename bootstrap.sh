#!/usr/bin/env bash

###
#
# bootstrap.sh
#
# Symlink dotfiles to home directory.
#
###

# Loop through each file
for file in `ls .`; do
  IN="$PWD/$file"
  OUT="$HOME/.$file"

  # Skip files that begin with an underscore, readme, and the bootstrap file
  if [[ $file =~ ^_.* ]] || [[ $file =~ ^README ]] || [[ $file =~ ^bootstrap ]]; then
    continue
  fi

  echo "Linking $IN -> $OUT"

  # Symlink file to the home directory
  ln -snf $IN $OUT
done

# Loop through vim files
for file in `ls ./_vim`; do
  IN="$PWD/_vim/$file"
  OUT="$HOME/.vim/$file"

  # Skip files that begin with an underscore, readme, and the bootstrap file
  if [[ $file =~ ^_.* ]] || [[ $file =~ ^README ]] || [[ $file =~ ^bootstrap ]]; then
    continue
  fi

  echo "VIM: Linking $IN -> $OUT"

  # Symlink file to the home directory
  ln -snf $IN $OUT
done
