##
# Aliases
##

# `cat` with beautiful colors. requires Pygments installed.
# pip Pygments
alias c='pygmentize -O style=monokai -f console256 -g'

# Show/hide hidden files in Finder
alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall -HUP Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall -HUP Finder"

# Tmuxinator
alias mux=tmuxinator

# Tree
alias tree="tree -I 'node_modules|bower_components|tmp|vendor|typings'"


##
# Functions
##

# Base64 encode a file for use in CSS
function cssBase64() {
  echo "url(data:$(file -b --mime-type $1);base64,$(openssl base64 < $1 | tr -d '\n'))" | pbcopy
}

# Convert an input video file to animated gif
function agif() {
  palette="/tmp/palette.png"
  input=$1
  output=$2
  scale=$3
  fps=$4

  if [[ "$scale" == "" ]]; then
    scale="720"
  fi

  if [[ "$fps" == "" ]]; then
    fps="10"
  fi

  filters="fps=$fps,scale=$scale:-1:flags=lanczos"

  ffmpeg -v warning -i $input -vf "$filters,palettegen" -y $palette
  ffmpeg -v warning -i $input -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $output
}


##
# Exports
##

export EDITOR="vim"
export VISUAL="vim"
