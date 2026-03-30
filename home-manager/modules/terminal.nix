{
  pkgs,
  lib,
  config,
  ...
}:
let
  c = config.lib.stylix.colors.withHashtag;
in
{
  home.shell.enableShellIntegration = true;
  home.shell.enableZshIntegration = true;

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    systemd.enable = true;
    settings = {
      shell-integration = "zsh";
      command = "${lib.getExe pkgs.zsh}";
      shell-integration-features = "ssh-env";
      right-click-action = "copy-or-paste";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    history = {
      append = true;
      share = true;
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      findNoDups = true;
      saveNoDups = true;
      save = 1000000;
      size = 1000000;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "extract"
      ];
    };
    shellAliases = {
      cat = "bat";
      pcat = "command cat";

      bman = "batman";
      bdiff = "batdiff";
      bgrep = "batgrep";
      bwatch = "batwatch";

      top = "btop";
      vscode = "code .";
      code = "code .";

      # Misc
      ".." = "cd ..";
      mkdir = "mkdir -p";
      mk = "() { mkdir -p -- '$1' && cd -- '$1'; };";
      cpwd = "pwd | wl-copy -n";
      cfp = "(){ readlink -f '$1' | wl-copy -n; }";
      serve = "python3 -m http.server \${1:-8000}";
      tempe = "cd '$(mktemp -d)' && chmod -R 0700 .";
    };
    shellGlobalAliases = {
      copy = "wl-copy -n";
      pasta = "wl-paste -n";
      urlencode = "python3 -c 'import urllib.parse, sys; print(urllib.parse.quote(sys.stdin.read().strip()))'";
      urldecode = "python3 -c 'import urllib.parse, sys; print(urllib.parse.unquote(sys.stdin.read().strip()))'";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # TODO: Test Python, Venv and vpnip module!
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
        "[░▒▓](${c.base0D})"
        "[  ](bg:${c.base0D} fg:${c.base00}) "
        "$directory "
        "$git_branch "
        "$git_status "
        "$rust "
        "$python "
        "$nodejs "
        "$golang "
        "$php "
        "$ruby "
        "$java "
        "$fill"
        "\${custom.venv}"
        "\${custom.vpn}"
        "$nix_shell"
        "$line_break"
        "$character"
      ];
      right_format = lib.concatStrings [ 
        "$time  "];
      time = {
        disabled = false;
        time_format = "%T"; # HH:MM:SS
        format = "[ $time](${c.base05})";
      };
      nix_shell = {
        format = "[$state $name](bold blue) ";
        impure_msg = "❄️";
        pure_msg = "";
        heuristic = true;
      };
      python = {
        format = "[\${version}]($style)";
      };
      # Virtual environment (right side)
      custom.venv = {
        command = "basename \"$VIRTUAL_ENV\"";
        when    = "test -n \"$VIRTUAL_ENV\"";  # only show if in a venv
        format  = "[ $output](bold green) ";
      };
      custom.vpn = {
        command = ''
          for iface in tun0 tun1 tun2 wg0 wg1; do
            ip -4 addr show "$iface" 2>/dev/null | awk '/inet / {gsub(/\/.*/, "", $2); print $2; exit}'
          done | head -1
        '';
        when = "ip link show tun0 2>/dev/null || ip link show tun1 2>/dev/null || ip link show wg0 2>/dev/null || ip link show wg1 2>/dev/null";
        format = "[ $output](red) ";
      };
      directory.substitutions = {
        Documents = "󰈙 ";
        Downloads = " ";
        Music = " ";
        Pictures = " ";
      };
    };
  };

  # Make nix shell and nix develop use Zsh
  programs.nix-your-shell = {
    enable = true;
    enableZshIntegration = true;
    nix-output-monitor.enable = true;
  };

  programs.nix-index = {
    enable =  true;
    enableZshIntegration = true;
  };
  programs.nix-index-database.comma.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  # Better ls
  programs.lsd = {
    enable = true;
    enableZshIntegration = true;
  };

  # Better file navigation
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Better cat
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batdiff batman batgrep batwatch
    ];
  };
  # Ripgrep
  programs.ripgrep.enable = true;
  # Ripgrep in documents
  programs.ripgrep-all.enable = true;
}
