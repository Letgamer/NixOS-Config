{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Database
    dbeaver-bin
    litecli
    mdbtools
    mongosh
    mycli
    pgcli
    redis
    sqlite
    sqlitebrowser
    sqlcmd
    sqlit-tui

    # FTB
    filezilla
    lftp
    ncftp

    # RDP
    freerdp
    rdesktop
    remmina

    # RPC
    rpcbind

    # SMB
    enum4linux
    enum4linux-ng
    smbclient-ng
    smbmap
    smbscan

    # SMTP
    python314Packages.aiosmtpd
    smtp-user-enum
    smtprelay
    swaks

    # SNMP
    onesixtyone
    snmpcheck
    snmpen
  ];
}
