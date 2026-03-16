{
  # https://home-manager-options.extranix.com/?query=waybar&release=release-25.11
  programs.waybar = {
    enable = true;
    # Enabling waybar systemd target
    systemd.enable = true;
    
    settings = [
      {
        layer = "top";
        height = 0;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ 
          "wireplumber#source"
          "wireplumber#sink"
          "bluetooth"
          "network"
          "custom/vpn-ip"
          "power-profiles-daemon"
          "battery"
          "clock"
          "custom/power"
        ];

        "hyprland/workspaces" = {
          format = "{icon} {windows}";
          window-rewrite-default = "";
          window-rewrite = {
            "class<firefox>" = "";
            "class<code>" = "󰨞";
            "class<spotify>" = "";
            "class<discord>" = "";
          };
        };

        "hyprland/window" = {
          "max-length" = 50;
        };

        "wireplumber#source" = {
          node-type = "Audio/Source";
          format = "{volume}% ";
          format-muted = "";
          scroll-step = 5;
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          on-click-right = "ghostty --confirm-close-surface=false --class=com.wiremix.wiremix -e wiremix --tab input";
        };

        "wireplumber#sink" = {
          node-type = "Audio/Sink";
          format = "{volume}% {icon}";
          format-muted = "";
          format-icons = [ "" "" "" ];
          scroll-step = 5;
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-right = "ghostty --confirm-close-surface=false --class=com.wiremix.wiremix -e wiremix --tab output";
        };

        power-profiles-daemon = {
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };

        bluetooth = {
          format = "";
          format-off = "󰂲";
          format-connected = "󰂰";
          on-click = "ghostty --confirm-close-surface=false --class=com.bluetui.bluetui -e bluetui";
        };
        
        network = {
          format-wifi = "";
          format-ethernet = "󰈀";
          format-disconnected = "󰖪";
          on-click-right = "ip -4 addr show $(ip -4 route show default | awk '{print $5; exit}') | awk '/inet / {print $2}' | cut -d/ -f1 | wl-copy -n";
          on-click = "ghostty --confirm-close-surface=false --class=com.impala.impala -e impala";
        };

        "custom/vpn-ip"= {
          exec = "nmcli device status | grep -E 'tun|vpn' | awk '{print $1}' | xargs -I {} nmcli -t -f IP4.ADDRESS device show {} | cut -d: -f2 | cut -d/ -f1";
          return-type = "text";
          interval = 15;
          format = " {text}";
          on-click = "nmcli device status | grep -E 'tun|vpn' | awk '{print $1}' | xargs -I {} nmcli -t -f IP4.ADDRESS device show {} | cut -d: -f2 | cut -d/ -f1 | wl-copy -n";
          format-disconnected = "";
          format-disabled = "";
        };

        battery = {
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
          states = {
            warning = 30;
            critical = 15;
          };
          format-charging = "{capacity}% ";
          format-alt = "{time} {icon}";
        };

        clock = {
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          format-alt = "{:%d.%m.%Y}";
        };

        "custom/power" = {
          format = "⏻ ";
          tooltip = false;
          on-click = "systemctl poweroff";
          on-click-right = "systemctl suspend";
        };
      }
    ];

    style = ''
    '';
  };
}
