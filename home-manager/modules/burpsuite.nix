{
  pkgs,
  inputs,
  ...
}: {
  programs.burp = {
    enable = true;
    proEdition = true;
    package = inputs.burpsuitepro.packages.${pkgs.stdenv.hostPlatform.system}.default;

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

    extensions = [
      # Loaded by default
      "403-bypasser"
      "json-web-tokens"
      "js-miner"
      "param-miner"

      # Installed but not loaded
      {
        package = "http-request-smuggler";
        loaded = false;
      }
    ];

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
