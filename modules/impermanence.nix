{
  config,
  lib,
  username,
  ...
}:
{
  boot.tmp.cleanOnBoot = true;
  environment.persistence."/nix/persist" = lib.mkIf (!(config.system.build ? vm)) {
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
