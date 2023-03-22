#!/usr/bin/env bash

set -euo pipefail
[ ${DEBUG:-} ] && set -x

function link() {
  source="${PWD}/${1}"
  target=${2:-"${HOME}/.${1}"}

  echo "Linking ${source} -> ${target}"
  ln -snf "${source}" "${target}"
}

function is_exec() {
  [ -x $(which "${1}") ]
}

function install_node() {
  if [ "${node_version}" ]; then
    asdf plugin add nodejs "https://github.com/asdf-vm/asdf-nodejs.git"
    asdf install nodejs "${node_version}"
    asdf global nodejs "${node_version}"
  fi

  yarn global add neovim eslint prettier
}

function install_ruby() {
  if [ "${ruby_version}" ]; then
    asdf plugin add ruby "https://github.com/asdf-vm/asdf-ruby.git"
    RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)" asdf install ruby "${ruby_version}"
    asdf global ruby "${ruby_version}"
  fi

  gem install neovim bundler
}

function install_python() {
  if [ "${python_version}" ]; then
    asdf plugin-add python "https://github.com/danhper/asdf-python.git"
    asdf install python "${python_version}"
    asdf global python "${python_version}"
  fi

  pip install pynvim
}

node_version=
ruby_version=
python_version=

while getopts node_version:ruby_version:python_version: option
do
  case "${option}"
    in
    node_version)node_version=${OPTARG};;
    ruby_version)ruby_version=${OPTARG};;
    python_version)python_version=${OPTARG};;
  esac
done

# Homebrew
brew bundle

# Shell config from grml (https://grml.org/zsh/)
curl -fLo "${HOME}/.zshrc" https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc

# Link dotfiles
mkdir -p "${HOME}/.config/nvim"
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
link "config/nvim/init.vim" "${HOME}/.config/nvim/"

# continue on error installing languages
set +e

install_node
install_ruby
install_python

# LSPs
yarn global add typescript typescript-language-server vscode-langservers-extracted
gem install solargraph ruby-lsp
pip install python-lsp-server

asdf reshim nodejs
asdf reshim ruby
asdf reshim python

# exit on error again
set -e

# Install Vim Plug
curl -fLo "${HOME}/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugUpgrade +PlugInstall +PlugUpdate +PlugClean! +qa

# Setup fzf
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish
