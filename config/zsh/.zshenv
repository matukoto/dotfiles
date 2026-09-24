# Read by interactive and non-interactive Zsh. No external commands here.
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export TZ=Asia/Tokyo
export BROWSER=open
export AQUA_GLOBAL_CONFIG=${AQUA_GLOBAL_CONFIG:-$XDG_CONFIG_HOME/aqua/aqua.yaml}
typeset -U path
if [[ -d ${AQUA_ROOT_DIR:-$XDG_DATA_HOME/aquaproj-aqua}/bin ]]; then
  path=("${AQUA_ROOT_DIR:-$XDG_DATA_HOME/aquaproj-aqua}/bin" "${path[@]}")
fi
[[ -d $HOME/bin ]] && path=("$HOME/bin" "${path[@]}")
[[ -d $HOME/.local/bin ]] && path=("$HOME/.local/bin" "${path[@]}")
if (( $+commands[nvim] )); then
  export EDITOR=nvim
else
  export EDITOR=vi
fi
export SYSTEMD_EDITOR=$EDITOR
