echo "Hi there 👋"

export CLICOLOR=1
export PS1="\w $ "
export EDITOR="vim"
export MANPAGER="less -X"
export PATH="$HOME/.bin:$HOME/.yarn/bin:$PATH"

alias la="ls -lah"
alias gup="git gup"
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
