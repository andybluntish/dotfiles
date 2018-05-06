echo "Hi there 👋"

export CLICOLOR=1
export PS1="\w $ "
export EDITOR="vim"
export MANPAGER="less -X"
export PATH="$HOME/.bin:$HOME/.yarn/bin:$PATH"

alias la="ls -lah"
alias g="git"
alias gup="g gup"
alias tree="tree -I 'node_modules|bower_components|tmp|vendor|typings'"

if [ -x "$(command -v pygmentize)" ]; then
  alias c='pygmentize -O style=monokai -f console256 -g'
else
  alias c=cat
fi

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
bind '"\e\e[C": forward-word'
bind '"\e\e[D": backward-word'
bind '"\e[3;3~": kill-word'

shopt -s nocaseglob
shopt -s histappend
shopt -s cdspell

set completion-ignore-case on
set show-all-if-ambiguous on
set mark-symlinked-directories on
set match-hidden-files off
set page-completions off
set completion-query-items 200
set visible-stats on
set skip-completed-text on
set input-meta on
set output-meta on
set convert-meta off

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# Colours
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
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}
function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Prompt
export PS1="${CYAN}\w${WHITE}\$( [[ \$(parse_git_branch) ]] && echo \" → \")${MAGENTA}\$(parse_git_branch)${COLOR_RESET} $ "
