{
  pkgs,
  lib,
  ...
}:
{
  home.shell.enableShellIntegration = true;
  home.shell.enableFishIntegration = true;
  
  programs.kitty = {
    enable = true;

    shellIntegration.enableFishIntegration = true;

    settings = {
      shell = "${lib.getExe pkgs.fish}";
      confirm_os_window_close = 0;
      scrollback_lines = 20000;
      enable_audio_bell = false;
      copy_on_select = true;
      mouse_hide_wait = 0;
    };
  };

  programs.fish = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # Make nix shell and nix develop use Fish
  programs.nix-your-shell = {
    enable = true;
    enableFishIntegration = true;
    nix-output-monitor.enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}