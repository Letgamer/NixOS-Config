{lib, ...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/id_redline-ssh";
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
        GSSAPIDelegateCredentials = true;

        # Legacy RSA support
        HostKeyAlgorithms = "+ssh-rsa";
        PubkeyAcceptedAlgorithms = "+ssh-rsa";
      };
    };
  };
}
