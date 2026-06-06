{
  pkgs,
  lib,
  ...
}: let
  bottleName = "default";
  script = pkgs.writeShellScript "bottles-init" ''
    set -euo pipefail

    mkdir -p "$HOME/.local/share/bottles"

    if ! ${lib.getExe' pkgs.master.bottles "bottles-cli"} --json list bottles | ${lib.getExe pkgs.jq} -e 'has("${bottleName}")' >/dev/null; then
      echo "Creating bottle ${bottleName}"

      ${lib.getExe' pkgs.master.bottles "bottles-cli"} new \
        --bottle-name "${bottleName}" \
        --environment application \
        --arch win64
    fi
  '';
in {
  # This currently only works after the first run of bottles, which creates the necessary directories and downloads some files.
  # https://github.com/bottlesdevs/Bottles/issues/4539
  systemd.user.services.bottles-init = {
    Unit = {
      Description = "Declaratively configure Bottles";
      After = ["bottles.service"];
    };

    Install = {
      WantedBy = ["default.target"];
    };

    Service = {
      Type = "oneshot";

      ExecStart = "${script}";
    };
  };
}
