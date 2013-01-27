#!/usr/bin/env zsh

# ~/.zshrc - zsh config file
# From: Fergus Bremner
# Email: <fergus.bremner@gmail.com>
 
# set PATH so it includes user bin if it exists
if [ -d ~/bin ] ; then
	PATH=~/bin:"${PATH}"
fi

export PATH

EDITOR="vim"
VISUAL="vim"
bindkey -v 

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# automatically pushd
setopt auto_pushd
export dirstacksize=5

# automatically enter directories without cd
setopt auto_cd

# awesome cd movements from zshkit
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt cdablevars

# try to correct command line spelling
setopt CORRECT CORRECT_ALL

# resolve symlinks 
setopt CHASE_LINKS

# enable extended globbing
setopt EXTENDED_GLOB

# completion
autoload -U compinit && compinit

# rainbows
autoload -U colors && colors

# advanced prompts
autoload -U promptinit && promptinit

# expand functions in the prompt
setopt prompt_subst

# prompt
PROMPT="%{$fg[blue]%}[%n@%m:%~]%{$reset_color%}
 "
case `id -u` in 
  0) PS1="${PROMPT}# ";; # root
  *) PS1="${PROMPT}> ";; # mortals
esac

# awesome rprompt by Ian McKellar
function __git_prompt {
  local CLEAN="%{$fg[green]%}"
  local DIRTY="%{$fg[magenta]%}"
  local UNMERGED="%{$fg[red]%}"
  local RESET="%{$terminfo[sgr0]%}"
  git rev-parse --git-dir >& /dev/null
  if [[ $? == 0 ]]
  then
    echo -n "["
    if [[ `git ls-files -u >& /dev/null` == '' ]]
    then
      git diff --quiet >& /dev/null
      if [[ $? == 1 ]]
      then
        echo -n $DIRTY
      else
        git diff --cached --quiet >& /dev/null
        if [[ $? == 1 ]]
        then
          echo -n $DIRTY
        else
          echo -n $CLEAN
        fi
      fi
    else
      echo -n $UNMERGED
    fi
    echo -n `git branch | grep '* ' | sed 's/..//'`
    echo -n $RESET
    echo -n "]"
  fi
}
 
export RPS1='$(__git_prompt)'

# huge history
export HISTSIZE=5000
export HISTFILE="$HOME/.zsh/history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history

# functions
if [ -e "$HOME/.zsh/functions" ]; then
  source "$HOME/.zsh/functions"
fi

# aliases
if [ -e "$HOME/.zsh/aliases" ]; then
  source "$HOME/.zsh/aliases"
fi

# vim:ft=zsh
