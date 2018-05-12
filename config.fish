set fish_greeting

set -x EDITOR nvim
set -x FZF_DEFAULT_COMMAND 'git ls-tree -r --name-only HEAD 2> /dev/null; or fd --type f --hidden --follow --exclude .git 2> /dev/null'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x GPG_TTY (tty)
set -x GREP_COLOR "30;43"
set -x LS_COLORS 'di=34:fi=0:ln=35:or=31:mi=0:ex=35;1'

set PATH $HOME/.bin $HOME/.yarn/bin $PATH
