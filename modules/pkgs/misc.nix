{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    exploitdb
    git-dumper
    metasploit
    snyk
  ];
}
