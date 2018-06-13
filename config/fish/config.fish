set fish_greeting

set -x EDITOR nvim
set -x VISUAL nvim
set -x FZF_DEFAULT_COMMAND 'git ls-tree -r --name-only HEAD 2> /dev/null; or fd --type f --hidden --follow --exclude .git 2> /dev/null'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x GPG_TTY (tty)
set -x GREP_COLOR "30;43"

set PATH $HOME/.bin $PATH

function ..    ; cd .. ; end
function ...   ; cd ../.. ; end
function ....  ; cd ../../.. ; end
function ..... ; cd ../../../.. ; end
function ll ; tree --dirsfirst -ChFupDaLg 1 $argv ; end

function tree; command tree -aFCN -L 1 -I 'node_modules|bower_components|tmp|vendor|typings|.git' $argv; end
function df; command df -h $argv; end
function tmux; command tmux -2 $argv; end

if not set -q abbrs_initialized
  set -U abbrs_initialized

  abbr g 'git'
  abbr gup 'git gup'
end

# Fuzzy find & vim
function vp
  if test (count $argv) -gt 0
    eval $EDITOR $argv
  else
    fzf -m | xargs $EDITOR
  end
end

# View files/dirs
# - if directory, list the contents with tree
# - if file(s), print the highlighted contents with pygmentize
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
        pygmentize -O style=monokai -f console256 -g $i
      end
    else
      set_color red
      echo "Cannot open: $i" 1>&2
    end

    set_color normal
  end
end
