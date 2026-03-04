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

      mkHome =
        {
          pkgs,
          modules,
          username,
        }:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit username; };
          inherit modules;
        };
    in
    {
      homeConfigurations = {
        "darwin" = mkHome {
          pkgs = pkgsDarwin;
          username = "matukoto";
          modules = [ ./darwin.nix ];
        };

        "linux" = mkHome {
          pkgs = pkgsLinux;
          username = "matsumoto";
          modules = [ ./linux.nix ];
        };
      };
    };
}
