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
    ];
  };
}
