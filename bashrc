# Load RVM
"$HOME.rvm/scripts/rvm" ]] && source "$HOME.rvm/scripts/rvm"


# Paths
export PATH="/usr/local/bin:/usr/local/share/python:$HOME/bin:$PATH"
export NODE_PATH="/usr/local/lib/node_modules"


# Default Editor
export EDITOR="vim" # or "mvim -fv"


# Autocorrect typos in path names when using `cd`
shopt -s cdspell


# Show/hide hidden files in Finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"


# Homebrew bash-completion
# https://github.com/mxcl/homebrew
# brew install bash-completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi


# Prompt
export COLOR_RESET="\033[m"
export COLOR_BOLD="\033[1m"
export COLOR_BLACK="\033[30m"
export COLOR_RED="\033[31m"
export COLOR_GREEN="\033[32m"
export COLOR_YELLOW="\033[33m"
export COLOR_BLUE="\033[34m"
export COLOR_MAGENTA="\033[35m"
export COLOR_CYAN="\033[36m"
export COLOR_WHITE="\033[37m"

# Parse Git branch
function parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Prompt
PS1="\[${COLOR_RED}\]\u\[$COLOR_WHITE\]@\[$COLOR_CYAN\]\h\[$COLOR_WHITE\]: \[$COLOR_GREEN\]\w\[$COLOR_WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" → \")\[$COLOR_MAGENTA\]\$(parse_git_branch)\[$COLOR_WHITE\] \$ \[$COLOR_RESET\]"

