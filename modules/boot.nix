{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 2;
      };
      efi.canTouchEfiVariables = true;
    };
    bcache.enable = false;
    kexec.enable = false;

    # Silent boot
    consoleLogLevel = 3;
    initrd.verbose = false;
  };

  # Enable the systemd job boot animation
  services.bootvine.enable = true;

  # Modernize the boot process
  system.nixos-init.enable = true;
  system.etc.overlay.enable = true;
  services.userborn.enable = true;
  system.tools.nixos-generate-config.enable = false;
  services.lvm.enable = false;
}
