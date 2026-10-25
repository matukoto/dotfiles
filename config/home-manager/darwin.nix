{
  config,
  pkgs,
  username,
  ...
}:

{
  imports = [ ./home.nix ];

  home = {
    homeDirectory = "/Users/${username}";

    packages = with pkgs; [
      colima
      aerospace
      leetcode-cli
      jankyborders
      pinentry_mac
      neovim
    ];
  };

}
