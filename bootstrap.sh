#!/usr/bin/env zsh

set -euo pipefail
[[ ${DEBUG:-} ]] && set -x

# Shell config from grml (https://grml.org/zsh/)
curl -fLo "${HOME}/.zshrc" https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc

# Link dotfiles
ln -snf ./zshrc.local ~/.zshrc.local
ln -snf ./zshrc.custom.local ~/.zshrc.custom.local
ln -snf ./bin ~/.bin
ln -snf ./gemrc ~/.gemrc
ln -snf ./gitconfig ~/.gitconfig
ln -snf ./gitignore ~/.gitignore
ln -snf ./hushlogin ~/.hushlogin
ln -snf ./irbrc ~/.irbrc

# NeoVim config
mkdir -p "${HOME}/.config/nvim"
link config/nvim/init.vim "${HOME}/.config/nvim/"
link config/nvim/coc-settings.json "${HOME}/.config/nvim/"

# Install Vim Plug
curl -fLo "${HOME}/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugUpgrade +PlugInstall +PlugUpdate +PlugClean! +qa
