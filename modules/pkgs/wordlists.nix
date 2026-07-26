{
  pkgs,
  inputs,
  ...
}: {
  # TODO: upstream cupp to nixpkgs
  # https://github.com/Red-Flake/red-flake-nix/blob/main/nixos/overlays/cupp-overlay/default.nix
  environment.systemPackages = with pkgs; [
    cewl
    crunch
    cupp
    username-anarchy
  ];

  systemd.tmpfiles.rules = [
    "L+ /usr/share/wordlists - - - - ${inputs.wordlists}"
  ];
}
