{pkgs, ...}: {
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    earlySetup = true;
    font = "ter-v24n";
    keyMap = "de";
    packages = with pkgs; [terminus_font];
  };
  # Set your time zone.
  time.timeZone = "Europe/Berlin";
}
