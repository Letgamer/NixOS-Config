{
  pkgs,
  lib,
  ...
}:
{
  home.shell.enableShellIntegration = true;
  home.shell.enableZshIntegration = true;
  
  programs.alacritty = {
    enable = true;
    settings = {
      terminal.shell = "${lib.getExe pkgs.zsh}";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = true;
      format = "$all$nodejs$lua$golang$rust$php$git_branch$git_commit$git_state$git_status\n$username$hostname$directory";
      right_format = "$nix_shell $vpnip $time";
      time = {
        disabled = false;
        time_format = "%T"; # HH:MM:SS
        format = "[🕙 $time]($style)";
      };
      nix_shell = {
        format = "[$state $name](bold blue) ";
        impure_msg = "❄️";
        pure_msg = "";
        heuristic = true;
      };
      custom.vpnip = {
        command = "ip -4 -o addr show tun0 | awk '{print $4}' | cut -d/ -f1";
        when = "ip link show tun0 >/dev/null 2>&1";
        format = "[🔒 $output](red) ";
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
}