#!/usr/bin/env bash

[ -f "$HOME/.sh.sh" ] && source "$HOME/.sh.sh"

export PS1="\[\033[0;33m\]\w\[\033[0m\]\n❯ "

shopt -s autocd
shopt -s cdspell
shopt -s dirspell
shopt -s extglob
shopt -s globstar
shopt -s histappend
shopt -s nocaseglob

eval "$($HOMEBREW_LOCATION/bin/brew shellenv)"
eval "$(nodenv init -)"
eval "$(rbenv init -)"
eval "$(pyenv init --path)"
eval "$(starship init bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Bash completion
[[ -r "$HOMEBREW_LOCATION/etc/profile.d/bash_completion.sh" ]] && . "$HOMEBREW_LOCATION/etc/profile.d/bash_completion.sh"

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f $HOMEBREW_LOCATION/etc/bash_completion.d/git-completion.bash ]; then
  complete -o default -o nospace -F _git g;
fi;
