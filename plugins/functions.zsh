#!/usr/bin/env zsh

# cd to directoy and list files
cl() {
  emulate -L zsh
  cd $1 && ls -la
}

# make dir and switch to it
function mcd {
  mkdir -p $1
  cd $1
}

# handy calculator
calc () {
  awk "BEGIN { print $* ; }"
}

# qfind - used to quickly find files that contain a string in a directory
qfind () {
    find . -exec grep -l $1 {} \;
    return 0
}

# extract depending on extension
extract() {
  emulate -L zsh
  setopt extended_glob noclobber
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1     ;;
      *.tar.gz)    tar xvzf $1     ;;
      *.tar.xz)    tar xvJf $1     ;;
      *.bz2)       bunzip2 $1      ;;
      *.rar)       unrar x $1      ;;
      *.gz)        gunzip $1       ;;
      *.tar)       tar xvf $1      ;;
      *.tbz2)      tar xvjf $1     ;;
      *.tgz)       tar xvzf $1     ;;
      *.zip)       unzip $1        ;;
      *.Z)         uncompress $1   ;;
      *.7z)        7z x $1         ;;
      *)           echo "'$1' cannot be extracted via >extract<" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# creates archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

# find stuff; do stuff
ff() { find . -type f -iname '*'$*'*' ; }
fe() { find . -type f -iname '*'${1:-}'*' -exec ${2:-file} {} \;  ; }

# recursively fix dir/file permissions on a given dir
fixperms() {
  if [ -d "$1" ]; then 
    find "$1" -type d -exec chmod 755 {} \; 
    find "$1" -type f -exec chmod 644 {} \;
  else
    echo "usage: fixperms [directory]"
  fi
}

# passwd generator
zpasswd() {
  if [ "$1" ]; then 
    LC_ALL=C tr -dc '0-9A-Za-z_@#%*,.:?!~' < /dev/urandom | head -c${1:-$1}
    echo
  else
    echo "Please specify a password length"
  fi
}

# symlink regardless of order passed
symlink() {
  if [ $# -ne 2 ]; then
    echo "usage: symlink [link] [target]"
    echo "   or: symlink [target] [link]"
    echo
  elif [ -e $1 -a -e $2 ]; then
    echo "error: both files exist."
  elif [ ! -e $1 -a ! -e $2 ]; then
    echo "error: neither file exists."
  elif [ -e $1 ]; then
    ln -s $1 $2
  else
    ln -s $2 $1
  fi
}

# pet - register previous command
function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

# pet - search snippets and output on the shell
function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
bindkey '^s' pet-select

# Translate DE<=>EN
# 'translate' looks up fot a word in a file with language-to-language
# translations (field separator should be " : "). A typical wordlist looks
# like at follows:
#  | english-word : german-transmission
# It's also only possible to translate english to german but not reciprocal.
# Use the following oneliner to turn back the sort order:
#  $ awk -F ':' '{ print $2" : "$1" "$3 }' \
#    /usr/local/lib/words/en-de.ISO-8859-1.vok > ~/.translate/de-en.ISO-8859-1.vok
#f5# Translates a word
trans() {
    emulate -L zsh
    case "$1" in
        -[dD]*)
            translate -l de-en $2
            ;;
        -[eE]*)
            translate -l en-de $2
            ;;
        *)
            echo "Usage: $0 { -D | -E }"
            echo "         -D == German to English"
            echo "         -E == English to German"
    esac
}

if [[ $(uname) == 'Darwin' ]]; then # if we're on OS X
  function vol() {
    if [[ -n $1 ]]; then 
      osascript -e "set volume output volume $1"
    else
      osascript -e "output volume of (get volume settings)"
    fi
  } 
fi

# vim:ft=zsh
