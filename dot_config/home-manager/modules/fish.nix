{ pkgs, ... }:

let
  generatedConfigFish = builtins.replaceStrings
    [
      "# __PRIVATE_PLUGIN_ENABLED_LINE__"
      "# __BROWSER_LINE__"
    ]
    [
      (if pkgs.stdenv.isDarwin then "set -x PRIVATE_PLUGIN_ENABLED true" else "")
      (if pkgs.stdenv.isDarwin then "set -x BROWSER open" else "set -x BROWSER wslview")
    ]
    (builtins.readFile ../fish/config.fish);
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
