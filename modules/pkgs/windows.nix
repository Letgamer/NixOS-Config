{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Full Wine setup via bottles with additional dependencies and configurations
    (bottles.override {removeWarningPopup = true;})

    msitools
    wimlib
    shortscan
    python314Packages.xlsxwriter
    powershell

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
