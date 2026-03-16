{
  pkgs,
  hostname,
  ...
}:
{
  networking.hostName = "${hostname}";
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };
  networking.firewall.enable = false;

  environment.systemPackages = with pkgs; [
    impala
    openvpn
  ];
}