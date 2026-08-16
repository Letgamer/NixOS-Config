{username, ...}: {
  # Fix failing systemd unit
  systemd.suppressedSystemUnits = [
    "systemd-machine-id-commit.service"
  ];

  preservation = {
    enable = true;

    preserveAt."/persistent" = {
      directories = [
        "/etc/nixos"
        "/var/lib/bluetooth"
        "/var/lib/NetworkManager"
        "/etc/NetworkManager/system-connections"
      ];

      files = [
        "/var/db/sudo/lectured/1000"
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
        {
          file = "/etc/ssh/ssh_host_rsa_key";
          how = "symlink";
          configureParent = true;
        }
        {
          file = "/etc/ssh/ssh_host_ed25519_key";
          how = "symlink";
          configureParent = true;
        }
      ];

      # Preserve user files
      users."${username}" = {
        commonMountOptions = [
          "x-gvfs-hide"
        ];
        directories = [
          {
            directory = ".ssh";
            mode = "0700";
          }
          ".mozilla"
          ".config"
          ".local"
          ".BurpSuite"
          ".java"
          "Documents"
          "Downloads"
          "Pictures"
          "NixOS-Config"
          "nixpkgs"
        ];

        files = [
          ".zsh_history"
        ];
      };
    };
  };
}
