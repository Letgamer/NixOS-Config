{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  environment.systemPackages = with pkgs; [
    openrgb-with-all-plugins
    kitty
  ];
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
  };
}
