{
  hostname,
  pkgs,
  ...
}:

let
  configTemplate = builtins.readFile ../../nushell/config.nu.tmpl;
  flakeTarget = if pkgs.stdenv.isDarwin then "darwin" else hostname;
  privatePluginEnabledLine =
    if
      builtins.elem hostname [
        "DesktopFractal"
        "ThinkPadE14"
      ]
    then
      "$env.PRIVATE_PLUGIN_ENABLED = \"true\""
    else
      "";
  browserLine =
    if pkgs.stdenv.isDarwin then "$env.BROWSER = \"open\"" else "$env.BROWSER = \"wslview\"";
  switchCommand =
    if pkgs.stdenv.isDarwin then
      ''
        def ca [] {
          ^sudo -H nix --extra-experimental-features "nix-command flakes" run $"($env.HOME)/.local/share/chezmoi/dot_config/home-manager#darwin-rebuild" -- switch --flake $"($env.HOME)/.local/share/chezmoi/dot_config/home-manager#${flakeTarget}"
        } # 現在のホスト向け設定を適用
      ''
    else
      ''
        def ca [] {
          ^nix --extra-experimental-features "nix-command flakes" run $"($env.HOME)/.local/share/chezmoi/dot_config/home-manager#home-manager" -- switch --flake $"($env.HOME)/.local/share/chezmoi/dot_config/home-manager#${flakeTarget}"
        } # 現在のホスト向け設定を適用
      '';
  configNu =
    builtins.replaceStrings
      [
        "{{ if (or (eq .chezmoi.hostname \"DesktopFractal\") (eq .chezmoi.hostname \"ThinkPadE14\")) }}"
        "$env.PRIVATE_PLUGIN_ENABLED = \"true\""
        "{{ end }}"
        "$env.BROWSER = \"wslview\""
        "# __NIX_APPLY_COMMAND__"
      ]
      [
        ""
        privatePluginEnabledLine
        ""
        browserLine
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
