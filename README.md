# Dotfiles

Install the following dependencies to get started.

```sh
# the basics
brew install git neovim python python@2 fzf fd ripgrep tree rbenv

# enable Python3 interface for neovim
pip3 install neovim

# setup useful key bindings and fuzzy completion for fzf
$(brew --prefix)/opt/fzf/install --all

# if using tmux
brew install tmux reattach-to-user-namespace

# for writing JavaScript
npm i -g tern typescript
```
