{ lib, username, ... }:

{
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "copilot-language-server"
      ];
  };

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  system.primaryUser = username;
  system.stateVersion = 6;
}
