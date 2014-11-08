#!/usr/bin/env zsh

# handy calculator
function calc () {
  awk "BEGIN { print $* ; }"
}

# qfind - used to quickly find files that contain a string in a directory
qfind () {
    find . -exec grep -l $1 {} \;
    return 0
}

# extract depending on extension
function extract() {
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
function mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
function mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
function mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

# find stuff; do stuff
function ff() { find . -type f -iname '*'$*'*' ; }
function fe() { find . -type f -iname '*'${1:-}'*' -exec ${2:-file} {} \;  ; }

# recursively fix dir/file permissions on a given dir
function fixperms() {
  if [ -d "$1" ]; then 
    find "$1" -type d -exec chmod 755 {} \; 
    find "$1" -type f -exec chmod 644 {} \;
  else
    echo "usage: fixperms [directory]"
  fi
}

# make dir and switch to it
function mcd {
  mkdir -p $1
  cd $1
}

# symlink regardless of order passed
function symlink() {
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
