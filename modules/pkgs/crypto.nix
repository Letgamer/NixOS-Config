{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    creds
    hash-identifier
    hashcat
    hashid
    john

    # Provide a legacy openssl version for MD4, etc.
    (pkgs.writeShellScriptBin "openssl-legacy"
      ''
        exec ${pkgs.openssl_legacy}/bin/openssl "$@"
      '')
  ];
}
