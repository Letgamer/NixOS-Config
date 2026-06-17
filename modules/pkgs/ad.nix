{pkgs, ...}: {
  # TODO:
  # bloodhound-ce-py, bloodhound-quickwin, ldapdomaindump, linWinPwn, wmiexec-Pro,
  # ntlm_theft, pkinittools, petitpotam, gmsadumper
  environment.systemPackages = with pkgs.unstable; [
    adenum
    adidnsdump
    autobloody
    certipy
    coercer
    evil-winrm
    evil-winrm-py
    kerbrute
    krb5
    krb5.dev
    ldapdomaindump
    ldeep
    netexec
    openldap
    powerview
    pygpoabuse
    pywhisker
    python314Packages.bloodyad
    python314Packages.impacket
    python314Packages.lsassy
    python314Packages.pypykatz
    responder
    samba4Full
  ];
}
