#!/usr/bin/env zsh

# advanced prompts
autoload -U promptinit && promptinit

# expand functions in the prompt
setopt prompt_subst

# nice git prompt by Ian McKellar
function __git_prompt {
  local CLEAN="%{$fg[green]%}"
  local DIRTY="%{$fg[magenta]%}"
  local AHEAD="+"
  local BEHIND="-"
  local UNMERGED="%{$fg[red]%}"
  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  local RESET="%{$terminfo[sgr0]%}"
  git rev-parse --git-dir >& /dev/null
  if [[ $? == 0 ]]; then
    echo -n "["
    if [[ `git ls-files -u >& /dev/null` == '' ]]; then
      git diff --quiet >& /dev/null
      if [[ $? == 1 ]]; then
        #echo -n $DIRTY
        if [ "$NUM_AHEAD" -gt 0 ]; then
          echo -n $DIRTY$AHEAD$NUM_AHEAD" "
        fi
        if [ "$NUM_BEHIND" -gt 0 ]; then
          echo -n $DIRTY$BEHIN$NUM_BEHIND" "
        fi
      else
        git diff --cached --quiet >& /dev/null
        if [[ $? == 1 ]]; then
          echo -n $DIRTY
        else
          if [ "$NUM_AHEAD" -gt 0 ]; then
            echo -n $CLEAN$AHEAD$NUM_AHEAD
          else
            echo -n $CLEAN
          fi
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

# Adapted from code found at <https://gist.github.com/1712320>.
 
setopt prompt_subst
autoload -U colors && colors # Enable colors in prompt
 
# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_PREFIX="%{$fg[yellow]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[yellow]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[blue]%}+NUM%{$reset_color%} "
GIT_PROMPT_BEHIND="%{$fg[blue]%}-NUM%{$reset_color%} "
GIT_PROMPT_MERGING="%{$fg[yellow]%}"
GIT_PROMPT_UNTRACKED="%{$fg[red]%}"
GIT_PROMPT_MODIFIED="%{$fg[magenta]%}"
GIT_PROMPT_STAGED="%{$fg[green]%}"
GIT_PROMPT_CLEAN="%{$fg[white]%}"
 
# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
  (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}
 
# Show different symbols as appropriate for various Git repository states
parse_git_state() {
 
  # Compose this value via multiple conditional appends.
  local GIT_STATE=""
 
  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
  fi
 
  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
  fi
 
  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
  fi
 
  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
  fi
 
  if ! git diff --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
  fi
 
  if ! git diff --cached --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
  fi
 
  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_STATE"
  fi
}
 
# If inside a Git repository, print its branch and state
git_prompt_string() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "$GIT_PROMPT_PREFIX$(parse_git_state)${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX"
}
 
export PS2='$(git_prompt_string)'
#export PS2='$(__git_prompt)'

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
