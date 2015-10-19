#!/usr/bin/env zsh

# fish shell like syntax highlighting
if [[ -d $HOME/.zsh/extras/zsh-syntax-highlighting ]]; then
  export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$HOME/.zsh/extras/zsh-syntax-highlighting/highlighters
fi
