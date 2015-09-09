#!/usr/bin/env zsh

# rainbows
autoload -U colors && colors

# advanced prompts
autoload -U promptinit && promptinit

# expand functions in the prompt
setopt prompt_subst

# git prompt magic - see git-prompt.zsh
export PS2='$(git_super_status)'

# ssh coloration
if [[ "$SSH_CONNECTION" != '' ]]; then
  SSH_COLOR='%{$fg[red]%}'
else
  SSH_COLOR='%{$fg[white]%}'
fi

# prompt
PROMPT="%{$fg[blue]%}[%n@%m:%~]%{$reset_color%}$PS2
"

case `id -u` in 
  0) PS1="${PROMPT}${SSH_COLOR}#%{$reset_color%}";; # root
  *) PS1="${PROMPT}${SSH_COLOR}${PS_ARROW}%{$reset_color%}";; # mortals
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
