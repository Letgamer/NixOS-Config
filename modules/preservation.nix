{username, ...}: {
  preservation = {
    enable = true;

    preserveAt."/persistent" = {
      directories = [
        "/etc/nixos"
        "/var/lib/bluetooth"
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
      ];

      files = [
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
          "Documents"
          "NixOS-Config"
        ];

        files = [
          ".zsh_history"
        ];
      };
    };
  };
}
