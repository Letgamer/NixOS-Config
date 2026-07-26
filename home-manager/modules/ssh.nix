{
  lib,
  pkgs,
  ...
}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    package = pkgs.openssh.override {withKerberos = true;};

    settings = {
      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/id_redline-ssh";
        AddKeysToAgent = "yes";
      };

      "Host letserver" = {
        HostName = "192.168.178.84";
        User = "root";
        IdentityFile = "~/.ssh/id_server-ssh";
        AddKeysToAgent = "yes";
      };

      "Host ctf" = {
        HostName = "10.70.1.29";
        User = "ctf";
        IdentityFile = "~/.ssh/id_ctf-ssh";
        AddKeysToAgent = "yes";
      };

      "Host *" = lib.hm.dag.entryAfter ["github.com"] {
        AddKeysToAgent = "yes";
        ForwardAgent = true;
        Compression = true;
        # Improve unstable connections
        ServerAliveInterval = 30;
        ServerAliveCountMax = 4;
        TCPKeepAlive = true;

        # Convenience
        StrictHostKeyChecking = "accept-new";
        UpdateHostKeys = true;

        # known_hosts management
        HashKnownHosts = false;
        UserKnownHostsFile = "~/.ssh/known_hosts";

        # Faster repeated connections
        ControlMaster = "auto";
        ControlPersist = "10m";
        ControlPath = "~/.ssh/master-%r@%n:%p";

        # Kerberos / GSSAPI
        GSSAPIAuthentication = true;

        # Legacy RSA support
        HostKeyAlgorithms = "+ssh-rsa";
        PubkeyAcceptedAlgorithms = "+ssh-rsa";
      };
    };
  };
}
