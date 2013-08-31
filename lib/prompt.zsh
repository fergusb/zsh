#!/usr/bin/env zsh

# advanced prompts
autoload -U promptinit && promptinit

# expand functions in the prompt
setopt prompt_subst

# nice git prompt by Ian McKellar
function __git_prompt {
  local CLEAN="%{$fg[green]%}"
  local DIRTY="%{$fg[magenta]%}"
  local UNMERGED="%{$fg[red]%}"
  local RESET="%{$terminfo[sgr0]%}"
  git rev-parse --git-dir >& /dev/null
  if [[ $? == 0 ]]; then
    echo -n "["
    if [[ `git ls-files -u >& /dev/null` == '' ]]; then
      git diff --quiet >& /dev/null
      if [[ $? == 1 ]]; then
        echo -n $DIRTY
      else
        git diff --cached --quiet >& /dev/null
        if [[ $? == 1 ]]; then
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
  *) PS1="${PROMPT}%{$fg[white]%}➜%{$reset_color%} ";; # mortals
esac

# vi mode indicator
MODE_INDICATOR="%{$fg[white]%}CMD%{$reset_color%}"

function zle-keymap-select zle-line-init zle-line-finish {
  VI_MODE="${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}" # only show CMD
  zle reset-prompt
  zle -R
}
zle -N zle-keymap-select
zle -N zle-line-init
zle -N zle-line-finish

RPROMPT=' ${VI_MODE}'
