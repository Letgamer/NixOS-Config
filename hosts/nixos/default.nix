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

  hardware.enableRedistributableFirmware = true;

  # Needed for home-manager impermanence!
  programs.fuse.userAllowOther = true;

  networking.hostName = "${hostname}";

  boot.tmp.cleanOnBoot = true;
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/root"
      "/var/lib/nixos"
      "/etc/ssh"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.${username} = {
      directories = [
        "flake"
        { directory = ".ssh"; mode = "0700"; }
      ];
    };
  };

  users.mutableUsers = false;
  users.users.root.hashedPassword = "$y$j9T$jHODSqFn4BM1Z8DbpJR0e.$H/H8ORqJqOdfyzJnkhJrzMccilcLUXZvxtGLahpNci9";
  # Use the systemd-boot EFI boot loader.

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

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  #  networking.networkmanager.enable = true;

  networking.wireless.enable = true;

  networking.wireless.networks = {
    "Fritz!Box 7590 GF" = {
      # SSID with spaces and/or special characters
      psk = "93855776213011631045";
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    hashedPassword = "$y$j9T$jHODSqFn4BM1Z8DbpJR0e.$H/H8ORqJqOdfyzJnkhJrzMccilcLUXZvxtGLahpNci9";
    #   packages = with pkgs; [
    #     tree
    #   ];
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    nixpkgs-fmt
    nixfmt-rfc-style
    alejandra
    btop
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
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
