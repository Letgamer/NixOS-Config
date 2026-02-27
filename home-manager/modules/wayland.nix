{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  ...
}:
let
  c = config.lib.stylix.colors;
  hex = color: "0xFF${color}";
in
{
  home.packages = with pkgs; [
    kitty
    nautilus
    clipse
    brightnessctl
    playerctl
    hyprlauncher
    hyprpicker
    wl-clipboard
    libnotify
    grimblast
  ];

  # Needed for Hyprpicker and hyprpolkitagent, TODO: upstream to stylix
  # https://wiki.hypr.land/Hypr-Ecosystem/hyprtoolkit/
  # https://wiki.hypr.land/Hypr-Ecosystem/hyprlauncher/
  #
  home.file.".config/hypr/hyprtoolkit.conf".text = ''
    background = ${hex c.base00}
    base = ${hex c.base01}
    alternate_base = ${hex c.base02}
    text = ${hex c.base05}
    bright_text = ${hex c.base06}
    accent = ${hex c.base0D}
    accent_secondary = ${hex c.base0E}
  '';

  home.file.".config/uwsm/env".text = ''
    export HYPRLAND_WM=hyprland
    export NIXOS_OZONE_WL=1
    export ELECTRON_OZONE_PLATFORM_HINT=wayland
    export MOZ_ENABLE_WAYLAND=1
    export OZONE_PLATFORM=wayland
    export EGL_PLATFORM=wayland
    export CLUTTER_BACKEND=wayland
    export SDL_VIDEODRIVER=wayland
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export QT_ENABLE_HIGHDPI_SCALING=1
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export QT_QPA_PLATFORM=wayland
    export QT_QPA_PLATFORMTHEME=qt6ct
    export _JAVA_AWT_WM_NONREPARENTING=1
    export GRIMBLAST_NO_CURSOR=0
  '';
  # https://github.com/hyprwm/contrib/issues/142 GRIMBLAST

  home.file.".config/uwsm/env-hyprland".text = ''
    export WLR_RENDERER_ALLOW_SOFTWARE=1
  '';

  # Deploy the image to ~/.wallpapers
  home.file.".config/backgrounds/mountains.png".source = ./wallpapers/mountains.png;

  # https://home-manager-options.extranix.com/?query=hyprpaper&release=release-25.11
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "~/.config/backgrounds/mountains.png";
      wallpaper = ", ~/.config/backgrounds/mountains.png";
    };
  };

  # https://home-manager-options.extranix.com/?query=mako&release=release-25.11
  services.mako = {
    enable = true;
    settings = {
      border-radius = 10;
    };
  };

  # https://home-manager-options.extranix.com/?query=hyprlock&release=release-25.11
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };

      background = {
        monitor = "";
        path = "~/.config/backgrounds/mountains.png";
        blur_passes = 2;
      };

      # Time
      label = {
        monitor = "";
        text = "$TIME";
        font_size = 100;
        font_family = "JetBrains Mono Extrabold";
        position = "0, 20%";
      };

      input-field = {
        monitor = "";
        size = "11%, 4%";

        dots_size = 0.2;
        dots_spacing = 0.35;

        fade_on_empty = false;

        placeholder_text = "Input Password...";

        position = "0, -10%";
      };
    };
  };

  # https://home-manager-options.extranix.com/?query=hypridle&release=release-25.11
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        # 5 min – Lock session
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        # 10 min – Dim screen
        {
          timeout = 600;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        # 30 min – Suspend
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  # https://home-manager-options.extranix.com/?query=clipse&release=release-25.11
  services.clipse = {
    enable = true;
  };

  # hyprpolkitagent is a polkit authentication daemon. It is required for GUI applications to be able to request elevated privileges.
  services.hyprpolkitagent.enable = true;

  # Set a default target for systemd graphics sessions
  wayland.systemd.target = "hyprland-session.target";
}
