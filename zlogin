#!/usr/bin/env zsh

# unlock keychain
[[ -f $(which keychain 2> /dev/null)  ]] && \
  keychain -q --nogui $HOME/.ssh/id_rsa

# X when appropriate
[[ -z $DISPLAY && $XDG_VTNR -eq 1  ]] && \
  exec startx

#date +"%F"
