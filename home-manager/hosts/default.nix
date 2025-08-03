{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
  home.homeDirectory = "/home/${username}";
  home.username = "${username}";

  programs = {
    home-manager.enable = true;
    git = {
      # can use home-manager normally as well as with persistence
      enable = true;
      userName = "Letgamer";
      userEmail = "alexstephan005@gmail.com ";
    };
  };

  #home.persistence."/nix/persist/home/${username}" = {
  #  allowOther = true;
  #  directories = [
  #    ".ssh"
  #    "flake"
  #    ];
  #};

  home.stateVersion = "25.05";
}
