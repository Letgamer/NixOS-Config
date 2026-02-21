{
  config,
  pkgs,
  username,
  inputs,
  outputs,
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    outputs.homeManagerModules.git
    outputs.homeManagerModules.hyprland
    outputs.homeManagerModules.waybar
    outputs.homeManagerModules.wayland

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    #inputs.stylix.homeModules.stylix
  ];

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";
}
