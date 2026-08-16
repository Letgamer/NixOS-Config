{
  description = "My NixOS Hyprland Pentesting Configuration";

  nixConfig = {
    experimental-features = [
      "flakes"
      "nix-command"
    ];
    extra-substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org/"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    preservation.url = "github:nix-community/preservation";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-nixcord.follows = "nixpkgs";
    };
    gazelle = {
      url = "github:Zeus-Deus/gazelle-tui";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    burpsuite-nix = {
      url = "github:Red-Flake/burpsuite-nix";
      #url = "path:/home/user/burpsuite-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    multiverse.url = "github:fzakaria/nixpkgs-multiverse";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    system = "x86_64-linux";
    username = "user";
    hostname = "nixos";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      ${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit
            inputs
            outputs
            lib
            username
            hostname
            ;
        };
        modules = [
          ./hosts/${hostname}
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {
              inherit username hostname inputs outputs;
            };
            home-manager.users.${username} = {
              imports = [
                ./home-manager/hosts
              ];
            };
          }
        ];
      };

      surface = let
        hostname = "surface";
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              inputs
              outputs
              lib
              username
              hostname
              ;
          };
          modules = [
            ./hosts/${hostname}
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = {
                inherit username hostname inputs outputs;
              };
              home-manager.users.${username} = {
                imports = [
                  ./home-manager/hosts
                ];
              };
            }
          ];
        };

      desktop = let
        hostname = "desktop";
      in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              inputs
              outputs
              lib
              username
              hostname
              ;
          };
          modules = [
            ./hosts/${hostname}
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = {
                inherit username hostname inputs outputs;
              };
              home-manager.users.${username} = {
                imports = [
                  ./home-manager/hosts
                ];
              };
            }
          ];
        };
    };

    # Packages available via `nix build .#<name>`
    packages.${system} = import ./pkgs pkgs;

    # Code formatter used with `nix fmt`
    formatter.${system} = pkgs.alejandra;

    # Custom overlays
    overlays = import ./overlays {inherit inputs;};

    # Exported NixOS modules
    nixosModules = import ./modules;

    # Exported Home Manager modules
    homeManagerModules = import ./home-manager/modules;
  };
}
