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
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8  
export LC_CTYPE=$LANG

export COLORFGBG="default;default" # for mutt & vi

# integrate vim goodness
export EDITOR=vim
export VISUAL=vim
bindkey -v 

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# huge history
export HISTSIZE=5000
export HISTFILE=$HOME/.zsh/history
export SAVEHIST=$HISTSIZE
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history
unsetopt nomatch

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# automatically pushd
setopt auto_pushd
export dirstacksize=10

# automatically enter directories without cd
setopt auto_cd

# handy cd movements from zshkit
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt cdablevars
setopt multios
#DIRSTACKSIZE=10

# try to correct command line spelling
setopt CORRECT CORRECT_ALL

# resolve symlinks 
setopt CHASE_LINKS

# enable extended globbing
setopt EXTENDED_GLOB

#unsetopt menu_complete   # do not autoselect the first completion entry
#unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

# rainbows
autoload -U colors && colors

# command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# ls rainbow
export CLICOLOR=1
#export LS_COLORS
export LSCOLORS="Gxfxcxdxbxegedabagacad"

if [ "$DISABLE_LS_COLORS" != "true" ]
then
  # find the option for using colors in ls, depending on the version: Linux or BSD
  ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
fi

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

# keychain for gpg-agent
if (( $+commands[keychain] )) ; then
  #eval $(keychain $HOME/.ssh/id_dsa --eval --quiet)
  #eval $(keychain --eval --clear --quiet)
fi

# python virtualenv(s)
if [ -d $HOME/.virtualenv ]; then
  source $HOME/.virtualenv/bin/activate
elif [ -d $HOME/.virtualenvs ]; then
  export WORKON_HOME=$HOME/.virtualenvs
  source /usr/local/bin/virtualenvwrapper.sh
fi

# fish shell like syntax highlighting
if [ -d $HOME/.zsh/extras/zsh-syntax-highlighting ]; then
  source $HOME/.zsh/extras/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# extra completions
if [ -d $HOME/.zsh/extras/zsh-completions ]; then
  fpath=($HOME/.zsh/extras/zsh-completions/src $fpath)
fi

# load custom goodness
for GOODIES ($HOME/.zsh/lib/*.zsh); do
  source $GOODIES
done

# load & init completions last
autoload -Uz compinit && compinit

#date +"%d-%m-%Y"

# vim:ft=zsh
