#!/usr/bin/env zsh

export PATH=$HOME/.bin:$PATH
export EDITOR="nvim"
export VISUAL=$EDITOR
export CLICOLOR=1
export KEYTIMEOUT=1
export MANPAGER="less -X"
export GPG_TTY=$(tty)
export FZF_DEFAULT_COMMAND="(fd --type f --hidden --follow --exclude .git || git ls-tree -r --name-only HEAD) 2> /dev/null"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export PROMPT="%F{cyan}%~
%F{reset_color}❯ "

alias vim=$EDITOR
alias nvim=$EDITOR
alias la="ls -lah"
alias ef="fzf -m | xargs $EDITOR"
alias c="bat"
alias be="bundle exec"
alias tree="tree -aFCN -L 1 -I 'node_modules|bower_components|tmp|vendor|typings|.git'"
alias ll="tree --dirsfirst -ChFupDaLg 1"
alias g="git"
alias gup="git gup"

bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=$HISTSIZ

setopt EXTENDED_HISTORY
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt AUTO_CD
setopt GLOB_COMPLETE
setopt CORRECT
setopt CORRECT_ALL

# Completion
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt PATH_DIRS
setopt AUTO_MENU
setopt AUTO_LIST
setopt AUTO_PARAM_SLASH
setopt EXTENDED_GLOB
unsetopt MENU_COMPLETE
unsetopt FLOW_CONTROL
unsetopt CASE_GLOB

autoload -Uz compinit
compinit

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.cache/zsh/zcompcache"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(rbenv init -)"
eval "$(nodenv init -)"
eval "$(starship init zsh)"
