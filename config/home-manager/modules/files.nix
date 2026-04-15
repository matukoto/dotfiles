{
  config,
  lib,
  pkgs,
  ...
}:

let
  dotfilesDir = "${config.home.homeDirectory}/.local/share/chezmoi/config";
  homeDir = "${config.home.homeDirectory}/.local/share/chezmoi/home";
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
    ".claude".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/claude";
    ".copilot".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/copilot";
    ".docker/cli-plugins".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/docker/cli-plugins";
    ".local/bin".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/local/bin";
  };
}
