# Dotfiles

Install the following dependencies to get started.

```sh
# the basics
brew install fish git neovim bat python fzf fd ripgrep tree nodenv rbenv yarn

# set shell
echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

# setup useful key bindings and fuzzy completion for fzf
eval (brew --prefix)/opt/fzf/install --all

# if using tmux
brew install tmux reattach-to-user-namespace

# clone dotfiles
git clone git@github.com:andybluntish/dotfiles.git "$HOME/Dotfiles"
cd $HOME/Dotfiles
./bootstrap.sh

# install node
set node_version 10.16.0
nodenv install $node_version
nodenv global $node_version

# install ruby
set ruby_version 2.6.3
rbenv install $ruby_version
rbenv global $ruby_version

# for writing JavaScript
yarn global add tern typescript

# enable Node and Python interfaces for neovim
pip install neovim
yarn global add neovim
```
