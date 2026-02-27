{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";

  programs.ssh.startAgent = true;
}
