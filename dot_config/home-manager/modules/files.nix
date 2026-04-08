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
    "efm-langserver"
    "ghostty"
    "gitui"
    "jdtls"
    "mini"
    "mise"
    "nix"
    "nvim"
    "opencode"
    "private_jj"
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
  mkConfigDir = name: lib.nameValuePair name {
    source = ../../. + "/${name}";
    recursive = true;
  };
in
{
  xdg.configFile =
    builtins.listToAttrs (map mkConfigDir commonConfigDirs)
    // lib.optionalAttrs pkgs.stdenv.isDarwin (builtins.listToAttrs (map mkConfigDir darwinConfigDirs))
    // {
      "starship.toml".source = ../../starship.toml;
      "typos.toml".source = ../../typos.toml;
    };

  home.file =
    {
      ".claude" = {
        source = ../../../dot_claude;
        recursive = true;
      };
      ".copilot" = {
        source = ../../../dot_copilot;
        recursive = true;
      };
      ".docker/cli-plugins" = {
        source = ../../../dot_docker/cli-plugins;
        recursive = true;
      };
      ".local/bin" = {
        source = ../../../dot_local/bin;
        recursive = true;
      };
      "minimal_init.lua".source = ../../../minimal_init.lua;
    }
    // lib.optionalAttrs (!pkgs.stdenv.isDarwin) {
      ".sleep".source = ../../../dot_sleep;
      ".wakeup".source = ../../../dot_wakeup;
    };
}
