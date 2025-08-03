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
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:NixOS/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland"; # Prevents version mismatch.
    };
  };

  outputs = {
    self,
    nixpkgs,
    hardware,
    impermanence,
    home-manager,
    hyprland,
    hyprland-plugins,
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
          inherit inputs outputs lib username hostname;
        };
        modules = [
          ./hosts/${hostname}
          impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit username inputs outputs;
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
