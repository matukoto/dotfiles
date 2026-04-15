{
  lib,
  pkgs,
  ...
}:

let
  commonConfigDirs = [
    "aqua"
    "atuin"
    "claude"
    "ghostty"
    "gitui"
    "jdtls"
    "mise"
    "nix"
    "nvim"
    "opencode"
    "sqls"
    "stylua"
    "vim"
    "wezterm"
    "yamlfmt"
    "yazi"
    "zoxide"
  ];
  darwinConfigDirs = [
    "aerospace"
    "borders"
    "sketchybar"
  ];
  mkConfigDir =
    name:
    lib.nameValuePair name {
      source = ../../. + "/${name}";
      recursive = true;
    };
in
{
  xdg.configFile =
    builtins.listToAttrs (map mkConfigDir commonConfigDirs)
    // lib.optionalAttrs pkgs.stdenv.isDarwin (builtins.listToAttrs (map mkConfigDir darwinConfigDirs))
    // {
      "typos.toml".source = ../../typos.toml;
    };

  home.file = {
    ".claude" = {
      source = ../../../claude;
      recursive = true;
    };
    ".copilot" = {
      source = ../../../copilot;
      recursive = true;
    };
    ".docker/cli-plugins" = {
      source = ../../../docker/cli-plugins;
      recursive = true;
    };
    ".local/bin" = {
      source = ../../../local/bin;
      recursive = true;
    };
  };
}
