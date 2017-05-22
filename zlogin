#!/usr/bin/env zsh

# X when appropriate
# [[ -z $DISPLAY && $XDG_VTNR -eq 1  ]] && \
  # exec startx

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi

#date +"%F"
