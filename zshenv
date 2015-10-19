#!/usr/bin/env zsh

[[ -f $HOME/.keychain/$HOST-sh  ]] && \
  source $HOME/.keychain/$HOST-sh

[[ -f $HOME/.keychain/$HOST-sh-gpg  ]] && \
  source $HOME/.keychain/$HOST-sh-gpg

# reliable SSH authentication socket location
SOCK="/tmp/ssh-agent-$USER-env"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f /tmp/ssh-agent-$USER-env
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi
