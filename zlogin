#!/usr/bin/env zsh

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
