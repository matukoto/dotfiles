{
  config,
  lib,
  pkgs,
  ...
}:

let
  #dotfilesDir = "${config.home.homeDirectory}/path/to/your/dotfiles";
  dotfilesDir = "${config.home.homeDirectory}/.local/share/chezmoi/config";
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

  mkOutOfStoreConfigDir =
    name:
    lib.nameValuePair name {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/${name}";
    };

  mkConfigDir =
    name:
    lib.nameValuePair name {
      source = ../../. + "/${name}";
      recursive = true;
    };
in
{
  xdg.configFile =
    builtins.listToAttrs (map mkOutOfStoreConfigDir commonConfigDirs)
    // lib.optionalAttrs pkgs.stdenv.isDarwin (builtins.listToAttrs (map mkConfigDir darwinConfigDirs))
    // {
      "typos.toml".source = ../../typos.toml;
    };

  home.file = {
    ".claude" = {
      source = ../../../home/claude;
      recursive = true;
    };
    ".copilot" = {
      source = ../../../home/copilot;
      recursive = true;
    };
    ".docker/cli-plugins" = {
      source = ../../../home/docker/cli-plugins;
      recursive = true;
    };
    ".local/bin" = {
      source = ../../../home/local/bin;
      recursive = true;
    };
  };
}
