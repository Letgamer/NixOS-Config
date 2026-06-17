{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Cross compilation tools
    pkgsCross.mingw32.stdenv.cc
    pkgsCross.mingwW64.stdenv.cc

    # DOTNET
    (dotnetCorePackages.combinePackages [
      dotnet-sdk_6
      dotnet-sdk_9
      dotnet-sdk
    ])
    avalonia-ilspy
    dotnet-repl
    mono

    # Office tools
    onlyoffice-desktopeditors
    python314Packages.xlsxwriter
    oletools
    xlsx2csv

    # Windows Misc Tools
    msitools
    powershell
    shortscan
    wimlib

    # Wine setup
    (unstable.bottles.override {removeWarningPopup = true;})
  ];
  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet";
    SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
  };
}
