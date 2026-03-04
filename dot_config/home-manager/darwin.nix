{
  config,
  pkgs,
  ...
}:

{
  imports = [ ./home.nix ];

  home = {
    homeDirectory = "/Users/matukoto";

    packages = with pkgs; [
    ];
  };
}
