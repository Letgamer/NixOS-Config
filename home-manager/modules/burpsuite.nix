{pkgs, ...}: {
  # Separate Community Edition for e.g. OSCP
  xdg.desktopEntries.burpsuitece = {
    name = "Burp Suite Community Edition";
    exec = "burpsuite --product-mode=community";
    icon = "burpsuite";
    genericName = "Web Application Security Testing Tool";
    categories = ["Development" "Security"];
  };

  programs.burp = {
    enable = true;
    proEdition = true;

    wordlists = {
      seclists = "${pkgs.seclists}/share/wordlists/seclists";
    };

    cliArgs = [
      "--suppress-jre-check"
      "--i-accept-the-license-agreement"
      "--disable-auto-update"
      "--disable-check-for-updates-dialog"
      "--temporary-project"
      "--unpause-spider-and-scanner"
    ];

    extensions = {
      # Loaded by default
      "403-bypasser".enable = true;
      "json-web-tokens".enable = true;
      "js-miner".enable = true;
      "param-miner".enable = true;

      # Installed but not loaded
      "http-request-smuggler" = {
        enable = true;
        loaded = false;
        settings = {
          "global.suite.deviceId" = "vyogc3mm6uedd3ntpi58";
        };
      };
      "pwnfox" = {
        enable = true;
        # Just fetch the JAR directly - no derivation needed!
        package = pkgs.fetchurl {
          url = "https://github.com/yeswehack/PwnFox/releases/download/v1.0.3/PwnFox.jar";
          hash = "sha256-7drvaK/5L9afUHSXgD+G3auXJ1FYJXMiSO1ELaCNlx4=";
        };
        extensiontype = "1";
      };
    };

    # Settings that are deep-merged into the default config
    settings = {
      display.user_interface = {
        # Enable Darkmode
        look_and_feel = "Dark";
        # Change Scaling
        font_size = "17";
      };
    };
  };
}
