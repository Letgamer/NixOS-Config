{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    macchanger
    nmap
    socat

    # Proxy and traffic manipulation tools
    mitmproxy
    ssh-mitm
    tcpdump

    # Pivoting and tunneling tools
    chisel
    iodine
    ligolo-ng
    ngrok # Run 'ngrok config add-authtoken' first!
    penelope
    proxychains-ng
    sshuttle

    # Wireless tools
    (airgeddon.override {
      supportHashCracking = true;
      supportEvilTwin = true;
    })
    aircrack-ng
    bettercap
    bully
    hcxdumptool
    hcxtools
    kismet
    pixiewps
    reaverwps
    reaverwps-t6x
    wifite2
  ];

  # Make the proxychains config writeable on the fly
  systemd.tmpfiles.rules = [
    "C /etc/proxychains.conf - - - - ${pkgs.proxychains-ng}/etc/proxychains.conf"
  ];

  # Setup nmap with capabilities in order to use it without sudo
  security.wrappers.nmap = {
    source = lib.getExe' pkgs.nmap "nmap";
    owner = "root";
    group = "root";
    capabilities = "cap_net_raw+ep";
  };

  # https://github.com/nmap/nmap/pull/3356
  environment.sessionVariables = {
    NMAP_PRIVILEGED = "1";
    NPING_PRIVILEGED = "1";
  };
}
