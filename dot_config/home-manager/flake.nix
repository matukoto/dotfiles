{
  description = "Home Manager configuration of matukoto";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      neovim-nightly-overlay,
      ...
    }:
    let
      sharedOverlays = [ neovim-nightly-overlay.overlays.default ];

      pkgsDarwin = import nixpkgs {
        system = "aarch64-darwin";
        overlays = sharedOverlays;
      };

      pkgsLinux = import nixpkgs {
        system = "x86_64-linux";
        overlays = sharedOverlays;
      };
    in
    {
      homeConfigurations = {
        "matukoto@darwin" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsDarwin;
          modules = [
            ./darwin.nix
          ];
        };

        "matukoto@linux" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsLinux;
          modules = [
            ./linux.nix
          ];
        };
      };
    };
}
