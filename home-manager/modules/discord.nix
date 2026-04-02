{
  programs.nixcord = {
    enable = true;
    discord.enable = false;
    vesktop = {
      enable = true;
      state = {
        firstLaunch = false;
      };
    };
    config = {
      frameless = true;
      plugins = {
        # General Tweaks
        alwaysTrust.enable = true; # Removes the annoying untrusted domain and suspicious file popup
        betterSessions.enable = true; # Enhances the sessions (devices) menu
        biggerStreamPreview.enable = true; # Allows enlarging stream previews
        copyFileContents.enable = true; # Adds a button to text file attachments to copy their contents
        fixYoutubeEmbeds.enable = true; # Bypasses youtube videos being blocked from display on Discord

        # Image Tweaks
        fixImagesQuality.enable = true; # Improves quality of images in chat by forcing png format.
        imageZoom.enable = true; # zoom in to images and gifs

        # Premium Features
        fakeNitro.enable = true; # Enables Stickers, and 4k streams
        volumeBooster.enable = true; # Allows you to set the user and stream volume above the default maximum
        webScreenShareFixes.enable = true; # Removes 2500kbps bitrate cap on chromium and vesktop clients
        youtubeAdblock.enable = true; # Block ads in YouTube embeds and the WatchTogether activity via AdGuard
      };
    };
  };

  # Copied the main stuff from: https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/ve/vesktop/package.nix#L163
  xdg.desktopEntries.discord = {
    name = "Discord";
    exec = "vesktop %U";
    icon = "vesktop";
    genericName = "Internet Messenger";
    categories = [ "Network" "InstantMessaging" "Chat" ];
    mimeType = [ "x-scheme-handler/discord" ];
  };
}
