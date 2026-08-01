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
    tmp.cleanOnBoot = true;

    # Silent boot
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  # Modernize the boot process
  system.nixos-init.enable = true;
  system.etc.overlay.enable = true;
  services.userborn.enable = true;
  system.tools.nixos-generate-config.enable = false;
  services.lvm.enable = false;
}
