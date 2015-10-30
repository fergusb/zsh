#!/usr/bin/env zsh

# ~/.zshenv - zsh config file
# From: Fergus Bremner
# Email: <fergus.bremner@gmail.com>
 
# set PATH so it includes user bin (if it exists)
if [ -d $HOME/bin ] ; then
  export PATH=$HOME/bin:$PATH
fi

export PATH=/usr/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH

# you say tomato, I say tomahto
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8  
export LC_CTYPE=$LANG

for var in LANG LC_ALL LC_MESSAGES ; do
  [[ -n ${(P)var} ]] && export $var
done

# color setup for ls
if [[ $(uname) == 'Darwin' ]]; then # we're on OS X
  # export LSCOLORS="Gxfxcxdxbxegedabagacad"
  LS_FLAGS='-G'
  export CLICOLOR=1
  PS_ARROW=' ➜ '
  # PS_ARROW='❯ '
else # we're on Linux 
  LS_FLAGS='--color=auto'
  eval $(dircolors -b)
  export TERM=xterm-256color
  PS_ARROW=' > '
fi

export COLORFGBG="default;default" # for mutt & vim

# export MAIL=${MAIL:-/var/mail/$USER}
 
# huge history
export HISTFILE=$HOME/.zsh/history
export HISTSIZE=5000
export SAVEHIST=$HISTSIZE

# directory stack
export DIRSTACKSIZE=9

# vim goodness
export EDITOR=vim
export VISUAL=vim

# pager
export PAGER="less"
export LESS="-R"

# python virtualenv(s)
if [[ -n "$commands[virtualenvwrapper.sh]" ]]; then
  export WORKON_HOME=$HOME/.virtualenvs
  export PROJECT_HOME=$HOME/Projects
  export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
  if [ ! -d "$WORKON_HOME" ] ; then
    mkdir -p $WORKON_HOME
  fi
  source $VIRTUALENVWRAPPER_SCRIPT
fi

# ruby env
if [ -d $HOME/.rbenv ] ; then
  eval "$(rbenv init -)"
fi

# reliable SSH authentication socket location
SOCK="/tmp/ssh-agent-$USER-env"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f /tmp/ssh-agent-$USER-env
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi

# fish shell like syntax highlighting
if [[ -d $HOME/.zsh/extras/zsh-syntax-highlighting ]]; then
  export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$HOME/.zsh/extras/zsh-syntax-highlighting/highlighters
fi
