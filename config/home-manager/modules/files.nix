{
  config,
  lib,
  pkgs,
  ...
}:

let
  dotfilesDir = "${config.home.homeDirectory}/work/github.com/matukoto/dotfiles/config";
  homeDir = "${config.home.homeDirectory}/work/github.com/matukoto/dotfiles/home";
  localBinPath = ../../../home/local/bin;
  localBinFiles = builtins.attrNames (
    lib.filterAttrs (name: type: type == "regular") (builtins.readDir localBinPath)
  );
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
  localBinLinks = builtins.listToAttrs (
    map (
      fileName:
      lib.nameValuePair ".local/bin/${fileName}" {
        source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/local/bin/${fileName}";
      }
    ) localBinFiles
  );
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
    ".copilot/config.json".source =
      config.lib.file.mkOutOfStoreSymlink "${homeDir}/copilot/config.json";
    ".copilot/lsp-config.json".source =
      config.lib.file.mkOutOfStoreSymlink "${homeDir}/copilot/lsp-config.json";
    ".copilot/mcp-config.json".source =
      config.lib.file.mkOutOfStoreSymlink "${homeDir}/copilot/mcp-config.json";
    ".docker/cli-plugins".source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/docker/cli-plugins";
  }
  // localBinLinks;
}
