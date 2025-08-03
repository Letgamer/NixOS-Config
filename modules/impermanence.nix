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
      "/var/lib/swapfile"
    ];
    users.${username} = {
      directories = [
        "flake"
        ".config/OpenRGB/"
        {
          directory = ".ssh";
          mode = "0700";
        }
      ];
    };
  };
}
