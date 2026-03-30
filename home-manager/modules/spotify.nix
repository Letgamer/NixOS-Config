{
  inputs,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  programs.spicetify = {
    enable = true;
    wayland = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      fullScreen
      hidePodcasts
      keyboardShortcut
      shuffle
      volumePercentage
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus # needed for lyrics on the fullscreen extension
    ];
  };
}
