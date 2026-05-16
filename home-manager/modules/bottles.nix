{
  pkgs,
  lib,
  ...
}: let
  bottleName = "default";
  envPath = lib.makeBinPath (
    with pkgs; [
      bottles
      jq
      coreutils
    ]
  );
  script = pkgs.writeShellScript "bottles-init" ''
    set -euo pipefail

    mkdir -p "$HOME/.local/share/bottles"

    if ! bottles-cli --json list bottles | jq -e 'has("${bottleName}")' >/dev/null; then
      echo "Creating bottle ${bottleName}"

      bottles-cli new \
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

      Environment = [
        "PATH=$PATH:${envPath}"
      ];

      ExecStart = "${script}";
    };
  };
}
