{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 1;
      };
      efi.canTouchEfiVariables = true;
    };

    # Silent boot
    consoleLogLevel = 0;
    initrd.verbose = false;
  };
}
