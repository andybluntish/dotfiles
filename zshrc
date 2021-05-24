#!/usr/bin/env zsh

[ -f "$HOME/.base.sh" ] && source "$HOME/.base.sh"

export PROMPT="%F{cyan}%~
%F{reset_color}❯ "

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST="$HISTSIZ"

bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

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

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(nodenv init -)"
eval "$(rbenv init -)"
eval "$(pyenv init --path)"
eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# autoload -Uz compinit
# compinit

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.cache/zsh/zcompcache"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
