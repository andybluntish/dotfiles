export EDITOR="nvim"
export VISUAL="$EDITOR"
export CLICOLOR=1
export KEYTIMEOUT=1
export MANPAGER="less -X"
export GPG_TTY=$(tty)
export FZF_DEFAULT_COMMAND="(fd --type f --hidden --follow --exclude .git || git ls-tree -r --name-only HEAD) 2> /dev/null"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$HOME/.bin:$HOME/.yarn/bin:$PYENV_ROOT/bin:/Applications/Blender.app/Contents/MacOS:$PATH"

UNAME_MACHINE="$(uname -m)"
if [[ "$UNAME_MACHINE" == "arm64" ]]; then
  # On ARM macOS, Homebrew installs to /opt/homebrew
  export HOMEBREW_LOCATION="/opt/homebrew"
else
  # On Intel macOS, Homebrew installs to /usr/local
  export HOMEBREW_LOCATION="/usr/local"
fi

alias vim="$EDITOR"
alias nvim="$EDITOR"
alias g="git"
alias gup="git gup"
alias be="bundle exec"
alias df="df -h"
alias la="ls -lah"
alias ll="tree --dirsfirst -ChFupDaLg 1"
alias tree="tree -aFCN -L 1 -I 'node_modules|bower_components|tmp|vendor|typings|.git'"
alias c="bat --theme=gruvbox-dark"
alias ef="fzf -m | xargs $EDITOR"
