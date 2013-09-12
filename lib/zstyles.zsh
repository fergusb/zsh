#!/usr/bin/env zsh

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# fuzzy matching
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# formatting and messages
zstyle ':completion:*' verbose true
zstyle ":completion:*:descriptions" format "%B%d%b"
zstyle ':completion:*' auto-description 'specify: %d'
#zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

zstyle ':completion:*' menu select=long
zstyle ':completion:*' use-compctl false

# process IDs
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# keep trailing slash (broken)
zstyle ':completion:*' squeeze-slashes false

# do not select parent dir
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# don't want known_hosts.  Just use the /.ssh/config
zstyle ':completion:*:hosts' hosts

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle '*' single-ignored show

if [[ uname == 'Linux' ]]; then
  zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
fi

# vim:ft=zsh
