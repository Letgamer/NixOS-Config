# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  hyprland = import ./hyprland.nix;
  boot = import ./boot.nix;
  locale = import ./locale.nix;
  hardware = import ./hardware.nix;
  ssh = import ./ssh.nix;
  rgb = import ./rgb.nix;
  stylix = import ./stylix.nix;
  sound = import ./sound.nix;
  bluetooth = import ./bluetooth.nix;
  network = import ./network.nix;
  nixpkgs = import ./nixpkgs.nix;
  users = import ./users.nix;
  virtualisation = import ./virtualisation.nix;
  disko = import ./disko.nix;
  preservation = import ./preservation.nix;

  pkgs = {
    ad = import ./pkgs/ad.nix;
    crypto = import ./pkgs/crypto.nix;
    default = import ./pkgs/default.nix;
    dev = import ./pkgs/dev.nix;
    forensics = import ./pkgs/forensics.nix;
    hardware = import ./pkgs/hardware.nix;
    misc = import ./pkgs/misc.nix;
    mobile = import ./pkgs/mobile.nix;
    network = import ./pkgs/network.nix;
    protocols = import ./pkgs/protocols.nix;
    pwn = import ./pkgs/pwn.nix;
    web = import ./pkgs/web.nix;
    windows = import ./pkgs/windows.nix;
    wordlists = import ./pkgs/wordlists.nix;
  };
}
