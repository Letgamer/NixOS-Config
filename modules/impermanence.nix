{
  config,
  lib,
  pkgs,
  modulesPath,
  username,
  ...
}: {
  boot.tmp.cleanOnBoot = true;
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/root"
      "/var/lib/nixos"
      "/etc/ssh"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.${username} = {
      directories = [
        "flake"
        {
          directory = ".ssh";
          mode = "0700";
        }
      ];
    };
  };
}
