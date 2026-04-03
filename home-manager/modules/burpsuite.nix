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
