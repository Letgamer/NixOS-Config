# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: let
    pkgs-hypr = inputs.hyprland.inputs.nixpkgs.legacyPackages.${final.system};
  in {
    # Replace Mesa, Wayland, and related libraries with Hyprland-compatible versions
    #mesa = pkgs-hypr.mesa;
    #wayland = pkgs-hypr.wayland;
    #wayland-protocols = pkgs-hypr.wayland-protocols;
    #libxkbcommon = pkgs-hypr.libxkbcommon;
  };


  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
