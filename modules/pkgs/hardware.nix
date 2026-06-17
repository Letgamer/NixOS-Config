{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    can-utils
    cutecom
    gcc-arm-embedded
    gnumake
    picocom
    stlink
  ];

  programs.wireshark = {
    enable = true;
    dumpcap.enable = true;
    usbmon.enable = true;
  };
}
