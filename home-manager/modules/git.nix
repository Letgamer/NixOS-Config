{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  programs = {
    git = {
      # can use home-manager normally as well as with persistence
      enable = true;
      userName = "Letgamer";
      userEmail = "alexstephan005@gmail.com ";
    };
  };
}
