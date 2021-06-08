#!/usr/bin/env zsh

[ -f "$HOME/.base.sh" ] && source "$HOME/.base.sh"

PROMPT="%F{cyan}%~
%F{reset_color}❯ "

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST="$HISTSIZE"

# Append history list to the history file, rather than replace it.
setopt APPEND_HISTORY

# imports new commands from the history file, and also causes your typed commands to be appended to the history file.
setopt SHARE_HISTORY

# If a new command line being added to the history list duplicates an older one, the older command is removed from the list.
setopt HIST_IGNORE_ALL_DUPS

# Remove command lines from the history list when the first character on the line is a space.
setopt HIST_IGNORE_SPACE

# If a command is issued that can’t be executed as a normal command, and the command is the name of a directory, perform the cd command to that directory.
setopt AUTO_CD

# Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation, etc.
# Needed for file modification glob modifiers with compinit.
setopt EXTENDED_GLOB

# Make globbing (filename generation) sensitive to case.
unsetopt CASE_GLOB

# Require a leading ‘.’ in a filename to be matched explicitly.
setopt NO_GLOB_DOTS

# Print job notifications in the long format by default.
setopt LONG_LIST_JOBS

# Report the status of background jobs immediately.
setopt NOTIFY

# Don't send SIGHUP to background processes when the shell exits.
setopt NO_HUP

# Don't beep on error in ZLE.
setopt NO_BEEP

# Whenever a command completion or spelling correction is attempted, make sure the entire command path is hashed first.
setopt HASH_LIST_ALL

# Make cd push the old directory onto the directory stack.
setopt AUTO_PUSHD

# Don’t push multiple copies of the same directory onto the directory stack.
setopt PUSHD_IGNORE_DUPS

# use zsh style word splitting
setopt NO_SH_WORD_SPLIT

# don't error out when unset parameters are used
setopt UNSET

# Try to correct the spelling of commands.
setopt CORRECT

# Prevents aliases on the command line from being internally substituted before completion is attempted.
setopt COMPLETE_ALIASES

# Complete from both ends of a word.
setopt COMPLETE_IN_WORD

# Move cursor to the end of a completed word.
setopt ALWAYS_TO_END

# Perform path search even on command names with slashes.
setopt PATH_DIRS

# Show completion menu on a successive tab press.
setopt AUTO_MENU

# Automatically list choices on ambiguous completion.
setopt AUTO_LIST

# If completed parameter is a directory, add a trailing slash.
setopt AUTO_PARAM_SLASH

# Do not autoselect the first completion entry.
unsetopt MENU_COMPLETE

# Disable start/stop characters in shell editor.
unsetopt FLOW_CONTROL

# automatically remove duplicates from these arrays
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH

bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

autoload -Uz compinit
compinit
zstyle :compinstall filename '${HOME}/.zshrc'
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.cache/zsh/zcompcache"

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

zstyle ':completion:*' completer _oldlist _expand _complete _ignored _correct _approximate _files
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

eval "$($HOMEBREW_LOCATION/bin/brew shellenv)"
eval "$(nodenv init -)"
eval "$(rbenv init -)"
eval "$(pyenv init --path)"
eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh