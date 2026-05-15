{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    python2Full
    python3
    uv
  ];
}
