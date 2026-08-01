{
  lib,
  outputs,
  inputs,
  pkgs,
  ...
}: {
  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      #(import ../overlays/burpsuite.nix)
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
      # For Hashcat
      rocmSupport = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = [
        "auto-allocate-uids"
        "cgroups"
        "nix-command flakes"
      ];
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

      # for systemd-nspawn tests
      auto-allocate-uids = true;
      system-features = ["uid-range"];
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry =
      lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs
      // {
        n.flake = inputs.nixpkgs;
        u.flake = inputs.nixpkgs-unstable;
      };
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 5 --keep-since 3d";
    flake = "/home/user/NixOS-Config";
  };

  # Enable AppImage support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Enable Flatpak support
  services.flatpak.enable = true;

  systemd.services.flatpak-flathub = {
    description = "Add Flathub Flatpak remote";

    wantedBy = ["multi-user.target"];

    after = ["network-online.target"];
    wants = ["network-online.target"];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      Restart = "on-failure";
      RestartSec = "10s";
    };

    script = ''
      ${lib.getExe pkgs.flatpak} remote-add --system --if-not-exists flathub \
        https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # For non-NixOs compatability
  programs.nix-ld.enable = true;
  services.envfs.enable = true;
  environment.systemPackages = with pkgs; [
    steam-run
    flatpak-builder
  ];

  # Reducing the closure size of the system
  documentation.doc.enable = false;
  documentation.nixos.enable = false;
  documentation.info.enable = false;

  environment.defaultPackages = [];
  services.speechd.enable = false;
  fonts.enableGhostscriptFonts = false;
  fonts.enableDefaultPackages = false;
}
