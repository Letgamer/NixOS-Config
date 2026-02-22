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
    wl-clipboard
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
  '';

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

  # https://home-manager-options.extranix.com/?query=swaync&release=release-25.11
  services.swaync = {
    enable = true;
  };

  # https://home-manager-options.extranix.com/?query=hyprlock&release=release-25.11
  # TODO: test hyprlock config, as it just blackscreens using Qemu
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

      input-field = {
        monitor = "";
        size = "250, 60";
        outline_thickness = 2;

        dots_size = 0.2;
        dots_spacing = 0.35;
        dots_center = true;

        fade_on_empty = false;
        rounding = -1;

        placeholder_text = "<i><span foreground=\"#cdd6f4\">Input Password...</span></i>";

        hide_input = false;

        position = "0, -200";
        halign = "center";
        valign = "center";
      };

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%-I:%M\")\"";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 95;
          font_family = "JetBrains Mono Extrabold";

          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  # https://home-manager-options.extranix.com/?query=hyprshot&release=release-25.11
  programs.hyprshot = {
    enable = true;
    saveLocation = "$HOME/Pictures/Screenshots";
  };

  # https://home-manager-options.extranix.com/?query=clipse&release=release-25.11
  services.clipse = {
    enable = true;
  };

  # https://home-manager-options.extranix.com/?query=hypridle&release=release-25.11
  services.hypridle = {
    enable = true;
  };

  # hyprpolkitagent is a polkit authentication daemon. It is required for GUI applications to be able to request elevated privileges.
  services.hyprpolkitagent.enable = true;

  # Set a default target for systemd graphics sessions
  wayland.systemd.target = "hyprland-session.target";
}
