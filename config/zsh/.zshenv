# Read by interactive and non-interactive Zsh. No external commands here.
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export TZ=Asia/Tokyo
export BROWSER=open
typeset -U path
[[ -d $HOME/bin ]] && path=("$HOME/bin" "${path[@]}")
[[ -d $HOME/.local/bin ]] && path=("$HOME/.local/bin" "${path[@]}")
if (( $+commands[nvim] )); then
  export EDITOR=nvim
else
  export EDITOR=vi
fi
export SYSTEMD_EDITOR=$EDITOR
