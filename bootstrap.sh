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

function fetch_shell_config() {
  local local_file="${HOME}/.zshrc"
  local remote_file="https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc"

  # Check if the local file is older than 1 month
  local expiry_timestamp=$(date -v -1m +%s)
  local local_last_modified=$(stat -f %m "${local_file}" 2>/dev/null || echo "0")

  if [ ! -f "${local_file}" ] || [ "${local_last_modified}" -lt "${expiry_timestamp}" ]; then
    echo "Shell config: fetching zshrc: ${remote_file} -> ${local_file}"
    curl -fLo "${local_file}" "${remote_file}"
  else
    echo "Shell config: zshrc is up to date"
  fi
}

function install_node() {
  echo "Installing node ${node_version}"

  asdf plugin add nodejs "https://github.com/asdf-vm/asdf-nodejs.git"
  asdf install nodejs "${node_version}"
  asdf set --home nodejs "${node_version}"
}

function install_ruby() {
  echo "Installing ruby ${ruby_version}"

  asdf plugin add ruby "https://github.com/asdf-vm/asdf-ruby.git"
  asdf install ruby "${ruby_version}"
  asdf set --home ruby "${ruby_version}"
}

function install_python() {
  echo "Installing python ${python_version}"

  asdf plugin add python "https://github.com/danhper/asdf-python.git"
  asdf install python "${python_version}"
  asdf set --home python "${python_version}"
}

function install_default_packages() {
  local filename=$1
  local install_command=$2
  local lines=()
  while IFS= read -r line; do
    lines+=("$line")
  done < "$filename"
  $install_command "${lines[@]}"
}

# Homebrew
brew bundle

# Shell config from grml (https://grml.org/zsh/)
fetch_shell_config

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

mkdir -p "${HOME}/.config/ghostty"
link "config/ghostty/config" "${HOME}/.config/ghostty/"

mkdir -p "${HOME}/.config/fish"
link "config/fish/config.fish" "${HOME}/.config/fish/"
link "config/fish/config.local.fish" "${HOME}/.config/fish/"
link "config/fish/functions" "${HOME}/.config/fish/"

mkdir -p "${HOME}/.config/nvim/queries/gotmpl"
link "config/nvim/init.vim" "${HOME}/.config/nvim/"
link "config/nvim/queries/gotmpl/injections.scm" "${HOME}/.config/nvim/queries/gotmpl/"

link "default-npm-packages"
link "default-gems"
link "default-python-packages"

# continue on error installing languages
set +e

# Node
[[ "${node_version}" ]] && install_node
if is_exec node; then
  install_default_packages "default-npm-packages" "npm install -g"
  asdf reshim nodejs
fi

# Ruby
[[ "${ruby_version}" ]] && install_ruby
if is_exec ruby; then
  install_default_packages "default-gems" "gem install"
  asdf reshim ruby
fi

# Python
[[ "${python_version}" ]] && install_python
if is_exec python; then
  install_default_packages "default-python-packages" "pip install"
  asdf reshim python
fi

# exit on error again
set -e

# Install Vim Plug
curl -fLo "${HOME}/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugUpgrade +PlugInstall +PlugUpdate +PlugClean! +TSUpdateSync +MasonUpdate +qa

# Setup fzf
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc

# Setup asdf
mkdir -p "${HOME}/.asdf/completions/zsh"
asdf completion zsh > "${HOME}/.asdf/completions/zsh/_asdf"
asdf completion fish > ~/.config/fish/completions/asdf.fish
