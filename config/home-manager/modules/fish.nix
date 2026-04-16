{
  config,
  hostname,
  pkgs,
  ...
}:

let
  homeManagerRepoDir = "${config.home.homeDirectory}/work/github.com/matukoto/dotfiles";
  homeManagerFlakeTarget = if pkgs.stdenv.isDarwin then "darwin" else hostname;
  homeManagerSwitchCommand =
    if pkgs.stdenv.isDarwin then
      ''sudo -H nix --extra-experimental-features "nix-command flakes" run .#darwin-rebuild -- switch --flake ".#${homeManagerFlakeTarget}"''
    else
      ''nix --extra-experimental-features "nix-command flakes" run .#home-manager -- switch --flake ".#${homeManagerFlakeTarget}"'';
  configFishTemplate = builtins.readFile ../fish/config.fish;
  privatePluginEnabledLine =
    if pkgs.stdenv.isDarwin then "set -x PRIVATE_PLUGIN_ENABLED true" else "";
  browserLine = if pkgs.stdenv.isDarwin then "set -x BROWSER open" else "set -x BROWSER wslview";
  generatedConfigFishBase =
    builtins.replaceStrings
      [
        "# __PRIVATE_PLUGIN_ENABLED_LINE__"
        "# __BROWSER_LINE__"
        "# __FISH_CONFIG_GENERATION_HASH_LINE__"
      ]
      [
        privatePluginEnabledLine
        browserLine
        ""
      ]
      configFishTemplate;
  configGenerationHash = builtins.hashString "sha256" generatedConfigFishBase;
  generatedConfigFish =
    builtins.replaceStrings
      [
        "# __PRIVATE_PLUGIN_ENABLED_LINE__"
        "# __BROWSER_LINE__"
        "# __FISH_CONFIG_GENERATION_HASH_LINE__"
      ]
      [
        privatePluginEnabledLine
        browserLine
        ''set -x FISH_CONFIG_GENERATION_HASH "${configGenerationHash}"''
      ]
      configFishTemplate;
in
{
  xdg.configFile = {
    "fish/conf.d/_key_bindings.fish".source = ../fish/conf.d/_key_bindings.fish;
    "fish/conf.d/tide_settings.fish".source = ../fish/conf.d/tide_settings.fish;
    "fish/conf.d/fish_greeting.fish".source = ../fish/conf.d/fish_greeting.fish;
    "fish/functions/pull_skk_dict.fish".source = ../fish/functions/pull_skk_dict.fish;
    "fish/functions/_tide_item_java.fish".source = ../fish/functions/_tide_item_java.fish;
    "fish/functions/_tide_item_character.fish".source = ../fish/functions/_tide_item_character.fish;
    "fish/functions/_tide_item_svelte.fish".source = ../fish/functions/_tide_item_svelte.fish;
    "fish/functions/update_skk_dict.fish".source = ../fish/functions/update_skk_dict.fish;
    "fish/functions/_tide_item_lua.fish".source = ../fish/functions/_tide_item_lua.fish;
    "fish/functions/_tide_item_fsharp.fish".source = ../fish/functions/_tide_item_fsharp.fish;
    "fish/functions/_tide_item_git.fish".source = ../fish/functions/_tide_item_git.fish;
    "fish/functions/_tide_item_vi_mode.fish".source = ../fish/functions/_tide_item_vi_mode.fish;
    "fish/functions/yy.fish".source = ../fish/functions/yy.fish;
    "fish/functions/_tide_item_csharp.fish".source = ../fish/functions/_tide_item_csharp.fish;
    "fish/functions/ghf.fish".source = ../fish/functions/ghf.fish;
    "fish/functions/hms.fish".text = ''
      function hms --description "現在のホスト向けに設定を反映する"
          set -l current_dir (pwd)
          cd "${homeManagerRepoDir}"
          and ${homeManagerSwitchCommand}
          set -l status_code $status
          cd "$current_dir"
          return $status_code
      end
    '';
    "fish/functions/hmu.fish".text = ''
      function hmu --description "flake を更新して現在のホスト向けに設定を反映する"
          set -l current_dir (pwd)
          cd "${homeManagerRepoDir}"
          and nix flake update
          and ${homeManagerSwitchCommand}
          set -l status_code $status
          cd "$current_dir"
          return $status_code
      end
    '';
  };

  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
    ];

    # 本文は fish-lsp/formatter で扱える .fish を基準に、OS別行だけNixで生成する
    shellInit = generatedConfigFish;
  };
}
