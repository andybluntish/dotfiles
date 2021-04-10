#!/usr/bin/env bash

export PATH="$HOME/.bin:/Applications/Blender.app/Contents/MacOS:$PATH"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export CLICOLOR=1
export MANPAGER="less -X"
export GPG_TTY=$(tty)
export FZF_DEFAULT_COMMAND="(fd --type f --hidden --follow --exclude .git || git ls-tree -r --name-only HEAD) 2> /dev/null"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export PS1="\[\033[0;33m\]\w\[\033[0m\]\n❯ "

alias vim="$EDITOR"
alias nvim="$EDITOR"
alias la="ls -lah"
alias ef="fzf -m | xargs $EDITOR"
alias c="bat"
alias be="bundle exec"
alias tree="tree -aFCN -L 1 -I 'node_modules|bower_components|tmp|vendor|typings|.git'"
alias ll="tree --dirsfirst -ChFupDaLg 1"
alias g="git"
alias gup="git gup"

shopt -s autocd
shopt -s cdspell
shopt -s dirspell
shopt -s extglob
shopt -s globstar
shopt -s histappend
shopt -s nocaseglob

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(rbenv init -)"
eval "$(nodenv init -)"
eval "$(starship init bash)"

# Bash completion
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /opt/homebrew/etc/bash_completion.d/git-completion.bash ]; then
  complete -o default -o nospace -F _git g;
fi;
