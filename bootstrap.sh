#!/usr/bin/env zsh

set -euo pipefail
[[ ${DEBUG:-} ]] && set -x

function link() {
  source="${PWD}/${1}"
  target=${2:-"${HOME}/.${1}"}

  echo "Linking ${source} -> ${target}"

  ln -snf "${source}" "${target}"
}

# Homebrew
brew bundle

# Shell config from grml (https://grml.org/zsh/)
curl -fLo "${HOME}/.zshrc" https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc

# Link dotfiles
link "zshrc.pre"
link "zshrc.local"
link "zshrc.custom.local"
link "bin"
link "asdfrc"
link "gemrc"
link "gitconfig"
link "gitignore"
link "hushlogin"
link "irbrc"

# Node.js
node_version="16.15.1"
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs "${node_version}"
asdf global nodejs "${node_version}"
yarn global add neovim eslint prettier typescript
asdf reshim nodejs

# Ruby
ruby_version="3.1.2"
asdf plugin add ruby "https://github.com/asdf-vm/asdf-ruby.git"
asdf install ruby "${ruby_version}"
asdf global ruby "${ruby_version}"
gem install neovim bundler
asdf reshim ruby

# Python
python_version="3.10.5"
asdf plugin-add python https://github.com/danhper/asdf-python
asdf install python "${python_version}"
asdf global python "${python_version}"
pip install pynvim
asdf reshim python

# NeoVim config
mkdir -p "${HOME}/.config/nvim"
link "config/nvim/init.vim" "${HOME}/.config/nvim/"
link "config/nvim/coc-settings.json" "${HOME}/.config/nvim/"

# Install Vim Plug
curl -fLo "${HOME}/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugUpgrade +PlugInstall +PlugUpdate +PlugClean! +qa

# Setup fzf
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish
