{
  description = "Nix configuration of matukoto";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs =
    inputs@{
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    nix-homebrew,
    ...
  }:
    let
      darwinHostName = "MATSUMOTOnoMacBook-Air";
      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfreePredicate =
            pkg:
            builtins.elem (nixpkgs.lib.getName pkg) [
              "copilot-language-server"
            ];
        };

      mkHome =
        {
          system,
          modules,
          hostname,
          username,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs system;
          extraSpecialArgs = {
            inherit
              hostname
              inputs
              username
              ;
          };
          inherit modules;
        };

      mkDarwin =
        {
          modules ? [ ],
          hostname,
          username,
        }:
        nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit
              hostname
              inputs
              username
              ;
            inherit nix-homebrew;
          };
          modules = [
            ./config/home-manager/darwin-system.nix
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            ./config/home-manager/darwin-homebrew.nix
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit
                  hostname
                  inputs
                  username
                  ;
              };
              home-manager.users.${username} = import ./config/home-manager/darwin.nix;
            }
          ]
          ++ modules;
        };

      darwinConfiguration = mkDarwin {
        username = "matukoto";
        hostname = darwinHostName;
      };

      darwinHomeConfiguration = mkHome {
        system = "aarch64-darwin";
        username = "matukoto";
        hostname = darwinHostName;
        modules = [ ./config/home-manager/darwin.nix ];
      };

      mkLinuxHome =
        hostname:
        mkHome {
          system = "x86_64-linux";
          username = "matsumoto";
          inherit hostname;
          modules = [ ./config/home-manager/linux.nix ];
        };
    in
    {
      homeConfigurations = {
        "linux" = mkLinuxHome "linux";
        "DesktopFractal" = mkLinuxHome "DesktopFractal";
        "ThinkPadE14" = mkLinuxHome "ThinkPadE14";
        "darwin" = darwinHomeConfiguration;
        "${darwinHostName}" = darwinHomeConfiguration;
      };

      darwinConfigurations = {
        "darwin" = darwinConfiguration;
        "${darwinHostName}" = darwinConfiguration;
      };

      checks = {
        x86_64-linux = {
          linux-activation = self.homeConfigurations.linux.activationPackage;
        };

        aarch64-darwin = {
          darwin-system = self.darwinConfigurations.darwin.config.system.build.toplevel;
        };
      };

      packages = {
        x86_64-linux = {
          home-manager = home-manager.packages.x86_64-linux.home-manager;
          default = home-manager.packages.x86_64-linux.home-manager;
        };

        aarch64-darwin = {
          home-manager = home-manager.packages.aarch64-darwin.home-manager;
          darwin-rebuild = nix-darwin.packages.aarch64-darwin.darwin-rebuild;
          default = nix-darwin.packages.aarch64-darwin.darwin-rebuild;
        };
      };
    };
}
