export CLICOLOR=1

export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="less -X"

export GPG_TTY=$(tty)

export FZF_DEFAULT_COMMAND="(git ls-tree -r --name-only HEAD || fd --type f --hidden --follow --exclude .git) 2> /dev/null"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

alias la="ls -lah"
alias ll="tree --dirsfirst -ChFupDaLg 1"
alias ef="fzf -m | xargs $EDITOR"
alias tree="tree -aFCN -L 1 -I 'node_modules|bower_components|tmp|vendor|typings|.git'"

alias g="git"
alias gup="git gup"

alias be="bundle exec"
alias etu="ember test --filter 'Unit | '"
alias eti="ember test --filter 'Integration | '"
alias eta="ember test --filter 'Acceptance | '"

shopt -s nocaseglob
shopt -s histappend
shopt -s cdspell

LOCAL_SH="$HOME/.local.sh"
[ -f $LOCAL_SH ] && source $LOCAL_SH
