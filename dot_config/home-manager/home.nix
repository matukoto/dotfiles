{
  config,
  pkgs,
  username,
  ...
}:

{
  imports = [
    ./modules/bash.nix
    ./modules/files.nix
    ./modules/fish.nix
    ./modules/git.nix
    ./modules/gnupg.nix
    ./modules/nushell.nix
  ];

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

  };

  home = {
    inherit username;
    stateVersion = "25.11"; # Please read the comment before changing.

    packages = with pkgs; [
      # cli tools
      curlMinimal
      delta
      imagemagick
      gh
      gnupg
      nix-search-tv

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

      # fonts
      plemoljp-nf
      hackgen-nf-font

      # agents
      gemini-cli
      geminicommit
    ];
  };

  programs.nix-search-tv.enableTelevisionIntegration = true;
  programs.home-manager.enable = true;
}
