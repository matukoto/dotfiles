{
  lib,
  username,
  pkgs,
  ...
}:

{
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "copilot-language-server"
      ];
  };

  programs.fish.enable = true;

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
    shell = pkgs.fish;
  };

  # 初回導入時に macOS 標準の shell init を退避し、nix-darwin の
  # /etc 管理チェックで止まらないようにする。
  system = {
    defaults = {
      NSGlobalDomain = {
        # マウス/トラックパッド
        "com.apple.swipescrolldirection" = true; # ナチュラルスクロールを有効化
        # UI
        NSWindowResizeTime = 0.001; # ウィンドウのリサイズ速度を高速化
      };
      # Finder
      finder = {
        AppleShowAllExtensions = true; # ファイル拡張子を常に表示
        AppleShowAllFiles = true; # 隠しファイルを表示
        FXDefaultSearchScope = "SCcf"; # 検索範囲をカレントフォルダに設定
        ShowPathbar = true; # パスバーを表示
        FXEnableExtensionChangeWarning = false; # ファイル拡張子変更の警告を無効化
        FXPreferredViewStyle = "Nlsv"; # デフォルトの表示方法をリストビューに設定
      };
      # Dock
      dock = {
        show-process-indicators = true; # 起動中アプリをインジケーターに表示
        show-recents = false; # 最近使ったアプリを非表示
        launchanim = false; # アプリ起動時のアニメーションを無効化
        mineffect = "scale"; # ウィンドウを閉じるときのエフェクトをスケールに設定
      };
      # 画面キャプチャ
      screencapture = {
        target = "clipboard"; # スクリーンショットの保存先をクリップボードに設定
        disable-shadow = true; # スクリーンショットの影を無効化
      };
      # その他
      CustomUserPreferences = {
        NSGlobalDomain = {
          # Finder
          AppleMenuBarVisibleInFullscreen = true; # フルスクリーン時にメニューバーを表示
        };
      };
    };

    activationScripts.preActivation.text = ''
      managedEtcShellFiles=(
        /etc/bashrc
        /etc/zprofile
        /etc/zshenv
        /etc/zshrc
      )

      for etcFile in "''${managedEtcShellFiles[@]}"; do
        etcStaticFile="/etc/static/''${etcFile#/etc/}"
        currentTarget="$(readlink -- "$etcFile" 2>/dev/null || true)"

        if [[ ! -e "$etcFile" || "$currentTarget" == "$etcStaticFile" ]]; then
          continue
        fi

        backupFile="''${etcFile}.before-nix-darwin"
        if [[ -e "$backupFile" ]]; then
          backupFile="''${backupFile}.$(date +%s)"
        fi

        printf >&2 'backing up unmanaged %s -> %s\n' "$etcFile" "$backupFile"
        mv "$etcFile" "$backupFile"
      done
    '';

    primaryUser = username;
    stateVersion = 6;
  };

  # 電源設定
  power = {
    sleep = {
      allowSleepByPowerButton = false; # 電源ボタンでスリープを無効化
      computer = 10; # 自動スリープまでの時間（分）
      display = 5; # ディスプレイの自動スリープまでの時間（分）
    };
  };
}
