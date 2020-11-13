# Dotfiles

Install the following dependencies to get started.

```sh
# the basics
brew install fish git

# set shell
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

# setup useful key bindings and fuzzy completion for fzf
eval (brew --prefix)/opt/fzf/install --all

# clone dotfiles
git clone git@github.com:andybluntish/dotfiles.git "$HOME/Dotfiles"
cd $HOME/Dotfiles

# install apps
brew bundle

# bootstrap dotfiles
./bootstrap.sh

# install node
set node_version 14.15.0
nodenv install $node_version
nodenv global $node_version

# install ruby
set ruby_version 2.7.2
rbenv install $ruby_version
rbenv global $ruby_version

# for writing JavaScript
yarn global add eslint prettier live-server typescript

# enable Node and Python interfaces for neovim
gem install neovim
pip install neovim
yarn global add neovim
```
