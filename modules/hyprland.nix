{username, ...}: {
  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # enable x11 legacy support
  };

  services.displayManager.defaultSession = "hyprland";

  security.pam.services.hyprlock = {};

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.udisks2.enable = true;

  services.dbus.implementation = "broker";

  # Auto startup without login manager
  services.xserver.displayManager.lightdm.enable = false;
  services.getty.autologinUser = "${username}";
  environment.loginShellInit = ''
    if uwsm check may-start; then
      exec uwsm start hyprland-uwsm.desktop
    fi
  '';
}
