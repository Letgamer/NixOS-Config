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
