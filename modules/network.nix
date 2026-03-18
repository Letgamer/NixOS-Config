{
  pkgs,
  hostname,
  ...
}:
{
  networking.hostName = "${hostname}";
  networking.networkmanager = {
    enable = true;
  };
  networking.firewall.enable = false;

  environment.systemPackages = with pkgs; [
    impala
    openvpn
    wireguard-tools
    eduvpn-client
    tailscale
  ];
}