#!/usr/bin/env zsh

# ~/.zshrc - zsh config file
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
  # PS_ARROW='➜'
  PS_ARROW='❯'
else # we're on Linux 
  LS_FLAGS='--color=auto'
  eval $(dircolors -b)
  export TERM=xterm-256color
  # PS_ARROW='➜'
  # PS_ARROW='>'
  PS_ARROW='❯'
fi

export COLORFGBG="default;default" # for mutt & vim

# export MAIL=${MAIL:-/var/mail/$USER}

# integrate vim goodness
export EDITOR=vim
export VISUAL=vim
bindkey -v 
fg-vim() {
  fg %vim
}
zle -N fg-vim
bindkey '^Z' fg-vim

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# huge history
export HISTFILE=$HOME/.zsh/history
export HISTSIZE=5000
export SAVEHIST=$HISTSIZE
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt histignorealldups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt inc_append_history
setopt share_history
unsetopt nomatch

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# directory stack
export dirstacksize=20
DIRSTACKFILE=~/.zdirs
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

# automatically pushd
setopt auto_pushd
setopt pushd_ignore_dups

# automatically enter directories without cd
setopt auto_cd

# handy cd movements from zshkit
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt cdablevars
setopt multios

# resolve symlinks 
setopt chase_links

# try to correct command line spelling
setopt CORRECT CORRECT_ALL

# enable extended globbing
setopt extended_glob

# don't match dotfiles. ever.
setopt noglobdots

# try to avoid the 'zsh: no matches found...'
setopt nonomatch

# use zsh style word splitting
 setopt noshwordsplit

 # report the status of backgrounds jobs immediately
 setopt notify

#unsetopt menu_complete   # do not autoselect the first completion entry
#unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

# code versioning
autoload -Uz vcs_info

# easy renaming
autoload -U zmv

# command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# file rename magick
bindkey "^[m" copy-prev-shell-word

# jobs
setopt long_list_jobs

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

# load custom goodness
for GOODIES ($HOME/.zsh/plugins/*.zsh); do
  source $GOODIES
done

# extra completions
if [ -d $HOME/.zsh/extras/zsh-completions ]; then
  fpath=($HOME/.zsh/extras/zsh-completions/src $fpath)
fi

# fish shell like syntax highlighting
if [ -d $HOME/.zsh/extras/zsh-syntax-highlighting ]; then
  source $HOME/.zsh/extras/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# load & init completions last
autoload -Uz compinit && compinit

#date +"%F"

# vim:ft=zsh
