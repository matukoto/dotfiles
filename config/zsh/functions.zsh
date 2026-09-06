# Optional helpers: no tool is installed or initialized automatically.
groot() {
  emulate -L zsh
  local root
  root=$(command git rev-parse --show-toplevel) || return $?
  builtin cd -- "$root"
}

ghf() {
  emulate -L zsh
  setopt pipefail
  if (( ! $+commands[ghq] || ! $+commands[fzf] )); then
    print -u2 'ghf: ghq と fzf が必要です。'
    return 127
  fi
  local destination
  destination=$(command ghq list -p | command fzf) || return $?
  [[ -n $destination ]] || return 0
  builtin cd -- "$destination"
}
yy() {
  emulate -L zsh
  if (( ! $+commands[yazi] )); then
    print -u2 'yy: yazi が必要です。'
    return 127
  fi
  local cwd_file destination
  local -i result=0
  cwd_file=$(command mktemp "${TMPDIR:-/tmp}/yazi-cwd.XXXXXX") || return $?
  {
    command yazi "$@" --cwd-file="$cwd_file"
    result=$?
    if (( result == 0 )); then
      destination=$(<"$cwd_file")
      if [[ -n $destination && $destination != $PWD ]]; then
        builtin cd -- "$destination" || result=$?
      fi
    fi
  } always {
    command rm -f -- "$cwd_file"
  }
  return $result
}
