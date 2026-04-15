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
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
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
          };
          modules = [
            ./config/home-manager/darwin-system.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-backup";
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
          darwin-rebuild = nix-darwin.packages.aarch64-darwin.darwin-rebuild;
          default = nix-darwin.packages.aarch64-darwin.darwin-rebuild;
        };
      };
    };
}
