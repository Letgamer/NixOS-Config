{
  username,
  inputs,
  outputs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    outputs.homeManagerModules.git
    outputs.homeManagerModules.hyprland
    outputs.homeManagerModules.waybar
    outputs.homeManagerModules.wayland
    outputs.homeManagerModules.ssh
    outputs.homeManagerModules.firefox
    outputs.homeManagerModules.vscode
    outputs.homeManagerModules.terminal
    outputs.homeManagerModules.spotify
    #outputs.homeManagerModules.discord
    outputs.homeManagerModules.burpsuite
    outputs.homeManagerModules.distrobox
    # Currently it is not possible to use the cli for creating bottles
    #outputs.homeManagerModules.bottles

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    #inputs.stylix.homeModules.stylix

    # This uses a database based on unstable, which can mismatch with stable in rare cases
    inputs.nix-index-database.homeModules.default
    inputs.spicetify-nix.homeManagerModules.spicetify
    inputs.nixcord.homeModules.nixcord
    inputs.gazelle.homeModules.gazelle
    inputs.burpsuite-nix.homeManagerModules.default
  ];

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "26.05";
}
