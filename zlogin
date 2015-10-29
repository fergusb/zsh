#!/usr/bin/env zsh

# unlock keychain
[[ -f $(which keychain 2> /dev/null)  ]] && \
  keychain -q --nogui $HOME/.ssh/id_rsa

# re-use ssh-agent and/or gpg-agent between logins
[[ -f $HOME/.keychain/$HOST-sh  ]] && \
  source $HOME/.keychain/$HOST-sh

[[ -f $HOME/.keychain/$HOST-sh-gpg  ]] && \
  source $HOME/.keychain/$HOST-sh-gpg

# X when appropriate
[[ -z $DISPLAY && $XDG_VTNR -eq 1  ]] && \
  exec startx

#date +"%F"
