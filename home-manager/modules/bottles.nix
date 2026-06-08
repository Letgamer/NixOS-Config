{
  pkgs,
  lib,
  ...
}: let
  bottleName = "default";
  # This currently only works after the first run of bottles, which creates the necessary directories and downloads some files.
  # https://github.com/bottlesdevs/Bottles/issues/4539
  script = pkgs.writeShellScript "bottles-init" ''
    set -euo pipefail

    if [ ! -d "$HOME/.local/share/bottles" ]; then
      exit 0
    fi

    if ! ${lib.getExe' pkgs.unstable.bottles "bottles-cli"} --json list bottles | ${lib.getExe pkgs.jq} -e 'has("${bottleName}")' >/dev/null; then
      echo "Creating bottle ${bottleName}"

      ${lib.getExe' pkgs.unstable.bottles "bottles-cli"} new \
        --bottle-name "${bottleName}" \
        --environment application \
        --arch win64
    fi
  '';
in {
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
