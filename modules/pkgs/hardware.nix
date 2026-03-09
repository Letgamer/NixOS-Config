{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    picocom
    cutecom
    stlink
    gcc-arm-embedded
  ];
}