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

# re-use ssh-agent and/or gpg-agent between logins
[[ -f $(which keychain 2> /dev/null)  ]] && \
  keychain -q --nogui $HOME/.ssh/id_rsa

# fish shell like syntax highlighting
if [[ -d $HOME/.zsh/extras/zsh-syntax-highlighting ]]; then
  export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$HOME/.zsh/extras/zsh-syntax-highlighting/highlighters
fi

# linux X
[[ -z $DISPLAY && $XDG_VTNR -eq 1  ]] && exec startx

#date +"%F"
