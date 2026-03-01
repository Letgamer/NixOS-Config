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
    inputs.fufexan-dotfiles.packages."x86_64-linux".bibata-hyprcursor
    # https://github.com/emersion/mako/wiki/Volume-change-notification
    (pkgs.writeShellScriptBin "osd" ''
      #!${lib.getExe pkgs.bash}

      mode="$1"  # "volume" or "brightness"

      case "$mode" in
        volume)
          volume_info=$(${lib.getExe' pkgs.wireplumber "wpctl"} get-volume @DEFAULT_AUDIO_SINK@)
          if [[ "$volume_info" == *"[MUTED]" ]]; then
              text="Muted"
              value=0
          else
              value=$(awk '{print int($2 * 100)}' <<< "$volume_info")
              text="Volume"
          fi
          ;;
        brightness)
          current=$(${lib.getExe pkgs.brightnessctl} g)
          max=$(${lib.getExe pkgs.brightnessctl} m)
          value=$(( current * 100 / max ))
          text="Brightness"
          ;;
        *)
          echo "Usage: $0 {volume|brightness}" >&2
          exit 1
          ;;
      esac

      ${lib.getExe pkgs.libnotify} -t 1000 \
        -a "osd" \
        -h string:x-canonical-private-synchronous:"$mode" \
        -h int:value:$value \
        "$text $value%"
    '')
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

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Classic";
    size = 24;

    hyprcursor.enable = true;
    gtk.enable = true;
    x11.enable = true;
  };

  # https://home-manager-options.extranix.com/?query=mako&release=release-25.11
  # Configure Volume and Brightness Notification https://github.com/emersion/mako/wiki/Volume-change-notification
  services.mako = {
    enable = true;
    settings = {
      border-radius = 10;

      # Volume notification rule
      "app-name=osd" = {
        layer = "overlay";
        history = 0;
        anchor = "top-center";
        group-by = "app-name";
        format = "<b>%s</b>\\n%b";
      };

      # Only show latest grouped notification
      "app-name=osd group-index=0" = {
        invisible = 0;
      };
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

  # https://home-manager-options.extranix.com/?query=udiskie&release=release-25.11
  # TODO: System Tray Waybar integration
  services.udiskie.enable = true;

  # hyprpolkitagent is a polkit authentication daemon. It is required for GUI applications to be able to request elevated privileges.
  services.hyprpolkitagent.enable = true;

  # Set a default target for systemd graphics sessions
  wayland.systemd.target = "hyprland-session.target";
}
