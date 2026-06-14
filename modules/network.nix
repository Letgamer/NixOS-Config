{
  pkgs,
  hostname,
  lib,
  ...
}: {
  # For /etc/hostname
  networking.hostName = "${hostname}";
  environment.etc.hostname.mode = "0644";

  # Make /etc/hosts writeable
  environment.etc."hosts".enable = false;
  system.activationScripts.initHosts = lib.mkAfter ''
    if [ ! -e /etc/hosts ]; then
      printf "%s\n" \
        "127.0.0.1 localhost" \
        "::1       localhost" \
        "127.0.0.2 ${hostname}" \
        "::1       ${hostname}" \
      > /etc/hosts
    fi
  '';

  networking.networkmanager = {
    enable = true;
    wifi = {
      #backend = "iwd";
    };
  };
  networking.firewall.enable = false;
  networking.nftables.enable = false;

  environment.systemPackages = with pkgs; [
    eduvpn-client
    impala
    openvpn
    tailscale
    wireguard-tools
  ];
}
