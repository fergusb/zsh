#!/usr/bin/env zsh

# ~/.zshrc - zsh config file
# From: Fergus Bremner
# Email: <fergus.bremner@gmail.com>
 
# set PATH so it includes user bin if it exists
if [ -d ~/bin ] ; then
	PATH=~/bin:"${PATH}"
fi

export PATH

# if you REALLY like vi
EDITOR="vim"
VISUAL="vim"
bindkey -v 

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# huge history
export HISTSIZE=5000
export HISTFILE="$HOME/.zsh/history"
export SAVEHIST=$HISTSIZE
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# automatically pushd
setopt auto_pushd
export dirstacksize=10

# automatically enter directories without cd
setopt auto_cd

# awesome cd movements from zshkit
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

# completion
autoload -Uz compinit && compinit

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

# rainbows
autoload -U colors && colors

# advanced prompts
autoload -U promptinit && promptinit

# expand functions in the prompt
setopt prompt_subst

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
 
export PS2='$(__git_prompt)'

# prompt
PROMPT="%{$fg[blue]%}[%n@%m:%~]%{$reset_color%}$PS2
 "
case `id -u` in 
  0) PS1="${PROMPT}# ";; # root
  *) PS1="${PROMPT}%{$fg[red]%}➜ %{$reset_color%} ";; # mortals
esac

# vi mode indicator
MODE_INDICATOR="%{$fg_bold[white]%}CMD%{$reset_color%}"

function zle-keymap-select zle-line-init zle-line-finish {
  VI_MODE="${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
  zle reset-prompt
  zle -R
}
zle -N zle-keymap-select
zle -N zle-line-init
zle -N zle-line-finish

RPROMPT='${VI_MODE}'

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
  # Find the option for using colors in ls, depending on the version: Linux or BSD
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

export LC_CTYPE=$LANG

# functions
if [ -e "$HOME/.zsh/functions" ]; then
  source "$HOME/.zsh/functions"
fi

# aliases
if [ -e "$HOME/.zsh/aliases" ]; then
  source "$HOME/.zsh/aliases"
fi

# vim:ft=zsh
