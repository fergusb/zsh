#!/usr/bin/env zsh

# X when appropriate
[[ -z $DISPLAY && $XDG_VTNR -eq 1  ]] && \
  exec startx

#date +"%F"
