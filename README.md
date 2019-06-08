# Dotfiles

Install the following dependencies to get started.

```sh
# the basics
brew install fish bash zsh git neovim bat python python@2 fzf fd ripgrep tree rbenv yarn

# enable Node and Python interfaces for neovim
pip3 install neovim
yarn global add neovim

# setup useful key bindings and fuzzy completion for fzf
$(brew --prefix)/opt/fzf/install --all

# if using tmux
brew install tmux reattach-to-user-namespace

# for writing JavaScript
yarn global add tern typescript
```
