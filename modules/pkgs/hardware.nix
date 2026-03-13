{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    picocom
    cutecom
    stlink
    can-utils
    gcc-arm-embedded
    gnumake
  ];
  programs.wireshark = {
    enable = true;
    dumpcap.enable = true;
    usbmon.enable = true;
    package = pkgs.wireshark;
  };
}