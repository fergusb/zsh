#!/usr/bin/env zsh

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# fuzzy matching
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# menu
if [[ "$NOMENU" -eq 0 ]] ; then
  # if there are more than 4 options allow selecting from a menu
  zstyle ':completion:*' menu select=4
else
  # don't use any menus at all
  setopt no_auto_menu
fi

# formatting and messages
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*' auto-description 'Specify: %d'
zstyle ':completion:*' file-sort name
zstyle ':completion:*' group-name ''
#zstyle ':completion:*' format 'Completing %d'
zstyle ":completion:*:descriptions" format "%B%d%b"
zstyle ':completion:*:messages' format '%d'
# zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

zstyle ':completion:*' list-colors ''
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

# keep trailing slash (broken)
zstyle ':completion:*' accept-exact-dirs squeeze-slashes true

# complete from history
zstyle ':completion:history-words:*' list no 
zstyle ':completion:history-words:*' menu yes
zstyle ':completion:history-words:*' remove-all-dups yes

# do not select current dir
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# process IDs (kill 'em)
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# don't want known_hosts.  Just use the /.ssh/config
#zstyle ':completion:*:hosts' hosts
zstyle ':completion:*:(ssh|scp):*' hosts
zstyle ':completion:*:(ssh|scp):*' tag-order '! users'

# other programs
zstyle ':completion:*:*:mutt:*' menu yes select
zstyle ':completion:*:*:vi:*' menu yes select
zstyle ':completion:*:*:(g|m|)vim:*' menu yes select

# ignore completion functions (until the _ignored completer)
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'
# zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle '*' single-ignored show

# git integration
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*:*' get-revision true
zstyle ':vcs_info:git*:*' check-for-changes true

# hash changes branch misc
#zstyle ':vcs_info:git*' formats "(%s) %12.12i %c%u %b%m"
#zstyle ':vcs_info:git*' actionformats "(%s|%a) %12.12i %c%u %b%m"
#zstyle ':vcs_info:git*+set-message:*' hooks git-st git-stash

# complete manual by their section
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

# search path for sudo completion
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
                                           /usr/local/bin \
                                           /usr/sbin \
                                           /usr/bin \
                                           /sbin \
                                           /bin 

# linux specific
if [[ uname == 'Linux' ]]; then
  zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
fi

# vim:ft=zsh
