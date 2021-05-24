#!/usr/bin/env bash

[ -f "$HOME/.base.sh" ] && source "$HOME/.base.sh"

export PS1="\[\033[0;33m\]\w\[\033[0m\]\n❯ "

shopt -s autocd
shopt -s cdspell
shopt -s dirspell
shopt -s extglob
shopt -s globstar
shopt -s histappend
shopt -s nocaseglob

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(nodenv init -)"
eval "$(rbenv init -)"
eval "$(pyenv init --path)"
eval "$(starship init bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Bash completion
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /opt/homebrew/etc/bash_completion.d/git-completion.bash ]; then
  complete -o default -o nospace -F _git g;
fi;
