{
  lib,
  pkgs,
  ...
}: let
  mkDistrobox = {
    name,
    image,
    bootstrapScript,
  }: let
    bootstrap =
      pkgs.writeShellScript "distrobox-${name}-bootstrap"
      (builtins.readFile bootstrapScript);

    script = pkgs.writeShellScript "distrobox-${name}-init" ''
      set -euo pipefail

      if ! ${lib.getExe pkgs.podman} container exists ${name}; then
        ${lib.getExe pkgs.distrobox} create \
          --name ${name} \
          --image ${image} \
          --init-hooks "${bootstrap}" \
          --yes
      fi
    '';
  in {
    systemd.user.services."distrobox-${name}" = {
      Unit = {
        Description = "Distrobox ${name}";
        After = ["podman.socket"];
        Wants = ["podman.socket"];
      };

      Install = {
        WantedBy = ["default.target"];
      };

      Service = {
        Type = "oneshot";

        ExecStart = "${script}";
      };
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
