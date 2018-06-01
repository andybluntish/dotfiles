# Dotfiles

These dotfiles are for [fish shell](https://fishshell.com/) and [Neovim](https://neovim.io/).

Install the following dependencies to get started.

```sh
# the basics
brew install git fish neovim python python@2 fzf fd ripgrep tree rbenv

# Fisherman
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fisher edc/bass
fisher nvm
fisher rbenv

# pygments for syntax highlighting
pip install Pygments

# enable Python3 interface for neovim
pip3 install neovim

# setup useful key bindings and fuzzy completion for fzf
eval (brew --prefix)/opt/fzf/install --all

# if using tmux
brew install tmux reattach-to-user-namespace

# for writing JavaScript
npm i -g tern typescript
```

These are _heavily_ based on the dotfiles of [gf3](https://github.com/gf3/dotfiles), [toranb](https://github.com/toranb/dotfiles), [mathiasbynens](https://github.com/mathiasbynens/dotfiles), and [Olical](https://github.com/Olical/dotfiles), and no doubt countless others. Thank you.
