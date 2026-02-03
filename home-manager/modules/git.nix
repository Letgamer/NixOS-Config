{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Letgamer";
      user.email = "alexstephan005@gmail.com";
    };
  };
}
