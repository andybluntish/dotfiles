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
ln -snf "${PWD}/asdfrc" "${HOME}/.asdfrc"
ln -snf "${PWD}/gemrc" "${HOME}/.gemrc"
ln -snf "${PWD}/gitconfig" "${HOME}/.gitconfig"
ln -snf "${PWD}/gitignore" "${HOME}/.gitignore"
ln -snf "${PWD}/hushlogin" "${HOME}/.hushlogin"
ln -snf "${PWD}/irbrc" "${HOME}/.irbrc"

# Node.js
node_version=16.15.1
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs $node_version
asdf global nodejs $node_version
yarn global add neovim eslint prettier typescript
asdf reshim nodejs

# Ruby
ruby_version=3.1.2
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install ruby $ruby_version
asdf global ruby $ruby_version
gem install neovim bundler
asdf reshim ruby

# Python
python_version=3.10.5
asdf plugin-add python https://github.com/danhper/asdf-python
asdf install python $python_version
asdf global python $python_version
pip install pynvim
asdf reshim python

# NeoVim config
mkdir -p "${HOME}/.config/nvim"
ln -snf "${PWD}/config/nvim/init.vim" "${HOME}/.config/nvim/"
ln -snf "${PWD}/config/nvim/coc-settings.json" "${HOME}/.config/nvim/"

# Install Vim Plug
curl -fLo "${HOME}/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugUpgrade +PlugInstall +PlugUpdate +PlugClean! +qa
