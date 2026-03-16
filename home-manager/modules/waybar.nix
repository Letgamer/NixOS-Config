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
          format = "⏻";
          tooltip = false;
          on-click = "systemctl poweroff";
          on-click-right = "systemctl suspend";
        };
      }
    ];

    style = ''
    /* This styles Waybar generally */
    window#waybar {
      background-color: transparent;
      color: @base05;
    }

    /* Rounded containers for each module */
    .module {
      background-color: @base00;
      min-width:  15px;
      margin-top: 4px;
      margin-left: 1px;
      margin-right: 1px;
      padding-left: 10px;
      padding-right: 10px;
      border-radius: 12px;
      border: 2px solid @base0D;
    }
    .module:last-child {
      margin-right: 4px;
    }
    .module:first-child {
      margin-right: 4px;
    }

    /* Module Settings */
    #network,
    #battery,
    #wireplumber {
      padding-right: 15px;
    }
    #network,
    #power-profiles-daemon,
    #bluetooth {
      font-size: 18px;
    }
    #power-profiles-daemon {
      padding-right: 5px;
      padding-left: 5px;
    }
    /* Hide empty bar */
    window#waybar.empty #window {
      background: none;
      border: none;
    }

    /* Battery visual settings */
    #battery.full{
      color: @base0B;
    }
    #battery.charging,
    #battery.plugged .text {
      animation: blink 5s infinite alternate;
    }
    #battery.warning:not(.charging) {
      color: @base09;
    }
    #battery.critical:not(.charging) .text {
      color: @base08;
      animation: blink 1s infinite alternate;
    }
    #battery.critical:not(.charging) {
      border-color: @base08;
    }
    @keyframes blink {
      0% { opacity: 1; }
      100% { opacity: 0.2; }
    }

    /* Workspace visual settings */
    #workspaces {
      padding-left: 0;
      padding-right: 0;
    }
    .modules-left #workspaces button.focused,
    .modules-left #workspaces button.active {
      border-bottom: 1px solid @base0D;
      border: 1px solid @base0D;
    }
    '';
  };
}
