#!/usr/bin/env zsh

set -euo pipefail
[[ ${DEBUG:-} ]] && set -x

# Homebrew
brew bundle

# Shell config from grml (https://grml.org/zsh/)
curl -fLo "${HOME}/.zshrc" https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc

# Link dotfiles
ln -snf "${PWD}/zshrc.local" "${HOME}/.zshrc.local"
ln -snf "${PWD}/zshrc.custom.local" "${HOME}/.zshrc.custom.local"
ln -snf "${PWD}/bin" "${HOME}/.bin"
ln -snf "${PWD}/gemrc" "${HOME}/.gemrc"
ln -snf "${PWD}/gitconfig" "${HOME}/.gitconfig"
ln -snf "${PWD}/gitignore" "${HOME}/.gitignore"
ln -snf "${PWD}/hushlogin" "${HOME}/.hushlogin"
ln -snf "${PWD}/irbrc" "${HOME}/.irbrc"

# NeoVim config
mkdir -p "${HOME}/.config/nvim"
ln -snf "${PWD}/config/nvim/init.vim" "${HOME}/.config/nvim/"
ln -snf "${PWD}/config/nvim/coc-settings.json" "${HOME}/.config/nvim/"

# Install Vim Plug
curl -fLo "${HOME}/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugUpgrade +PlugInstall +PlugUpdate +PlugClean! +qa
