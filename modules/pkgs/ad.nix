{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    unstable.bloodhound-ce
  ];
}
