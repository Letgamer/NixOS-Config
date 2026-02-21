{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  system,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # enable x11 legacy support
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  services.displayManager.defaultSession = "hyprland";

  # XDPH doesn’t implement a file picker. For that, it is recommended to install xdg-desktop-portal-gtk alongside XDPH.
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-gtk
  ];

  security.pam.services.hyprlock = { };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Auto startup without login manager
  services.xserver.displayManager.lightdm.enable = false;
  services.getty.autologinUser = "user";
  environment.loginShellInit = ''
    if uwsm check may-start; then
      exec uwsm start hyprland-uwsm.desktop
    fi
  '';
}
