{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "Lat2-Terminus16";
    keyMap = "de";
  };
}
