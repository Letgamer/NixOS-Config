{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;

    settings = {
      env = [
        "NIXOS_OZONE_WL,1"
        "ELECTRON_OZONE_PLATFORM_HINT,wayland"
        "MOZ_ENABLE_WAYLAND,1"
        "OZONE_PLATFORM,wayland"
        "EGL_PLATFORM,wayland"
        "CLUTTER_BACKEND,wayland"
        "SDL_VIDEODRIVER,wayland"
        "NIXPKGS_ALLOW_UNFREE,1"
        "QT_ENABLE_HIGHDPI_SCALING,1"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "_JAVA_AWT_WM_NONREPARENTING,1"
      ];
      monitor = ",preferred,auto,1";
    };
  };
}
