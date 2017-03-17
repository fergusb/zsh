#!/usr/bin/env zsh

# reliable SSH authentication socket location
# SOCK="/tmp/ssh-agent-$USER-env"
# if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
# then
    # rm -f /tmp/ssh-agent-$USER-env
    # ln -sf $SSH_AUTH_SOCK $SOCK
    # export SSH_AUTH_SOCK=$SOCK
# fi

# fish shell like syntax highlighting - sorta
if [[ -d $HOME/.zsh/extras/zsh-syntax-highlighting ]]; then
  export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$HOME/.zsh/extras/zsh-syntax-highlighting/highlighters
fi
