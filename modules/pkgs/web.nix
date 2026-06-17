{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    apachetomcatscanner

    # Bruteforce tools
    feroxbuster
    ffuf
    gobuster
    wfuzz

    # CMS
    joomscan
    joomscan
    wpscan

    # Injection tools
    commix
    sqlmap

    # Other web / recon tools
    davtest
    eyewitness
    jwt-hack
    nikto
    python314Packages.wsgidav
    wafw00f
    whatweb
  ];
}
