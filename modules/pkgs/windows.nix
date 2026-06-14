{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Full Wine setup via bottles with additional dependencies and configurations
    (unstable.bottles.override {removeWarningPopup = true;})

    # Windows Misc Tools
    msitools
    wimlib
    shortscan
    python314Packages.xlsxwriter
    powershell

    # Cross compilation tools
    pkgsCross.mingw32.stdenv.cc
    pkgsCross.mingwW64.stdenv.cc

    # DOTNET
    (dotnetCorePackages.combinePackages [
      dotnet-sdk_6
      dotnet-sdk_9
      dotnet-sdk
    ])
    mono
    avalonia-ilspy
    dotnet-repl
  ];
  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet";
    SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
  };
}
