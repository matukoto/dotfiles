{ config, pkgs, ... }:

{
  home = {
    username = "matukoto";
    homeDirectory = "/Users/matukoto";

    stateVersion = "25.11"; # Please read the comment before changing.
    packages = with pkgs; [
      nixfmt-rfc-style
      nixd
      neovim
    ];

    file = {
    };

  };

  programs.home-manager.enable = true;
}
