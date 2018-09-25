#!/usr/bin/env bash

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# rbenv
eval "$(rbenv init -)"
