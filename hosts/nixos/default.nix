# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  outputs,
  inputs,
  username,
  hostname,
  ...
}: {
  imports = [
    # Hardware config
    inputs.hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    # all modules used
    outputs.nixosModules.hyprland
    outputs.nixosModules.boot
    outputs.nixosModules.impermanence
    outputs.nixosModules.locale
    outputs.nixosModules.hardware
    outputs.nixosModules.ssh
    outputs.nixosModules.rgb

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # Needed for home-manager impermanence!
  #programs.fuse.userAllowOther = true;

  networking.hostName = "${hostname}";

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
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Don't warn about dirty flakes and accept flake configs by default
    extraOptions = ''
      accept-flake-config = true
      warn-dirty = false
    '';

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1d";
    };

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  programs.nix-ld.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "render"
      ]; # Enable ‘sudo’ for the user.
    hashedPassword = "$y$j9T$jHODSqFn4BM1Z8DbpJR0e.$H/H8ORqJqOdfyzJnkhJrzMccilcLUXZvxtGLahpNci9";
    #   packages = with pkgs; [
    #     tree
    #   ];
  };

  users.mutableUsers = false;
  users.users.root.hashedPassword = "$y$j9T$jHODSqFn4BM1Z8DbpJR0e.$H/H8ORqJqOdfyzJnkhJrzMccilcLUXZvxtGLahpNci9";

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    nixpkgs-fmt
    nixfmt-rfc-style
    alejandra
    btop
    hashcat
  ];

  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
