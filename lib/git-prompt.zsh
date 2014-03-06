#!/usr/bin/env zsh

# git prompt
# adapted from code found at <https://gist.github.com/joshdick/4415470>.
 
GIT_PROMPT_PREFIX="%{$reset_color%}["
GIT_PROMPT_SUFFIX="%{$reset_color%}]"
GIT_PROMPT_AHEAD="%{$fg[blue]%}+NUM%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[blue]%}-NUM%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg[red]%}●%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg[yellow]%}●%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg[green]%}●%{$reset_color%}"

#GIT_PROMPT_PREFIX="%{$reset_color%}["
#GIT_PROMPT_SUFFIX="%{$reset_color%}]"
#GIT_PROMPT_AHEAD="%{$fg[blue]%}+NUM%{$reset_color%} "
#GIT_PROMPT_BEHIND="%{$fg[blue]%}-NUM%{$reset_color%} "
#GIT_PROMPT_MERGING="%{$fg[blue]%}"
#GIT_PROMPT_UNTRACKED="%{$fg[red]%}"
#GIT_PROMPT_MODIFIED="%{$fg[magenta]%}"
#GIT_PROMPT_STAGED="%{$fg[green]%}"
 
# show git branch/tag, or name-rev if on detached head
parse_git_branch() {
  (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}
 
# show different colours depending upon git repository states
parse_git_state() {
 
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
    #echo "$GIT_STATE"
    echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
  fi
}

# show count of stashed changes
parse_git_stash() {
  local -a stashes

  if [[ -s $(git rev-parse --show-toplevel)/.git/refs/stash ]]; then
    stashes=$(git stash list 2> /dev/null | wc -l | tr -d ' ')
    echo " (${stashes} stashed)"
  fi
}
 
# if in a git repository, print its branch, state and stash count (if any)
git_prompt_string() {
  local git_where="$(parse_git_branch)"
  #[ -n "$git_where" ] && echo "$GIT_PROMPT_PREFIX$(parse_git_state)${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX$(parse_git_stash)"
  #[ -n "$git_where" ] && echo "$GIT_PROMPT_PREFIX%{$fg[yellow]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX$(parse_git_state)$(parse_git_stash)"
  [ -n "$git_where" ] && echo "$GIT_PROMPT_PREFIX%{$fg[yellow]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX$(parse_git_state)$(parse_git_stash)"
}
 
export PS2='$(git_prompt_string)'

