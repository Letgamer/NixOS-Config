{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Full Wine setup with additional dependencies and configurations
    (wineWow64Packages.waylandFull.override {
      embedInstallers = true;
      gstreamerSupport = true;
      ffmpegSupport = true;
      openclSupport = true;
    })
    (bottles.override {removeWarningPopup = true;})
    winetricks

    msitools
    wimlib
    shortscan
    python314Packages.xlsxwriter
    powershell

    # DOTNET
    (dotnetCorePackages.combinePackages [
      dotnet-sdk_6
      dotnet-sdk
    ])
    mono
    avalonia-ilspy
    dotnet-repl
  ];
  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet";
  };
}
