# custom syntax highlighting
if [ -d /usr/local/share/zsh-syntax-highlighting ]; then
  ZSH_HIGHLIGHT_STYLES[path]='none'
  #ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
  #ZSH_HIGHLIGHT_STYLES[path_approx]='fg=yellow'
  ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
fi

# vim:ft=zsh
