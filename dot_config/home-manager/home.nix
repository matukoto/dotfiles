{
  config,
  lib,
  pkgs,
  ...
}:

{
  # unfree だが許可する
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "copilot-language-server"
    ];

  home = {
    username = "matukoto";
    homeDirectory = "/Users/matukoto";

    stateVersion = "25.11"; # Please read the comment before changing.
    packages = with pkgs; [
      nixfmt
      nixd
      neovim

      # LSP servers
      actionlint
      bash-language-server
      copilot-language-server
      # csharp-ls MacOS ではインストールできない
      fish-lsp
      fsautocomplete
      fantomas
      jdt-language-server
      lemminx
      lombok
      lua-language-server
      svelte-language-server
      tailwindcss-language-server
      typos-lsp
      vim-language-server
      vtsls
      vscode-langservers-extracted # jsonls など
      yaml-language-server

      # Linters / Formatters / Tools
      eslint_d
      fixjson
      markdownlint-cli2
      shellcheck
      shfmt
      sql-formatter
      sqls
      stylua
      taplo
      typos
      yamlfmt
    ];

    file = {
    };

  };

  programs.home-manager.enable = true;
}
