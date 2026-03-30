{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Decode/rebuild APKs
    apktool
    # Same, XAPK to APK
    apkeditor
    # CLI tools for Frida (frida-ps, frida-trace, etc.)
    frida-tools
    # Frida core library (runtime instrumentation)
    libfrida-core
    # Java bytecode decompiler (DEX/JAR → Java)
    cfr
    # Android DEX/APK decompiler (Java + resources)
    jadx
    # Convert DEX files to JAR for Java analysis
    dex2jar
    # Mirror/control Android devices over ADB
    scrcpy
    # ADB, fastboot, and other Android platform tools
    android-tools
    # Android Studio IDE + SDK + emulator
    android-studio-full
    # Additional Android Studio command-line tools
    android-studio-tools
    # Download APKs from Google Play without device
    apkeep
    # Scan APKs for hardcoded secrets and endpoints
    apkleaks
    # Download APK from Google Play Store
    google-play

    ## iOS
    # USB multiplexing daemon for iOS devices
    usbmuxd
    # Client library for communicating with usbmuxd
    libusbmuxd
    # CLI tools for interacting with iOS devices (lockdown, AFC, etc.)
    libimobiledevice
    # Proxy for Safari Web Inspector (WebView debugging)
    ios-webkit-debug-proxy
    # Mount iOS filesystem via FUSE
    ifuse
    # Library for parsing Apple plist files
    libplist
    # Communicate with iOS devices in recovery/DFU mode
    libirecovery
    # Restore or downgrade iOS firmware
    idevicerestore
  ];

  services.usbmuxd.enable = true;
  programs.fuse.userAllowOther = true;
}
