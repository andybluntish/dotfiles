# rbenv
eval "$(rbenv init -)"

# Paths
export PATH="$HOME/bin:$(brew --prefix)/bin:$(brew --prefix)/share/python:$(brew --prefix)/share/npm/bin:$PATH"

# Default Editor
export EDITOR="mvim -fv"

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Homebrew bash-completion
# https://github.com/mxcl/homebrew
# brew install bash-completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

# Prompt
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
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Prompt
PS1="${CYAN}\w${WHITE}\$( [[ \$(parse_git_branch) ]] && echo \" → \")${MAGENTA}\$(parse_git_branch)${COLOR_RESET} 🍔  "

# Show/hide hidden files in Finder
alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall -HUP Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall -HUP Finder"

# Quick way to rebuild the Launch Services database and get rid
# of duplicates in the Open With submenu.
alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

# Base64 encode a file for use in CSS
function cssBase64() {
  echo "url(data:$(file -b --mime-type $1);base64,$(openssl base64 < $1 | tr -d '\n'))" | pbcopy
}

# Notes for updating libraries
function update_notes() {
  echo "
===============================================================================
Update Notes
===============================================================================

# Homebrew

brew update    # update the list of packages
brew outdated  # list installed packages that have updates
brew upgrade   # upgrade outdated packages to the current version
brew cleanup   # remove old versions of updated packages


# Node Package Manager

npm -g outdated  # list outdated packages (globally installed)
npm -g update    # updated outdated packages (globally installed)


# Ruby and RubyGems

gem outdated         # list outdated gems
gem update           # update installed gems to the latest version
gem update --system  # update RubyGems itself
gem cleanup          # remove old versions of updated gems


# Janus

cd ~/.vim && rake


# Dotfiles

git submodule foreach git pull  # update git submodules

===============================================================================
"
}
