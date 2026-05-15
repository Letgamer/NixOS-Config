{pkgs, ...}: {
  # TODO:
  # bloodhound-ce-py, bloodhound-quickwin, ldapdomaindump-patched, linWinPwn, wmiexec-Pro,
  # ntlm_theft, pkinittools, petitpotam, gmsadumper, responder
  environment.systemPackages = with pkgs.unstable; [
    python314Packages.impacket
    openldap
    ldapdomaindump
    certipy
    netexec
    python314Packages.bloodyad
    krb5
    krb5.dev
    samba4Full
    autobloody
    python314Packages.lsassy
    ldeep
    pygpoabuse
    python314Packages.pypykatz
    coercer
    powerview
    adidnsdump
    adenum
    pywhisker
  ];
}
