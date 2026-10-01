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
      "pakerwreah/calendr"
      "abue-ammar/tinycast"
    ];

    brews = [
      "cmake"
      "gettext"
      "ninja"
      "pinentry-mac"
      "herdr"
    ];

    casks = [
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
      "tinycast"
      "vivaldi"
      "wezterm"
      "zoom"
    ];
  };
}
