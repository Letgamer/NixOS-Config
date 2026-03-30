{
  wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;

    settings = {

      monitor = ",preferred,auto,2";

      "$mainMod" = "SUPER";
      "$terminal" = "ghostty +new-window";
      "$fileManager" = "nautilus";
      "$menu" = "hyprlauncher";

      env = [
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        # See https://github.com/hyprwm/contrib/issues/142
        "GRIMBLAST_NO_CURSOR,0"
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        "HYPRCURSOR_SIZE,24"
      ];

      exec-once = [
        "hyprctl setcursor rose-pine-hyprcursor 24"
      ];

      general = {
        gaps_in = 2;
        gaps_out = 5;

        border_size = 2;

        resize_on_border = true;
      };

      decoration = {
        rounding = 10;

        active_opacity = 0.93;
        inactive_opacity = 0.7;

        blur = {
          size = 3;
        };
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      input = {
        kb_layout = "de";
      };

      # TODO: enable and set permissions:
      # https://wiki.hypr.land/Configuring/Variables/#ecosystem
      # https://wiki.hypr.land/Configuring/Permissions/
      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      misc = {
        disable_watchdog_warning = true;
        focus_on_activate = true;
      };

      windowrule = [
        # Custom rules for the clipboard manager
        "match:class com.clipse.clipse, float on, stay_focused on, size (monitor_w*0.50) (monitor_h*0.65)"
        # Custom Rules for Wiremix
        "match:class com.wiremix.wiremix, float on, stay_focused on, size (monitor_w*0.50) (monitor_h*0.25)"
        # Custom Rules for Impala Iwd TUI
        "match:class com.gazelle.gazelle, float on, stay_focused on, size (monitor_w*0.65) (monitor_h*0.50)"
        # Custom Rules for Bluetooth TUI
        "match:class com.bluetui.bluetui, float on, stay_focused on, size (monitor_w*0.65) (monitor_h*0.50)"
        # XWayland Fix
        "match:class ^$, match:title ^$, match:xwayland true, match:float true, match:fullscreen false, match:pin false, no_initial_focus on, suppress_event activatefocus"
        # Ignore maximize requests from all apps
        "match:class = .*, suppress_event = maximize"
      ];

      animations = {
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
        ];
      };

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1 && osd volume"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && osd volume"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && osd volume"
        ", XF86MonBrightnessUp, exec, brightnessctl s 10%+ && osd brightness"
        ", XF86MonBrightnessDown, exec, brightnessctl s 10%- && osd brightness"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      bind = [
        # Control L --> lock
        "CONTROL, L, exec, loginctl lock-session"

        "$mainMod, X, exec, $terminal --confirm-close-surface=false --class=com.clipse.clipse -e clipse"
        "$mainMod, Y, exec, nmcli device status | grep -E 'tun|vpn' | awk '{print $1}' | xargs -I {} nmcli -t -f IP4.ADDRESS device show {} | cut -d: -f2 | cut -d/ -f1 | wl-copy -n"
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating"
        "$mainMod, SPACE, exec, $menu"
        "$mainMod, P, pseudo"
        "$mainMod, J, layoutmsg, togglesplit"
        "$mainMod, F, fullscreen"
        "$mainMod+SHIFT, C, exec, hyprpicker -a"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Toggle scratchpad
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod+SHIFT, S, movetoworkspace, special:magic"

        # SCREENSHOT
        # area
        ", Print, exec, env HOME=$HOME/Pictures grimblast --notify --freeze copysave area"
        # current screen
        "CTRL, Print, exec, env HOME=$HOME/Pictures grimblast --notify --freeze copysave output"
        # all screens
        "ALT, Print, exec, env HOME=$HOME/Pictures grimblast --notify --freeze copysave screen"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          x:
          let
            ws = toString (x + 1);
          in
          [
            "$mainMod, ${ws}, workspace, ${ws}"
            "$mainMod SHIFT, ${ws}, movetoworkspace, ${ws}"
            "$mainMod CTRL, ${ws}, movetoworkspacesilent, ${ws}"
          ]
        ) 9
      ));

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
