{
  fileSystems."/nix".neededForBoot = true;
  fileSystems."/persistent".neededForBoot = true; # sometimes needed too

  disko.devices.nodev = {
    "/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=25%"
        "mode=755"
      ];
    };
  };

  disko.devices.disk.main = {
    # This value is overwritten by disko-install
    device = "/dev/null";
    type = "disk";

    content.type = "gpt";

    content.partitions.esp = {
      name = "ESP";
      size = "2G";
      type = "EF00";

      content = {
        type = "filesystem";
        format = "vfat";
        mountpoint = "/boot";
      };
    };

    content.partitions.swap = {
      size = "4G";

      content = {
        type = "swap";
        resumeDevice = true;
      };
    };

    content.partitions.root = {
      name = "root";
      size = "100%";

      content = {
        type = "btrfs";
        extraArgs = ["-f"];

        subvolumes = {
          "/persistent" = {
            mountOptions = ["subvol=persistent" "noatime" "compress=zstd:3" "discard=async" "lazytime"];
            mountpoint = "/persistent";
          };

          "/nix" = {
            mountOptions = ["subvol=nix" "noatime" "compress=zstd:3" "discard=async" "lazytime"];
            mountpoint = "/nix";
          };
        };
      };
    };
  };
}
