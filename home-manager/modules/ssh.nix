{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
        forwardAgent = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        compression = false;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_redline-ssh";
        addKeysToAgent = "yes";
      };
    };
  };
}
