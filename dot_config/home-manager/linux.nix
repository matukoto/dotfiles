{
  config,
  pkgs,
  ...
}:

{
  imports = [ ./home.nix ];

  home = {
    homeDirectory = "/home/matukoto";

    packages = with pkgs; [
      csharp-ls
    ];
  };
}
