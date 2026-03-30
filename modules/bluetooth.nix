{pkgs, ...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General = {
      # Show battery status
      Experimental = true;
    };
  };

  environment.systemPackages = with pkgs; [
    bluetui
  ];
}
