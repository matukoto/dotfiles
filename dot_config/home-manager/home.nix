{
  config,
  lib,
  pkgs,
  username,
  ...
}:

{
  imports = [ ./modules/fish.nix ];

  # unfree だが許可する
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "copilot-language-server"
    ];

  home = {
    inherit username;
    stateVersion = "25.11"; # Please read the comment before changing.

    packages = with pkgs; [
      # cli tools
      curl
      git
      imagemagick
      gnupg
      neovim # nightly

      # LSP servers
      nixd
      bash-language-server
      copilot-language-server
      fish-lsp
      fsautocomplete
      jdt-language-server
      lemminx
      lombok
      lua-language-server
      svelte-language-server
      tailwindcss-language-server
      typos-lsp
      vtsls
      vscode-langservers-extracted # jsonls など
      sqls
      yaml-language-server

      # Package managers
      mise
      (callPackage ./pkgs/aqua.nix { })

      # Linters / Formatters / Tools
      nixfmt
      actionlint
      eslint_d
      fantomas
      fixjson
      markdownlint-cli2
      shellcheck
      shfmt
      sql-formatter
      stylua
      taplo
      typos
      yamlfmt
    ];
  };

  programs.home-manager.enable = true;
}
