{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  # https://home-manager-options.extranix.com/?query=waybar&release=release-25.11
  programs.waybar = {
    enable = true;
    # Enabling waybar systemd target
    systemd.enable = true;
  };
}
