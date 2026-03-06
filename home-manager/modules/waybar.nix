{
  # https://home-manager-options.extranix.com/?query=waybar&release=release-25.11
  programs.waybar = {
    enable = true;
    # Enabling waybar systemd target
    systemd.enable = true;
    
    settings = {
      mainBar = {
        layer = "top";
        height = 0;
        spacing = 4;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ 
          "pulseaudio#sink"
          "pulseaudio#source"
          "power-profiles-daemon"
          "clock"
          "tray"
          "battery"
          "backlight"
        ];

        "hyprland/window" = {
          "max-length" = 50;
        };

        battery = {
          format = "{capacity}% {icon}";
          "format-icons" = ["" "" "" "" ""];
        };

        clock = {
          "format-alt" = "{:%a, %d. %b  %H:%M}";
        };
      };
    };
  };
}
