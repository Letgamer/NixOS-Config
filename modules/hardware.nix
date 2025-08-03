{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  hardware.enableRedistributableFirmware = true;
}
