# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  cupp = pkgs.callPackage ./cupp.nix {};
  #AD
  ntlm_theft = pkgs.callPackage ./ntlm_theft.nix {};
  pkinittools = pkgs.callPackage ./pkinittools.nix {};
  wmiexec-pro = pkgs.callPackage ./wmiexec-pro.nix {};
  petitpotam = pkgs.callPackage ./petitpotam.nix {};
  gmsadumper = pkgs.callPackage ./gmsadumper.nix {};
  bloodhound-quickwin = pkgs.callPackage ./bloodhound-quickwin.nix {};
}
