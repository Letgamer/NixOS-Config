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
    lfs.enable = true;
    settings = {
      user.name = "Letgamer";
      user.email = "alexstephan005@protonmail.com";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
    signing = {
      format = "ssh";
      key = "~/.ssh/id_redline-ssh.pub";
      signByDefault = true;
    };
  };
}
