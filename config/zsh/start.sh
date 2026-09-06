#!/bin/sh
# Launch a child Zsh without replacing Fish or editing home startup files.
zsh_config_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P) || exit 1
if [ "${1-}" = --clean-path ]; then
  shift
  PATH=/usr/bin:/bin:/usr/sbin:/sbin
  export PATH
fi
# -d skips later system startup files; /etc/zshenv is still read by Zsh itself.
exec /usr/bin/env ZDOTDIR="$zsh_config_dir" /bin/zsh -d "$@"
