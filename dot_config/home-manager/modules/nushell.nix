{
  hostname,
  pkgs,
  ...
}:

let
  configTemplate = builtins.readFile ../../nushell/config.nu.tmpl;
  privatePluginEnabledLine =
    if builtins.elem hostname [
      "DesktopFractal"
      "ThinkPadE14"
    ] then
      "$env.PRIVATE_PLUGIN_ENABLED = \"true\""
    else
      "";
  browserLine = if pkgs.stdenv.isDarwin then "$env.BROWSER = \"open\"" else "$env.BROWSER = \"wslview\"";
  switchCommand =
    if pkgs.stdenv.isDarwin then
      ''
      def ca [] {
        ^sudo darwin-rebuild switch --flake $"($env.HOME)/.local/share/chezmoi/dot_config/home-manager#${hostname}"
      } # 現在のホスト向け設定を適用
      ''
    else
      ''
      def ca [] {
        ^home-manager switch --flake $"($env.HOME)/.local/share/chezmoi/dot_config/home-manager#${hostname}"
      } # 現在のホスト向け設定を適用
      '';
  configNu = builtins.replaceStrings
    [
      "{{ if (or (eq .chezmoi.hostname \"DesktopFractal\") (eq .chezmoi.hostname \"ThinkPadE14\")) }}"
      "$env.PRIVATE_PLUGIN_ENABLED = \"true\""
      "{{ end }}"
      "$env.BROWSER = \"wslview\""
      "alias dot = chezmoi cd # chezmoi のディレクトリに移動"
      "alias cu = chezmoi update"
      "alias ca = chezmoi apply # chezmoi の変更を適用"
    ]
    [
      ""
      privatePluginEnabledLine
      ""
      browserLine
      "alias dot = cd ($env.HOME | path join \".local/share/chezmoi\") # dotfiles リポジトリに移動"
      "def cu [] { ^git -C ($env.HOME | path join \".local/share/chezmoi\") pull --rebase }"
      switchCommand
    ]
    configTemplate;
in
{
  xdg.configFile = {
    "nushell/config.nu".text = configNu;
    "nushell/env.nu".source = ../../nushell/env.nu;
  };
}
