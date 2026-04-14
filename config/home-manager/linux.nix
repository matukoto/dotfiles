{
  config,
  pkgs,
  username,
  ...
}:

{
  imports = [ ./home.nix ];

  home = {
    homeDirectory = "/home/${username}";

    packages = with pkgs; [
      csharp-ls
    ];
  };
}
