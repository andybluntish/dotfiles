###
# Load external files
###

# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
  [ -r "$file" ] && source "$file"
done
unset file


###
# Load environments
###

# Paths
export PATH="$HOME/bin:$(brew --prefix)/bin:$PATH"

# rbenv
eval "$(rbenv init -)"

# nvm
source ~/.nvm/nvm.sh



###
# Completion
###

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Homebrew bash-completion
# https://github.com/mxcl/homebrew
# brew install bash-completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# NVM bash-completion
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

# NPM bash-completion
eval "$(npm completion)"

# Grunt bash-completion
eval "$(grunt --completion=bash)"
