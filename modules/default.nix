# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  hyprland = import ./hyprland.nix;
  boot = import ./boot.nix;
  impermanence = import ./impermanence.nix;
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

  pkgs = {
    default = import ./pkgs/default.nix;
    mobile = import ./pkgs/mobile.nix;
    hardware = import ./pkgs/hardware.nix;
  };
}
