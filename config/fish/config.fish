set fish_greeting

set -x EDITOR nvim
set -x VISUAL nvim
set -x FZF_DEFAULT_COMMAND 'git ls-tree -r --name-only HEAD 2> /dev/null; or fd --type f --hidden --follow --exclude .git 2> /dev/null'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x GPG_TTY (tty)

set PATH $HOME/.bin $PATH

# Alias functions
alias ll="tree --dirsfirst -ChFupDaLg 1"
alias tree="tree -aFCN -L 1 -I 'node_modules|bower_components|tmp|vendor|typings|.git'"
alias df="df -h"
alias tmux="tmux -2"

# Abbreviations
abbr -g g "git"
abbr -g gup "git gup"
abbr -g be "bundle exec"

# rbenv
status --is-interactive; and source (rbenv init -|psub)

# Fuzzy find & edit file
function ef
  if test (count $argv) -gt 0
    eval $EDITOR $argv
  else
    fzf -m | xargs $EDITOR
  end
end

# Pretty view directories and files
# - if directory, list the contents with tree
# - if file(s), show the highlighted contents with bat
function c
  if test (count $argv) -eq 0
    tree ./
    return
  end

  for i in $argv
    set_color yellow
    if test (count $argv) -gt 1; echo "$i:" 1>&2; end
    set_color normal

    if test -e $i; and test -r $i
      if test -d $i
        tree $i
      # else if file -b --mime-type $i | string match -q -r '^image\/'
      #   imgcat $i
      else
        bat $i
      end
    else
      set_color red
      echo "Cannot open: $i" 1>&2
    end

    set_color normal
  end
end

# Setup additional config local to this machine
if test -e ~/.local.fish
  source ~/.local.fish
end
