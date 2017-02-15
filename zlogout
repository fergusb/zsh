#!/usr/bin/env zsh

# clear keychain
# [[ -f $(which keychain 2> /dev/null)  ]] && \
  # keychain -q --clear

#  cleanly deactivate Python virtualenvs
[ "$VIRTUAL_ENV" ] && deactivate

# clear screen on exit
if [ "$SHLVL" = 1 ]; then
  [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
