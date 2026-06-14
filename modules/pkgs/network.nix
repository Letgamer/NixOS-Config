{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nmap
    socat
    macchanger

    # Pivoting and tunneling tools
    ligolo-ng
    chisel
    proxychains-ng
    sshuttle
    iodine
    ngrok # Run 'ngrok config add-authtoken' first!

    # Proxy and traffic manipulation tools
    mitmproxy
    tcpdump
    ssh-mitm

    # Wireless tools
    bettercap
    aircrack-ng
    kismet
    reaverwps
    wifite2
    hcxdumptool
    hcxtools
    bully
    pixiewps
    reaverwps-t6x
    (airgeddon.override {
      supportHashCracking = true;
      supportEvilTwin = true;
    })
  ];

  # Make the proxychains config writeable on the fly
  system.activationScripts.proxychains = lib.mkAfter ''
    if [ ! -e /etc/proxychains.conf ]; then
      cp ${pkgs.proxychains-ng}/etc/proxychains.conf /etc/proxychains.conf
    fi
  '';

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
