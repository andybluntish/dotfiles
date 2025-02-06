set fish_greeting

set -x EDITOR nvim
set -x VISUAL nvim
set -x PAGER "less -X"
set -x PNPM_HOME "$HOME/.pnpm"
set -x ASDF_DATA_DIR "$HOME/.asdf"

set -x FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git \$dir 2> /dev/null"
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

fish_add_path "/opt/homebrew/bin/"
fish_add_path "/opt/homebrew/sbin/"
fish_add_path "$PNPM_HOME"
fish_add_path "$HOME/.yarn/bin"
fish_add_path "$HOME/.bin"
fish_add_path "$ASDF_DATA_DIR/shims"

fish_add_path -a "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fish_add_path -a "/Applications/Blender.app/Contents/MacOS"

abbr -a vim $EDITOR
abbr -a nvim $EDITOR
abbr -a g git
abbr -a gg lazygit
abbr -a gup "git gup"
abbr -a be "bundle exec"
abbr -a df "df -h"
abbr -a c bat

# source additional config local to this machine
if test -e ~/.config/fish/config.local.fish
  source ~/.config/fish/config.local.fish
end

direnv hook fish | source
