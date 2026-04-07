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

    preferences = {
      "tzsHZ2uQ7Xvf8uXB4fnyGw==" = "rbojo9jt6ZB24ppIimQBtN4Y24Wx/sDLu/1UHojAHR0ii0gwtVQrnzmwiUlc8jwHn6hGm/+rSjKeVS5JBWfOpqVwVLteP8dUvlNIppaotVUzBnQzljo2tLi6rWPoc7aQX47wj0B2FHQv3PRSFLMtXxPhgtokvNxL1Jy72u8C/dEK74o3pfzzxF1MXF68RA4+31LAA5Y4iMRq9yh8n0K5NJM15iAar5dYcWR71cEmAejcViLkM3ynUKZO/aUNy9cCk8qqbNpMP/7HWHCTBT2L1DIaB8+SGxwIy8Zi7QXl4aAm4KSnvXtWs+SomRul8KYfqyXjdKyWsE4NDxAxkCbhGzGKeJ3wDdSIv8jtOyLiKSg3JFuwgucuZze5cAfTegkHjsDiFlfp7JQTkH4AodusVWYLj8fxI4mgv1UQPwWvrOol3XJ9UNdIWYOGL/1yqujAl1eEEx/qaiMFC0lB7PgWCArh+hOa0DoeElTfOncoOT4CYk0/gdNeBBCh8+cAhWAVoaUeRCSZnaj2hKjv0x7lTSxe9ZBprD1eUVV0oi9D/p6gae+J+cmTX1dZ02pu/ML3+nHfubjjZX/Z4a3Itl2xeguE7DZyTRwxVUBtXXy8uO0F2M8XqhijuaIwABvtFDOkmoR6UyhkSMTXLHFiR1aSrpJz2BFfFJ1WKAx28FBLO9vI6tWwqzlIC2aS9KXwgAWeUpibCW9jY0yvz8pKwmvKruEWKsdI2QzQ55ww0BZwHIHgSDfJkLvx/zKleQRm8QpDj7i0p2N5cIGPaohm7HiDNzIoV7YcJzIpIQrrAMSlXevThicn7r+dXNYMOwAfLjS71tzwq9oYVckqp0nl6gbGyw==";
    };

    license = "vMSW1CwQe66w4Rf1YgqHTv5i7C/u1RjfV9O3ZT55xwGvYAn2zh0uJq9gCfbOHS4mVlbyb7O0fZyFaQcK+3ebZC29Goqrc80aBZR6BQBSNDv52+Jj0f7ZfnzG7ZpnktmX4I0P6f/DcLBEIJ6FSkuJfm5eheOM/xr2Z1hMv7KG35Y16PVjtRuWVfF53QHD5NZaAqexCmRCtZ2/UGTnzsen3LcWNNVb1eWH1uEPcQpVV+LUcGjaDT5mPbYv2RgR6VQFqv/EDPznI4CTRsW309iSfAPUjIqOgNqrOAEO5df8F9zPzwqb4QEyKegEPhnuYmTXCwJc4Q7tj6i4Kk4TgkQm/sydN1nAl6i1jOAE15Bk1Ht/FZuVqEA5p7c8GEiVw4Ge7gJJXijV7elN4TJ2uM23+B8f+87OrOlhGeXmlhbz/glZgADDgllILWXf4kSMqdDuzvdU93esIKDJCODhTel3kHG0d7ZzsNCDt/5SW7SHAvuNFvYuwLDpLLuZcgnVF9iMxJpTlFEsjO2gYL2y92xjtq3sq3hksotq/dd/e1/ET8Bk+wzGrMiuEMjFeiqWvqHlLvLYpXroVseLWba5fEMMA8xwsWj5PkPj0/MHJRgAzFsjlq4oNdblYtmtW92VaMb0RLW+mIfHFoc33Klm1GiGo0eik7I/5j7bgzDn5HhuuVotP0Mn2uXFJ+/sfB926sRRUkYH2n2UxhqzMKROfzcUpg1dz1+m0sV3chEcmYdhYPbL4ThZy3WEuVWXEKLx5DVX5+1zPYsScfXF0i+Qgqy/U9Q5LPd7cJPLOM3Dwqf1TY4=";

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
