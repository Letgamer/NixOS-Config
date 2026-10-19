{pkgs, username, ...}: {
  virtualisation = {
    containers = {
      enable = true;
      # To avoid the 8 GB impermanence limit for big builds
      containersConf.settings = {
        engine = {
          env = [
            "TMPDIR=/home/${username}/.local/share/containers/tmp"
          ];
        };
      };
    };
    podman = {
      enable = true;

      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.

      # cleanup unused images/containers automatically
      autoPrune = {
        enable = true;
        flags = ["--all"];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    podman-compose
    distrobox
  ];
}
