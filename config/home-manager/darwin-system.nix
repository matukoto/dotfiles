{ lib, username, ... }:

{
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "copilot-language-server"
      ];
  };

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  # 初回導入時に macOS 標準の shell init を退避し、nix-darwin の
  # /etc 管理チェックで止まらないようにする。
  system.activationScripts.preActivation.text = ''
    managedEtcShellFiles=(
      /etc/bashrc
      /etc/zprofile
      /etc/zshenv
      /etc/zshrc
    )

    for etcFile in "''${managedEtcShellFiles[@]}"; do
      etcStaticFile="/etc/static/''${etcFile#/etc/}"
      currentTarget="$(readlink -- "$etcFile" 2>/dev/null || true)"

      if [[ ! -e "$etcFile" || "$currentTarget" == "$etcStaticFile" ]]; then
        continue
      fi

      backupFile="''${etcFile}.before-nix-darwin"
      if [[ -e "$backupFile" ]]; then
        backupFile="''${backupFile}.$(date +%s)"
      fi

      printf >&2 'backing up unmanaged %s -> %s\n' "$etcFile" "$backupFile"
      mv "$etcFile" "$backupFile"
    done
  '';

  system.primaryUser = username;
  system.stateVersion = 6;
}
