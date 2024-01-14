#!/usr/bin/env bash

set -euo pipefail
[ ${DEBUG:-} ] && set -x

node_version=""
ruby_version=""
python_version=""

while getopts ":n:r:p:" opt; do
  case $opt in
    n) node_version="$OPTARG"
    ;;
    r) ruby_version="$OPTARG"
    ;;
    p) python_version="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

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
    echo "Installing node ${node_version}"

    asdf plugin add nodejs "https://github.com/asdf-vm/asdf-nodejs.git"
    asdf install nodejs "${node_version}"
    asdf global nodejs "${node_version}"
  fi

  pnpm add --global neovim eslint prettier typescript
  asdf reshim nodejs
}

function install_ruby() {
  if [ "${ruby_version}" ]; then
    echo "Installing ruby ${ruby_version}"

    asdf plugin add ruby "https://github.com/asdf-vm/asdf-ruby.git"
    RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)" asdf install ruby "${ruby_version}"
    asdf global ruby "${ruby_version}"
  fi

  gem install neovim bundler
  asdf reshim ruby
}

function install_python() {
  if [ "${python_version}" ]; then
    echo "Installing python ${python_version}"

    asdf plugin-add python "https://github.com/danhper/asdf-python.git"
    asdf install python "${python_version}"
    asdf global python "${python_version}"
  fi

  pip install pynvim
  asdf reshim python
}

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

# exit on error again
set -e

# Install Vim Plug
curl -fLo "${HOME}/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugUpgrade +PlugInstall +PlugUpdate +PlugClean! +TSUpdateSync +MasonUpdate +qa

# Setup fzf
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish
