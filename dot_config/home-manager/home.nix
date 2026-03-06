{
  config,
  lib,
  pkgs,
  username,
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
    inherit username;
    stateVersion = "25.11"; # Please read the comment before changing.

    packages = with pkgs; [
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

  xdg.configFile = {
    "fish/conf.d".source = ../fish/conf.d;
    "fish/functions".source = ../fish/functions;
  };

  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
    ];

    shellAbbrs = {
      f = "ghf";
      ai = "aqua i -a";
      ag = "aqua g";
      mi = "mise i";
      skkadd = "update_skk_dict";
      skkpull = "pull_skk_dict";
      skk = "cd ~/.skk";
      fsi = "dotnet fsi";
      s = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gpu = "git push --upstream-origin origin HEAD";
      gpl = "git pull";
      gl = "git log";
      gs = "git switch";
      gd = "git diff";
      gsc = "git switch -c";
      gcp = "git cherry-pick";
      groot = "cd (git rev-parse --show-toplevel)";
      gas = "gh auth switch";
      ll = "eza -alF --time-style \"+%Y/%m/%d %H:%M\"";
      la = "eza -A";
      l = "clear && eza";
      ls = "eza";
      lc = "leetcode";
      v = "nvim";
      va = "nvim ~/work/workLog/a.md";
      "v." = "nvim .";
      vr = "nvim ./README.md";
      dot = "chezmoi cd";
      cu = "pull_skk_dict | chezmoi update";
      ca = "chezmoi apply";
      conf = "cd $HOME/.config";
      ob = "cd $HOME/obsidian/";
      "browser-html" = "deno run -A --unstable npm:browser-sync  start --server --files \"*.html\"";
      startuptime = "vim-startuptime -count 100 -vimpath nvim";
      a = "aqua";
    };

    shellInit = ''
      # XDG Base Directory
      set -x XDG_CONFIG_HOME $HOME/.config
      set -x XDG_CACHE_HOME $HOME/.cache
      set -x XDG_DATA_HOME $HOME/.local/share
      set -x XDG_STATE_HOME $HOME/.local/state
      set -x INITVIM $XDG_CONFIG_HOME/nvim/init.vim
      set -x VIMRC $HOME/.vimrc
      set -x AQUA_GLOBAL_CONFIG $XDG_CONFIG_HOME/aqua/aqua.yaml

      set -l hostname (hostname)
      if test (uname) = "Darwin"; or test "$hostname" = "DesktopFractal"; or test "$hostname" = "ThinkPadE14"
          set -x PRIVATE_PLUGIN_ENABLED true
      end

      # Fish paths
      set -x FISH_CONFIG_DIR $XDG_CONFIG_HOME/fish
      set -x FISH_FUNCTIONS_DIR $FISH_CONFIG_DIR/functions
      set -x FISH_CACHE_DIR $XDG_CACHE_HOME/fish

      set -x BROWSER wslview
      set -x EDITOR nvim
      set -x SYSTEMD_EDITOR "$EDITOR"
      set -x TZ Asia/Tokyo

      # GPG_TTY: TTY がある場合のみ設定
      if tty > /dev/null 2>&1
          set -x GPG_TTY (tty)
      end
    '';

    interactiveShellInit = ''
      # vi キーバインドは conf.d/_key_bindings.fish で設定
      fish_add_path "$HOME/bin"
      fish_add_path "$HOME/.local/bin"
      fish_add_path "$HOME/go/bin"
      fish_add_path "$HOME/.cargo/bin"
      fish_add_path "$HOME/.rustup/toolchains/*/bin"
      fish_add_path "$HOME/.deno/bin"
      fish_add_path "$HOME/.local/share/nvim/mason/bin"
      fish_add_path "$HOME/.local/share/aquaproj-aqua/bin"

      if test (uname) = "Darwin"
          eval (/opt/homebrew/bin/brew shellenv)
      else if test (uname) = "Linux"
          eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
      end

      # config caches
      set -l CONFIG_CACHE $FISH_CACHE_DIR/config.fish
      # キャッシュ更新が必要かどうかを判定するフラグ
      set -l need_update 0

      # キャッシュファイルが存在しない、または config.fish が新しい場合
      if not test -f "$CONFIG_CACHE"
          set need_update 1
      else if test "$FISH_CONFIG_DIR/config.fish" -nt "$CONFIG_CACHE"
          echo "config cache need update"
          set need_update 1
      end

      # aqua.yaml が CONFIG_CACHE より新しければツールが更新された可能性があるため再生成
      if test $need_update -eq 0
          if test -f "$AQUA_GLOBAL_CONFIG"; and test "$AQUA_GLOBAL_CONFIG" -nt "$CONFIG_CACHE"
              echo "aqua config updated, updating config cache"
              set need_update 1
          end
      end

      if test $need_update -eq 1
          mkdir -p $FISH_CACHE_DIR
          echo "" >$CONFIG_CACHE

          # tools
          type -q zoxide && zoxide init fish >>$CONFIG_CACHE
          # mise の起動時 hook-env（~17ms）をスキップし、fish_prompt イベント経由のみにする
          # set -gx PATH は aqua バージョン更新時に古いパスが蓄積するため除去する（hook-env が動的に管理するため不要）
          type -q mise && mise activate fish | string replace --regex '^__mise_env_eval$' "" | string replace --regex '^set -gx PATH .*' "" >>$CONFIG_CACHE
          # atuin uuid は起動が遅い（~34ms）ため uuidgen で代替する
          type -q atuin && atuin init --disable-up-arrow fish | string replace --all "atuin uuid" uuidgen >>$CONFIG_CACHE

          echo "config cache updated"
      end
      source $CONFIG_CACHE
    '';
  };

  programs.home-manager.enable = true;
}
