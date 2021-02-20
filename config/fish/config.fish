set fish_greeting

set -x PATH $HOME/.bin $PATH
set -x EDITOR nvim
set -x VISUAL $EDITOR
set -x GPG_TTY (tty)
set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git 2> /dev/null'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

abbr -g vim "$EDITOR"
abbr -g nvim "$EDITOR"
abbr -g g "git"
abbr -g gup "git gup"
abbr -g be "bundle exec"

alias df="df -h"
alias tree="tree -aFCN -L 1 -I 'node_modules|bower_components|tmp|vendor|typings|.git'"
alias ll="tree --dirsfirst -ChFupDaLg 1"

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
# - if image, render with terminal-image-cli
function c
  if test (count $argv) -eq 0
    if type tree > /dev/null
      tree
    else
      la
    end

    return
  end

  for i in $argv
    set_color yellow
    if test (count $argv) -gt 1; echo "$i:" 1>&2; end
    set_color normal

    if test -e $i; and test -r $i
      if test -d $i
        if type tree > /dev/null
          tree $i
        else
          la $i
        end

        return
      else if file -b --mime-type $i | string match -q -r '^image\/'
        if type image > /dev/null
          image $i

          return
        end
      else
        if type bat > /dev/null
          bat $i
        else
          cat $i
        end

        return
      end
    end

    set_color red
    echo "Cannot open: $i" 1>&2
    set_color normal
  end
end

################################################################################
# Version Managers
################################################################################

status --is-interactive; and source (/opt/homebrew/bin/brew shellenv -|psub)
status --is-interactive; and source (nodenv init -|psub)
status --is-interactive; and source (rbenv init -|psub)
status --is-interactive; and starship init fish | source
