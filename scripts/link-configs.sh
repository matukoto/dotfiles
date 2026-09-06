#!/bin/bash
# macOS 標準の /bin/bash（3.2 以降）で動作。sudo やパッケージマネージャーは不要。
set -euo pipefail

repo_dir=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)
config_home=${XDG_CONFIG_HOME:-${HOME:?HOME is required}/.config}
dry_run=false
config_only=false
selected=()
sources=()
destinations=()

usage() {
  printf '%s\n' \
    'Usage: bash scripts/link-configs.sh [options] [config ...]' \
    '' \
    'Default: nvim zsh' \
    'Configs: nvim zsh ghostty wezterm yazi gitui jdtls sqls stylua yamlfmt typos' \
    '' \
    '  --dry-run      Print planned links without writing anything' \
    '  --config-only  Do not link ~/.zshenv or ~/.zshrc' \
    '  --list         List supported configurations' \
    '  -h, --help     Show this help' \
    '' \
    'Existing configurations are not backed up or overwritten; conflicts stop the script.' \
    'Fish, login shell, packages and personal data are not changed.'
}

for arg in "$@"; do
  case "$arg" in
    --dry-run) dry_run=true ;;
    --config-only) config_only=true ;;
    --list)
      printf '%s\n' nvim zsh ghostty wezterm yazi gitui jdtls sqls stylua yamlfmt typos
      exit 0 ;;
    -h|--help) usage; exit 0 ;;
    nvim|zsh|ghostty|wezterm|yazi|gitui|jdtls|sqls|stylua|yamlfmt|typos)
      selected+=("$arg") ;;
    *) printf 'Unknown configuration or option: %s\n' "$arg" >&2; usage >&2; exit 2 ;;
  esac
done
if [ ${#selected[@]} -eq 0 ]; then
  selected=(nvim zsh)
fi

case "$config_home" in
  /*) ;;
  *) printf 'XDG_CONFIG_HOME must be an absolute path: %s\n' "$config_home" >&2; exit 2 ;;
esac

add_link() {
  sources+=("$1")
  destinations+=("$2")
}

for name in "${selected[@]}"; do
  if [ "$name" = typos ]; then
    add_link "$repo_dir/config/typos.toml" "$config_home/typos.toml"
  else
    add_link "$repo_dir/config/$name" "$config_home/$name"
  fi
  if [ "$name" = zsh ] && ! "$config_only"; then
    add_link "$repo_dir/config/zsh/.zshenv" "${HOME:?HOME is required}/.zshenv"
    add_link "$repo_dir/config/zsh/.zshrc" "$HOME/.zshrc"
  fi
done

# 配備先を変更する前に、すべてのリンク元が存在することを確認する。
for source_path in "${sources[@]}"; do
  if [ ! -e "$source_path" ]; then
    printf 'Source does not exist: %s\n' "$source_path" >&2
    exit 1
  fi
done

# 別の設定がある場合は、リンク作成を始める前に停止する。
for ((index=0; index<${#sources[@]}; index++)); do
  destination=${destinations[index]}
  if [ "${sources[index]}" -ef "$destination" ]; then
    continue
  fi
  if [ -e "$destination" ] || [ -L "$destination" ]; then
    printf 'Destination already exists: %s\n' "$destination" >&2
    exit 1
  fi
done

link_config() {
  local source_path=$1 destination=$2
  if [ "$source_path" -ef "$destination" ]; then
    printf 'SKIP  %s (already points to source)\n' "$destination"
    return
  fi
  if [ -e "$destination" ] || [ -L "$destination" ]; then
    printf 'Destination already exists: %s\n' "$destination" >&2
    return 1
  fi
  printf 'LINK  %s -> %s\n' "$destination" "$source_path"
  if "$dry_run"; then
    return
  fi
  mkdir -p -- "$(dirname -- "$destination")"
  # macOS では -h を指定し、既存のディレクトリへの symlink をたどらないようにする。
  if ! ln -sh -- "$source_path" "$destination"; then
    printf 'Failed to link: %s\n' "$destination" >&2
    return 1
  fi
}

for ((index=0; index<${#sources[@]}; index++)); do
  link_config "${sources[index]}" "${destinations[index]}"
done

if "$dry_run"; then
  printf 'Preview only; no files changed.\n'
else
  printf 'Done. Keep this repository at its current path.\n'
fi
