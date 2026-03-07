# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  git = import ./git.nix;
  hyprland = import ./hyprland.nix;
  waybar = import ./waybar.nix;
  wayland = import ./wayland.nix;
  ssh = import ./ssh.nix;
  firefox = import ./firefox.nix;
  vscode = import ./vscode.nix;
  terminal = import ./terminal.nix;
}
