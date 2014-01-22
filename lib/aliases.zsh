#!/usr/bin/env zsh

# Navigation
alias .='pwd'
alias ..='cd ..'

#alias d='dirs -v | head -10'
alias dh='dirs -v'

# list options
alias la='ls -a'                # show hidden
alias lsa='ls -ld .*'           # show only hidden
alias lx='ls -lXB'              # sort by ext
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'              # sort by mod date
alias lu='ls -lur'              # sort by last viewed
alias lt='ls -ltr'              # sort by date
alias lm='ls -al |more'         # ls with more (scrollbar)
alias lr='ls -lR |more'         # recursive ls with more (scrollbar)
alias lg='ls | grep '           # ls in current dir with grep

# corrections
alias aws='nocorrect aws'
alias cp='nocorrect cp'
alias git='nocorrect git'
alias mail='nocorrect mail'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mutt='nocorrect mutt'
alias mv='nocorrect mv'
alias mux='nocorrect mux'
alias mysql='nocorrect mysql'
alias offlineimap='nocorrect offlineimap'
alias pip='nocorrect pip'
alias ssh='nocorrect ssh'
alias vi='nocorrect vim'
alias vim='nocorrect vim'
alias sudo='nocorrect sudo'
alias tmux='nocorrect tmux'

# Admin
alias cdwd='cd `pwd`'
alias chx='chmod +x'
alias cwd='echo $cwd'
alias df='df -kh'
alias du='du -h'
alias h='history'
alias ifconfig='/sbin/ifconfig'
#alias killall='sudo killall'
alias path='echo -e ${PATH//:/\\n}'
alias rl='rlogin'
# alias server_name='ssh -v -l USERNAME IP ADDRESS'
alias which='type -all'

# tmux
alias tma='tmux attach -d -t'
alias git-tmux='tmux new -s $(basename $(pwd))'

# System
alias reboot='sudo /sbin/shutdown -r now'
alias shutdown='sudo /sbin/shutdown -h now'
alias suspend='sudo pm-suspend'
#alias sleep='sudo pm-suspend'

# Applications and utilities
alias apache2ctl='sudo /usr/sbin/apache2ctl'
#alias eclipse-php='/usr/local/bin/eclipse-php/eclipse'
#alias eclipse='/usr/local/bin/eclipse/eclipse'
#alias gvim='gvim -p --remote-tab-silent'
alias gvim='UBUNTU_MENUPROXY= gvim'
alias escputil='sudo escputil'
alias inklevel='escputil -iqur /dev/usb/lp0'
alias python='python3'
alias randline="/usr/bin/rl"
alias tidy='tidy -config $HOME/.tidy.conf'
alias updatedb='sudo updatedb'
alias vi='vim'
if [[ uname == 'Linux' ]]; then
  alias open='xdg-open'
fi
if [[ uname == 'Darwin' ]]; then
  # nuke duplicates in the Open With submenu.
  alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'
fi

alias shred='shred -fvzu'

# SUFFIXES
alias -s css=$EDITOR
alias -s html=$BROWSER
alias -s java=$EDITOR
alias -s jsp=$EDITOR
alias -s php=$EDITOR
alias -s txt=$EDITOR

# vim:ft=zsh
