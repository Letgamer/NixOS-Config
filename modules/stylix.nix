{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    cursor.package = pkgs.rose-pine-hyprcursor;
    cursor.name = "BreezX-RosePine-Linux";
    cursor.size = 24;
  };
}
