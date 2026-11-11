{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.generators) mkLuaInline;

  # Helpers to keep hl.bind() calls concise in Nix settings
  mkBind = keys: dispatcher: {
    _args = [
      (mkLuaInline keys)
      (mkLuaInline dispatcher)
    ];
  };

  mkBindFlags = keys: dispatcher: flags: {
    _args = [
      (mkLuaInline keys)
      (mkLuaInline dispatcher)
      flags
    ];
  };
in {
  wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;

    settings = {
      # Generates local Lua variables: local mainMod = "SUPER", etc.
      mainMod = {_var = "SUPER";};
      terminal = {_var = "ghostty +new-window";};
      fileManager = {_var = "nautilus";};
      menu = {_var = "hyprlauncher";};

      monitor = [
        {
          output = "HDMI-A-1";
          mode = "1920x1080@144";
          position = "0x40";
          scale = 1;
        }
        {
          output = "DP-3";
          mode = "2560x1440@164.96";
          position = "1920x0";
          scale = 1;
        }
      ];

      env = [
        {_args = ["HYPRCURSOR_THEME" "rose-pine-hyprcursor"];}
        {_args = ["HYPRCURSOR_SIZE" "24"];}
      ];

      # All general/section variables go inside hl.config({...})
      config = {
        general = {
          gaps_in = 2;
          gaps_out = 5;
          border_size = 2;
          resize_on_border = true;
        };

        decoration = {
          rounding = 10;
          active_opacity = 0.98;
          inactive_opacity = 0.8;
          blur = {
            size = 3;
          };
        };

        xwayland = {
          force_zero_scaling = true;
        };

        dwindle = {
          preserve_split = true;
        };

        input = {
          kb_layout = "de";
        };

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };

        misc = {
          disable_watchdog_warning = true;
          focus_on_activate = true;
        };
      };

      window_rule = [
        # Custom rules for the clipboard manager
        {
          match = {title = "com.clipse.clipse";};
          float = true;
          stay_focused = true;
          size = "(monitor_w*0.50) (monitor_h*0.65)";
        }
        # Custom Rules for Wiremix
        {
          match = {title = "com.wiremix.wiremix";};
          float = true;
          stay_focused = true;
          size = "(monitor_w*0.50) (monitor_h*0.25)";
        }
        # Custom Rules for Impala Iwd TUI
        {
          match = {title = "com.impala.impala";};
          float = true;
          stay_focused = true;
          size = "(monitor_w*0.65) (monitor_h*0.50)";
        }
        # Custom Rules for Bluetooth TUI
        {
          match = {title = "com.bluetui.bluetui";};
          float = true;
          stay_focused = true;
          size = "(monitor_w*0.65) (monitor_h*0.50)";
        }
        # Make File Picker floating
        {
          match = {class = "xdg-desktop-portal-gtk";};
          float = true;
          stay_focused = true;
          size = "(monitor_w*0.50) (monitor_h*0.50)";
        }
        # XWayland Fix
        {
          match = {
            class = "^$";
            title = "^$";
            xwayland = true;
            float = true;
            fullscreen = false;
            pin = false;
          };
          no_initial_focus = true;
          suppress_event = "activatefocus";
        }
        # Ignore maximize requests from all apps
        {
          match = {class = ".*";};
          suppress_event = "maximize";
        }
      ];

      curve = [
        {
          _args = [
            "easeOutQuint"
            {
              type = "bezier";
              points = [[0.23 1] [0.32 1]];
            }
          ];
        }
        {
          _args = [
            "easeInOutCubic"
            {
              type = "bezier";
              points = [[0.65 0.05] [0.36 1]];
            }
          ];
        }
        {
          _args = [
            "linear"
            {
              type = "bezier";
              points = [[0 0] [1 1]];
            }
          ];
        }
        {
          _args = [
            "almostLinear"
            {
              type = "bezier";
              points = [[0.5 0.5] [0.75 1.0]];
            }
          ];
        }
        {
          _args = [
            "quick"
            {
              type = "bezier";
              points = [[0.15 0] [0.1 1]];
            }
          ];
        }
      ];

      animation = [
        {
          leaf = "global";
          enabled = true;
          speed = 10;
          bezier = "default";
        }
        {
          leaf = "border";
          enabled = true;
          speed = 5.39;
          bezier = "easeOutQuint";
        }
        {
          leaf = "windows";
          enabled = true;
          speed = 4.79;
          bezier = "easeOutQuint";
        }
        {
          leaf = "windowsIn";
          enabled = true;
          speed = 4.1;
          bezier = "easeOutQuint";
          style = "popin 87%";
        }
        {
          leaf = "windowsOut";
          enabled = true;
          speed = 1.49;
          bezier = "linear";
          style = "popin 87%";
        }
        {
          leaf = "fadeIn";
          enabled = true;
          speed = 1.73;
          bezier = "almostLinear";
        }
        {
          leaf = "fadeOut";
          enabled = true;
          speed = 1.46;
          bezier = "almostLinear";
        }
        {
          leaf = "fade";
          enabled = true;
          speed = 3.03;
          bezier = "quick";
        }
        {
          leaf = "layers";
          enabled = true;
          speed = 3.81;
          bezier = "easeOutQuint";
        }
        {
          leaf = "layersIn";
          enabled = true;
          speed = 4;
          bezier = "easeOutQuint";
          style = "fade";
        }
        {
          leaf = "layersOut";
          enabled = true;
          speed = 1.5;
          bezier = "linear";
          style = "fade";
        }
        {
          leaf = "fadeLayersIn";
          enabled = true;
          speed = 1.79;
          bezier = "almostLinear";
        }
        {
          leaf = "fadeLayersOut";
          enabled = true;
          speed = 1.39;
          bezier = "almostLinear";
        }
      ];

      bind =
        [
          # bindel -> { locked = true; repeating = true; }
          (mkBindFlags ''"XF86AudioRaiseVolume"'' ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1 && osd volume")'' {
            locked = true;
            repeating = true;
          })
          (mkBindFlags ''"XF86AudioLowerVolume"'' ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && osd volume")'' {
            locked = true;
            repeating = true;
          })
          (mkBindFlags ''"XF86AudioMute"'' ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && osd volume")'' {locked = true;})
          (mkBindFlags ''"XF86MonBrightnessUp"'' ''hl.dsp.exec_cmd("brightnessctl s 10%+ && osd brightness")'' {
            locked = true;
            repeating = true;
          })
          (mkBindFlags ''"XF86MonBrightnessDown"'' ''hl.dsp.exec_cmd("brightnessctl s 10%- && osd brightness")'' {
            locked = true;
            repeating = true;
          })

          # bindl -> { locked = true; }
          (mkBindFlags ''"XF86AudioNext"'' ''hl.dsp.exec_cmd("playerctl next")'' {locked = true;})
          (mkBindFlags ''"XF86AudioPause"'' ''hl.dsp.exec_cmd("playerctl play-pause")'' {locked = true;})
          (mkBindFlags ''"XF86AudioPlay"'' ''hl.dsp.exec_cmd("playerctl play-pause")'' {locked = true;})
          (mkBindFlags ''"XF86AudioPrev"'' ''hl.dsp.exec_cmd("playerctl previous")'' {locked = true;})

          # Standard binds
          (mkBind ''mainMod .. " + L"'' ''hl.dsp.exec_cmd("loginctl lock-session && ${pkgs.systemd}/bin/systemctl --user stop eye-break.timer")'')
          (mkBind ''mainMod .. " + X"'' ''hl.dsp.exec_cmd(terminal .. " --confirm-close-surface=false --title=com.clipse.clipse -e clipse")'')
          (mkBind ''mainMod .. " + Y"'' ''hl.dsp.exec_cmd("nmcli device status | grep -E 'tun|vpn' | awk '{print $1}' | xargs -I {} nmcli -t -f IP4.ADDRESS device show {} | cut -d: -f2 | cut -d/ -f1 | wl-copy -n")'')
          (mkBind ''mainMod .. " + Q"'' ''hl.dsp.exec_cmd(terminal)'')
          (mkBind ''mainMod .. " + C"'' ''hl.dsp.window.close()'')
          (mkBind ''mainMod .. " + ALT + C"'' ''hl.dsp.window.kill()'')
          (mkBind ''mainMod .. " + E"'' ''hl.dsp.exec_cmd(fileManager)'')
          (mkBind ''mainMod .. " + V"'' ''hl.dsp.window.float()'')
          (mkBind ''mainMod .. " + SPACE"'' ''hl.dsp.exec_cmd(menu)'')
          (mkBind ''mainMod .. " + P"'' ''hl.dsp.window.pseudo()'')
          (mkBind ''mainMod .. " + I"'' ''hl.dsp.exec_cmd("hypridle-toggle")'')
          (mkBind ''mainMod .. " + J"'' ''hl.dsp.layout("togglesplit")'')
          (mkBind ''mainMod .. " + F"'' ''hl.dsp.window.fullscreen()'')
          (mkBind ''mainMod .. " + SHIFT + C"'' ''hl.dsp.exec_cmd("hyprpicker -a")'')

          # Move focus with mainMod + arrow keys
          (mkBind ''mainMod .. " + left"'' ''hl.dsp.focus({ direction = "left" })'')
          (mkBind ''mainMod .. " + right"'' ''hl.dsp.focus({ direction = "right" })'')
          (mkBind ''mainMod .. " + up"'' ''hl.dsp.focus({ direction = "up" })'')
          (mkBind ''mainMod .. " + down"'' ''hl.dsp.focus({ direction = "down" })'')

          # Toggle scratchpad
          (mkBind ''mainMod .. " + S"'' ''hl.dsp.workspace.toggle_special("magic")'')
          (mkBind ''mainMod .. " + SHIFT + S"'' ''hl.dsp.window.move({ workspace = "special:magic" })'')

          # SCREENSHOT
          (mkBind ''"Print"'' ''hl.dsp.exec_cmd("env HOME=$HOME/Pictures grimblast --notify --freeze copysave area")'')
          (mkBind ''"CTRL + Print"'' ''hl.dsp.exec_cmd("env HOME=$HOME/Pictures grimblast --notify --freeze copysave output")'')
          (mkBind ''"ALT + Print"'' ''hl.dsp.exec_cmd("env HOME=$HOME/Pictures grimblast --notify --freeze copysave screen")'')

          # Scroll through existing workspaces with mainMod + scroll
          (mkBind ''mainMod .. " + mouse_down"'' ''hl.dsp.focus({ workspace = "e+1" })'')
          (mkBind ''mainMod .. " + mouse_up"'' ''hl.dsp.focus({ workspace = "e-1" })'')

          # bindm -> { mouse = true; }
          (mkBindFlags ''mainMod .. " + mouse:272"'' ''hl.dsp.window.drag()'' {mouse = true;})
          (mkBindFlags ''mainMod .. " + mouse:273"'' ''hl.dsp.window.resize()'' {mouse = true;})
        ]
        ++ (builtins.concatLists (
          builtins.genList (
            x: let
              ws = toString (x + 1);
            in [
              (mkBind ''mainMod .. " + ${ws}"'' ''hl.dsp.focus({ workspace = "${ws}" })'')
              (mkBind ''mainMod .. " + SHIFT + ${ws}"'' ''hl.dsp.window.move({ workspace = "${ws}" })'')
              (mkBind ''mainMod .. " + CTRL + ${ws}"'' ''hl.dsp.window.move({ workspace = "${ws}", follow = false })'')
            ]
          )
          9
        ));
    };
  };
}
