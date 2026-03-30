{
  lib,
  pkgs,
  outputs,
  inputs,
  ...
}: {
  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      inputs.firefox-addons.overlays.default
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      allowBroken = true;
      allowInsecurePredicate = x: true;
      allowUnsupportedSystem = true;
      android_sdk.accept_license = true;
      microsoftVisualStudioLicenseAccepted = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      builders-use-substitutes = true;
      auto-optimise-store = true;
      log-lines = 20;
      max-jobs = "auto";
      # Don't warn about dirty flakes and accept flake configs by default
      accept-flake-config = true;
      warn-dirty = false;

      eval-cache = true;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 5 --keep-since 3d";
    flake = "/home/user/NixOS-Config";
  };

  programs.nix-ld.enable = true;
}
