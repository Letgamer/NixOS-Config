{
  lib,
  pkgs,
  ...
}: let
  mkDistrobox = {
    name,
    image,
    bootstrapScript,
  }: {
    systemd.user.services."distrobox-${name}" = {
      wantedBy = ["default.target"];

      after = ["podman.socket"];
      wants = ["podman.socket"];

      serviceConfig = {
        Type = "oneshot";
      };

      script = ''
        if ! ${pkgs.podman}/bin/podman container exists ${name}; then
          ${pkgs.distrobox}/bin/distrobox create \
            --name ${name} \
            --image ${image} \
            --volume ${bootstrapScript}:/bootstrap.sh:ro \
            --yes
        fi

        if ! ${pkgs.distrobox}/bin/distrobox enter ${name} -- test -f /var/tmp/bootstrap-complete; then
          ${pkgs.distrobox}/bin/distrobox enter ${name} -- bash /bootstrap.sh
        fi
      '';
    };
  };
in
  lib.mkMerge [
    (mkDistrobox {
      name = "kali";
      image = "docker.io/kalilinux/kali-rolling:latest";
      bootstrapScript = ./bootstrap/kali.sh;
    })
    (mkDistrobox {
      name = "arch";
      image = "docker.io/library/archlinux:latest";
      bootstrapScript = ./bootstrap/arch.sh;
    })
  ]
