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
      pcat = "cat";

      man = "batman";
      diff = "batdiff";
      grep = "batgrep";
      watch = "batwatch";

      top = "btop";
      vscode = "code .";
      code = "code .";

      # Misc
      ".." = "cd ..";
      mkdir = "mkdir -p";
      mk = "() { mkdir -p -- '$1' && cd -- '$1'; };";
      cdp = "pwd | wl-copy";
      cfp = "(){ readlink -f '$1' | wl-copy; }";
      serve = "python3 -m http.server \${1:-8000}";
    };
    shellGlobalAliases = {
      copy = "wl-copy";
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
      add_newline = true;
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
        "$ruby"
        "$java"
        "\n$character"
      ];
      right_format = lib.concatStrings [ 
        "$venv "
        "$nix_shell "
        "$vpnip "
        "$time"];
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
      custom.vpnip = {
        command = "ip -4 -o addr show tun0 | awk '{print $4}' | cut -d/ -f1";
        when = "test -d /sys/class/net/tun0";
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
