# !/usr/bin/env zsh

# ~/.zshrc - zsh config file
# From: Fergus Bremner
# Email: <fergus.bremner@gmail.com>

# integrate vim goodness
bindkey -v 
fg-vim() {
  fg %vim
}
zle -N fg-vim
bindkey '^Z' fg-vim

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt histignorealldups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt inc_append_history
setopt share_history
unsetopt nomatch

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# automatically pushd
setopt autopushd pushdminus pushdsilent pushdtohome
setopt pushd_ignore_dups

# automatically enter directories without cd
setopt auto_cd

# handy cd movements from zshkit
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt cdablevars
setopt multios

# resolve symlinks 
setopt chase_links

# try to correct command line spelling
setopt CORRECT CORRECT_ALL

# enable extended globbing
setopt extended_glob

# don't match dotfiles. ever.
setopt noglobdots

# try to avoid the 'zsh: no matches found...'
setopt nonomatch

# use zsh style word splitting
setopt noshwordsplit

# report the status of backgrounds jobs immediately
setopt notify

#unsetopt menu_complete   # do not autoselect the first completion entry
#unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

# code versioning
autoload -Uz vcs_info

# easy renaming
autoload -U zmv

# command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# file rename magick
bindkey "^[m" copy-prev-shell-word

# jobs
setopt long_list_jobs

# load custom goodness
for GOODIES ($HOME/.zsh/plugins/*.zsh); do
  source $GOODIES
done

# extra completions
if [ -d $HOME/.zsh/extras/zsh-completions ]; then
  fpath=($HOME/.zsh/extras/zsh-completions/src $fpath)
fi

# fish shell like syntax highlighting
if [ -d $HOME/.zsh/extras/zsh-syntax-highlighting ]; then
  source $HOME/.zsh/extras/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# load & init completions last
autoload -Uz compinit && compinit

# vim:ft=zsh
