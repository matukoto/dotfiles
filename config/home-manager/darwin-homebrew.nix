{ username, ... }:

{
  nix-homebrew = {
    enable = true;
    enableRosetta = false;
    autoMigrate = true;
    user = username;
  };

  homebrew = {
    enable = true;
    user = username;

    global.autoUpdate = false;

    onActivation = {
      autoUpdate = false;
      upgrade = true;
    };

    taps = [
      # "felixkratz/formulae"
      "mtgto/macskk"
      "nikitabobko/tap"
      "pakerwreah/calendr"
    ];

    brews = [
      "cmake"
      "gettext"
      "ninja"
      "pinentry-mac"
      "herdr"
    ];

    casks = [
      "aqua-voice"
      "bitwarden"
      "calendr"
      "discord"
      "font-hack-nerd-font"
      "ghostty"
      "google-chrome"
      "homerow"
      "karabiner-elements"
      "macskk"
      "obsidian"
      "raycast"
      "tinycast"
      "vivaldi"
      "wezterm"
      "zoom"
      "logi-options+"
      "google-gemini"
    ];
  };
}
