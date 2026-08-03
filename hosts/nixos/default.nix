# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  outputs,
  inputs,
  ...
}: {
  imports = [
    # all modules used
    outputs.nixosModules.hyprland
    outputs.nixosModules.boot
    outputs.nixosModules.locale
    #outputs.nixosModules.hardware
    outputs.nixosModules.ssh
    #outputs.nixosModules.rgb
    outputs.nixosModules.stylix
    outputs.nixosModules.sound
    outputs.nixosModules.bluetooth
    outputs.nixosModules.network
    outputs.nixosModules.nixpkgs
    outputs.nixosModules.users
    outputs.nixosModules.virtualisation
    outputs.nixosModules.disko
    outputs.nixosModules.preservation

    # all packages installed
    #outputs.nixosModules.pkgs.ad
    #outputs.nixosModules.pkgs.crypto
    outputs.nixosModules.pkgs.default
    outputs.nixosModules.pkgs.dev
    #outputs.nixosModules.pkgs.forensics
    #outputs.nixosModules.pkgs.hardware
    #outputs.nixosModules.pkgs.misc
    #outputs.nixosModules.pkgs.mobile
    #outputs.nixosModules.pkgs.network
    #outputs.nixosModules.pkgs.protocols
    #outputs.nixosModules.pkgs.pwn
    #outputs.nixosModules.pkgs.web
    #outputs.nixosModules.pkgs.windows
    #outputs.nixosModules.pkgs.wordlists

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    inputs.stylix.nixosModules.stylix
    inputs.preservation.nixosModules.default
    inputs.disko.nixosModules.disko
  ];

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 4096; # Use 2048MiB memory.
      cores = 3;
      qemu.options = [
        "-vga std"
        "-display gtk"
        "-device VGA,vgamem_mb=1028"
      ];
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  services.libinput.touchpad.naturalScrolling = true;

  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "schedutil"; # power, performance, ondemand
  };
  services.power-profiles-daemon.enable = true;

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
  system.stateVersion = "26.05"; # Did you read the comment?
}
