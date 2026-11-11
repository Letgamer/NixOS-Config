{username, ...}: {
  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # enable x11 legacy support
  };

  security.pam.services.hyprlock = {};

  services.udisks2.enable = true;

  services.dbus.implementation = "broker";

  environment.sessionVariables = {
    UWSM_SILENT_START = "2";
  };

  # Auto startup of hyprland via greetd -> uwsm -> h<prland
  services.greetd = {
    enable = true;
    settings = {
      general.source_profile = false;
      initial_session = {
        command = "uwsm start -g -1 hyprland-uwsm.desktop";
        user = "${username}";
      };
      default_session = {
        # If Hyprland dies, just start it again automatically
        command = "uwsm start hyprland-uwsm.desktop";
        user = "${username}";
      };
    };
  };

  systemd.services.greetd = {
    # Keep Bootvine on tty12 until all standard system services have finished starting
    after = ["multi-user.target"];

    serviceConfig = {
      # Silence any systemd/PAM status messages on tty1
      StandardInput = "tty";
      StandardOutput = "null";
      StandardError = "journal";
      TTYPath = "/dev/tty1";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };

  systemd.services.greetd-secondary-monitor = {
    description = "Toggle HDMI-A-1 DRM state alongside greetd";

    # Tie lifecycle directly to greetd
    wantedBy = ["greetd.service"];
    bindsTo = ["greetd.service"];

    # Start right before greetd, which means it stops right AFTER greetd
    after = ["systemd-user-sessions.service" "getty@tty1.service"];

    # NixOS compiles these into clean store scripts for ExecStart and ExecStop
    script = ''
      echo on > /sys/class/drm/card0-HDMI-A-1/status
    '';

    preStop = ''
      echo off > /sys/class/drm/card0-HDMI-A-1/status
    '';

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };
}
