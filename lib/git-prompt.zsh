#!/usr/bin/env zsh

# change this to reflect your installation directory
export __GIT_PROMPT_DIR=~/.zsh/scripts

# initialize colors.
autoload -U colors && colors

# allow for functions in the prompt.
setopt PROMPT_SUBST

autoload -U add-zsh-hook

add-zsh-hook chpwd chpwd_update_git_vars
add-zsh-hook preexec preexec_update_git_vars
add-zsh-hook precmd precmd_update_git_vars

## Function definitions
function preexec_update_git_vars() {
    case "$2" in
        git*|hub*|gh*|stg*)
        __EXECUTED_GIT_COMMAND=1
        ;;
    esac
}

function precmd_update_git_vars() {
    ZSH_THEME_GIT_PROMPT_NOCACHE=1
    if [ -n "$__EXECUTED_GIT_COMMAND" ] || [ -n "$ZSH_THEME_GIT_PROMPT_NOCACHE" ]; then
        update_current_git_vars
        unset __EXECUTED_GIT_COMMAND
    fi
}

function chpwd_update_git_vars() {
    update_current_git_vars
}

# show count of stashed changes
function parse_git_stash() {
  local -a stashes

  if [[ -s $(git rev-parse --show-toplevel)/.git/refs/stash ]]; then
    stashes=$(git stash list 2> /dev/null | wc -l | tr -d ' ')
    echo "[${stashes} stashed]"
  fi
}
 
function update_current_git_vars() {
    unset __CURRENT_GIT_STATUS

    local gitstatus="$__GIT_PROMPT_DIR/gitstatus.py"
    _GIT_STATUS=`python ${gitstatus}`
    __CURRENT_GIT_STATUS=("${(@f)_GIT_STATUS}")
	GIT_BRANCH=$__CURRENT_GIT_STATUS[1]
	GIT_REMOTE=$__CURRENT_GIT_STATUS[2]
	GIT_STAGED=$__CURRENT_GIT_STATUS[3]
	GIT_CONFLICTS=$__CURRENT_GIT_STATUS[4]
	GIT_CHANGED=$__CURRENT_GIT_STATUS[5]
	GIT_UNTRACKED=$__CURRENT_GIT_STATUS[6]
	GIT_CLEAN=$__CURRENT_GIT_STATUS[7]
}

git_super_status() {
	precmd_update_git_vars
    BRANCH_STATUS="$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_BRANCH$GIT_BRANCH%{${reset_color}%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
    if [ -n "$__CURRENT_GIT_STATUS" ]; then
    #BRANCH_STATUS="$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_BRANCH$GIT_BRANCH%{${reset_color}%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
	  STATUS="$BRANCH_STATUS"
	  if [ -n "$GIT_REMOTE" ]; then
		  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_REMOTE$GIT_REMOTE%{${reset_color}%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
	  fi
	  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_PREFIX"
	  if [ "$GIT_STAGED" -ne "0" ]; then
		  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED$GIT_STAGED%{${reset_color}%}"
	  fi
	  if [ "$GIT_CONFLICTS" -ne "0" ]; then
		  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CONFLICTS$GIT_CONFLICTS%{${reset_color}%}"
	  fi
	  if [ "$GIT_CHANGED" -ne "0" ]; then
		  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CHANGED$GIT_CHANGED%{${reset_color}%}"
	  fi
	  if [ "$GIT_UNTRACKED" -ne "0" ]; then
		  STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED%{${reset_color}%}"
	  fi
	  STATUS="$STATUS%{${reset_color}%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
	  if [ "$GIT_CLEAN" -eq "1" ]; then
      STATUS="$BRANCH_STATUS"
	  fi
    echo "$STATUS$(parse_git_stash)"
	fi
}

# default values for the appearance of the prompt
ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}+"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}×"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[magenta]%}+"
ZSH_THEME_GIT_PROMPT_REMOTE="%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="…"
