{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.name = "Letgamer";
      user.email = "alexstephan005@protonmail.com";
      pull.rebase = true;
      push.autoSetupRemote = true;
      credential.helper = "store";
    };
    signing = {
      format = "ssh";
      key = "~/.ssh/id_github-ssh.pub";
      signByDefault = true;
    };
  };
}
