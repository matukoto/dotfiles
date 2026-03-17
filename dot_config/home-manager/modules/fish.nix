{ config, pkgs, ... }:

let
  homeManagerFlakeDir = "${config.home.homeDirectory}/.local/share/chezmoi/dot_config/home-manager";
  homeManagerFlakeTarget = if pkgs.stdenv.isDarwin then "darwin" else "linux";
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
    "fish/functions/hmu.fish".text = ''
      function hmu --description "flake を更新して home-manager を現在の OS 向けに切り替える"
          set -l current_dir (pwd)
          cd "${homeManagerFlakeDir}"
          and home-manager switch --flake ".#${homeManagerFlakeTarget}"
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
