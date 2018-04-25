#!/usr/bin/env bash

set -euo pipefail
[[ ${DEBUG:-} ]] && set -x

for file in `ls .`; do
  IN="$PWD/$file"
  OUT="$HOME/.$file"

  # Skip this script, and files that begin with an underscore, or end in .md
  if [[ $file = $(basename $0) ]] || [[ $file =~ ^_.* ]] || [[ $file =~ .*\.md$ ]] ; then
    continue
  fi

  echo "Linking $IN -> $OUT"

  # Symlink file to the home directory
  ln -snf $IN $OUT
done
