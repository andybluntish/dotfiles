#!/usr/bin/env bash

export CLICOLOR=1
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="less -X"
export GPG_TTY=$(tty)

export FZF_DEFAULT_COMMAND="(git ls-tree -r --name-only HEAD || fd --type f --hidden --follow --exclude .git) 2> /dev/null"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export GOPATH=$HOME/Code/go
export PATH=$HOME/.bin:$GOPATH/bin:$PATH

alias la="ls -lah"
alias ll="tree --dirsfirst -ChFupDaLg 1"
alias ef="fzf -m | xargs $EDITOR"
alias tree="tree -aFCN -L 1 -I 'node_modules|bower_components|tmp|vendor|typings|.git'"
alias c="bat"

alias g="git"
alias gup="git gup"

alias be="bundle exec"
alias etu="ember test --filter 'Unit | '"
alias eti="ember test --filter 'Integration | '"
alias eta="ember test --filter 'Acceptance | '"

shopt -s autocd
shopt -s cdspell
shopt -s dirspell
shopt -s extglob
shopt -s globstar
shopt -s histappend
shopt -s nocaseglob

# Prompt
COLOR_RESET="\[\033[0m\]"
LIGHT_WHITE="\[\033[1;37m\]"
WHITE="\[\033[0;37m\]"
GRAY="\[\033[1;30m\]"
BLACK="\[\033[0;30m\]"
RED="\[\033[0;31m\]"
LIGHT_RED="\[\033[1;31m\]"
GREEN="\[\033[0;32m\]"
LIGHT_GREEN="\[\033[1;32m\]"
YELLOW="\[\033[0;33m\]"
LIGHT_YELLOW="\[\033[1;33m\]"
BLUE="\[\033[0;34m\]"
LIGHT_BLUE="\[\033[1;34m\]"
MAGENTA="\[\033[0;35m\]"
LIGHT_MAGENTA="\[\033[1;35m\]"
CYAN="\[\033[0;36m\]"
LIGHT_CYAN="\[\033[1;36m\]"

# Parse Git branch
function parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo " *"
}
function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Prompt
PS1="${YELLOW}\w${WHITE}\$( [[ \$(parse_git_branch) ]] && echo \" → \")${LIGHT_BLUE}\$(parse_git_branch)${COLOR_RESET}\n❯ "

# Bash completion
if [ -f /usr/local/share/bash-completion/bash_completion ]; then
  . /usr/local/share/bash-completion/bash_completion
fi

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
  complete -o default -o nospace -F _git g;
fi;

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# rbenv
eval "$(rbenv init -)"
eval "$(nodenv init -)"

[ -f "$HOME/.local.sh" ] && source "$HOME/.local.sh"
