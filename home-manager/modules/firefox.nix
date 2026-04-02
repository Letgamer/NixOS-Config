{
  lib,
  pkgs,
  ...
}: let
  sanitize = s:
    lib.toLower (
      builtins.replaceStrings ["@" "." "{" "}"] ["_" "_" "_" "_"] s
    );
in {
  stylix.targets.firefox.profileNames = ["default"];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/about" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
      "text/html" = ["firefox.desktop"];
      "application/pdf" = ["firefox.desktop"];
      "x-scheme-handler/discord" = ["discord.desktop"];
    };
  };

  programs.firefox = with pkgs.firefox-addons; {
    enable = true;
    profiles.default = {
      isDefault = true;

      bookmarks = {
        force = true;
        settings = [
          {
            name = "toolbar";
            toolbar = true;
            bookmarks = [
              {
                name = "YouTube";
                tags = ["youtube"];
                keyword = "youtube";
                url = "https://www.youtube.com/";
              }
              {
                name = "WhatsApp";
                tags = ["whatsapp"];
                keyword = "whatsapp";
                url = "https://web.whatsapp.com/";
              }
              {
                name = "Google Maps";
                tags = [
                  "google"
                  "maps"
                ];
                keyword = "maps";
                url = "https://www.google.com/maps";
              }
              {
                name = "Mastodon";
                tags = ["mastodon"];
                keyword = "mastodon";
                url = "https://social.tchncs.de/home";
              }
              {
                name = "Proton Mail";
                tags = ["mail"];
                keyword = "mail";
                url = "https://mail.proton.me/u/0/inbox";
              }
              {
                name = "Typst";
                tags = ["typst"];
                keyword = "typst";
                url = "https://typst.app/";
              }
              {
                name = "Annas Archive";
                tags = ["archive"];
                keyword = "archive";
                url = "https://annas-archive.org/";
              }
              {
                name = "Reddit";
                tags = ["reddit"];
                keyword = "reddit";
                url = "https://www.reddit.com/";
              }
              {
                name = "Red-Flake";
                tags = ["redflake"];
                keyword = "redflake";
                url = "https://github.com/Red-Flake";
              }
              {
                name = "Server";
                bookmarks = [
                  {
                    name = "Notes";
                    tags = ["selfhosted"];
                    keyword = "selfhosted";
                    url = "https://outline.let-net.cc/home";
                  }
                  {
                    name = "RSS";
                    tags = ["selfhosted"];
                    keyword = "selfhosted";
                    url = "https://feed.let-net.cc/";
                  }
                  {
                    name = "Vaultwarden";
                    tags = ["selfhosted"];
                    keyword = "selfhosted";
                    url = "https://vaultwarden.let-net.cc/";
                  }
                  {
                    name = "Gitea";
                    tags = ["selfhosted"];
                    keyword = "selfhosted";
                    url = "https://git.let-net.cc/";
                  }
                  {
                    name = "Documents";
                    tags = ["selfhosted"];
                    keyword = "selfhosted";
                    url = "https://docs.let-net.cc/dashboard";
                  }
                  {
                    name = "Bloodhound";
                    tags = ["selfhosted"];
                    keyword = "selfhosted";
                    url = "https://ad.let-net.cc/ui/explore";
                  }
                  {
                    name = "Blog";
                    tags = ["selfhosted"];
                    keyword = "selfhosted";
                    url = "https://blog.let-net.cc/";
                  }
                  {
                    name = "Tailscale";
                    tags = [
                      "selfhosted"
                      "tailscale"
                    ];
                    keyword = "selfhosted";
                    url = "https://login.tailscale.com/admin/machines";
                  }
                  {
                    name = "Cloudflare";
                    tags = [
                      "selfhosted"
                      "cloudflare"
                    ];
                    keyword = "selfhosted";
                    url = "https://dash.cloudflare.com";
                  }
                ];
              }
              {
                name = "Streaming";
                bookmarks = [
                  {
                    name = "Mediathek";
                    tags = ["mediathek"];
                    keyword = "mediathek";
                    url = "https://mediathekviewweb.de/#query=%23Livestream%20%2BLivestream";
                  }
                  {
                    name = "Tarnkappe";
                    tags = ["tarnkappe"];
                    keyword = "tarnkappe";
                    url = "https://tarnkappe.info/listen";
                  }
                  {
                    name = "S.to";
                    tags = ["series"];
                    keyword = "series";
                    url = "https://s.to";
                  }
                  {
                    name = "Cine.to";
                    tags = ["movies"];
                    keyword = "movies";
                    url = "https://cine.to";
                  }
                  {
                    name = "Filmpalast.to";
                    tags = ["movies"];
                    keyword = "movies";
                    url = "https://filmpalast.to";
                  }
                  {
                    name = "Einschalten.io";
                    tags = ["movies"];
                    keyword = "movies";
                    url = "https://einschalten.in";
                  }
                  {
                    name = "Huhu.to";
                    tags = ["movies"];
                    keyword = "movies";
                    url = "https://huhu.to/web-vod/browse?id=movie.trending";
                  }
                ];
              }
              {
                name = "News";
                bookmarks = [
                  {
                    name = "Zeit";
                    tags = ["news"];
                    keyword = "news";
                    url = "https://www.zeit.de/exklusive-zeit-artikel";
                  }
                  {
                    name = "Zeit Energiemonitor";
                    tags = ["news"];
                    keyword = "news";
                    url = "https://www.zeit.de/wirtschaft/energiemonitor-strompreis-gaspreis-erneuerbare-energien-ausbau";
                  }
                  {
                    name = "SZ";
                    tags = ["news"];
                    keyword = "news";
                    url = "https://plus.sueddeutsche.de/";
                  }
                  {
                    name = "Spiegel";
                    tags = ["news"];
                    keyword = "news";
                    url = "https://www.spiegel.de/plus/";
                  }
                ];
              }
              {
                name = "Tools";
                bookmarks = [
                  {
                    name = "Crackstation";
                    tags = ["crackstation"];
                    keyword = "crackstation";
                    url = "https://crackstation.net";
                  }
                  {
                    name = "CyberChef";
                    tags = ["cyberchef"];
                    keyword = "cyberchef";
                    url = "https://gchq.github.io/CyberChef/";
                  }
                  {
                    name = "Synk Code Checker";
                    tags = ["snyk"];
                    keyword = "synk";
                    url = "https://snyk.io/code-checker/";
                  }
                  {
                    name = "Grep.app";
                    tags = ["grep"];
                    keyword = "grep";
                    url = "https://grep.app/";
                  }
                  {
                    name = "IP Adderss Converter";
                    tags = [
                      "ip"
                      "converter"
                    ];
                    keyword = "converter";
                    url = "https://www.abuseipdb.com/tools/ip-address-converter";
                  }
                  {
                    name = "Base64";
                    tags = ["base64"];
                    keyword = "base64";
                    url = "https://www.base64encode.org/";
                  }
                  {
                    name = "URL-Encode";
                    tags = ["url"];
                    keyword = "url";
                    url = "https://www.urldecoder.org/";
                  }
                  {
                    name = "NameThatHash";
                    tags = ["hash"];
                    keyword = "hash";
                    url = "https://nth.skerritt.blog/";
                  }
                  {
                    name = "RegEx";
                    tags = ["regex"];
                    keyword = "regex";
                    url = "https://regex101.com/";
                  }
                  {
                    name = "Linux Cheatsheets";
                    tags = ["linux"];
                    keyword = "linux";
                    url = "https://linuxcommandlibrary.com/";
                  }
                  {
                    name = "IT Tools";
                    tags = ["tools"];
                    keyword = "tools";
                    url = "https://it-tools.tech/";
                  }
                  {
                    name = "File Sharing";
                    tags = [
                      "tools"
                      "pizza"
                    ];
                    keyword = "tools";
                    url = "https://file.pizza/";
                  }
                  {
                    name = "VERT";
                    tags = [
                      "tools"
                      "vert"
                    ];
                    keyword = "tools";
                    url = "https://vert.sh/";
                  }
                  {
                    name = "RSS Feed Finder";
                    tags = [
                      "tools"
                      "rss"
                    ];
                    keyword = "rssfinder";
                    url = "https://lighthouseapp.io/tools/feed-finder/";
                  }
                  {
                    name = "Tree";
                    tags = [
                      "tools"
                      "tree"
                    ];
                    keyword = "tree";
                    url = "https://tree.nathanfriend.com/";
                  }
                  {
                    name = "MermaidJS";
                    tags = [
                      "tools"
                      "mermaid"
                    ];
                    keyword = "tools";
                    url = "https://mermaid.live/";
                  }
                  {
                    name = "Canva";
                    tags = [
                      "tools"
                      "canva"
                    ];
                    keyword = "tools";
                    url = "https://www.canva.com/";
                  }
                ];
              }
              {
                name = "NixOS";
                bookmarks = [
                  {
                    name = "Nixpkgs";
                    tags = ["nixpkgs"];
                    keyword = "nixpkgs";
                    url = "https://github.com/NixOS/nixpkgs";
                  }
                  {
                    name = "Package Search";
                    tags = ["nixos"];
                    keyword = "nixos";
                    url = "https://search.nixos.org/packages?channel=unstable";
                  }
                  {
                    name = "Option Search";
                    tags = ["nixos"];
                    keyword = "nixos";
                    url = "https://search.nixos.org/options?channel=unstable";
                  }
                  {
                    name = "Nix package versions";
                    tags = ["nixos"];
                    keyword = "nixos";
                    url = "https://lazamar.co.uk/nix-versions/";
                  }
                  {
                    name = "Chaotic's Nyx";
                    tags = ["nixos"];
                    keyword = "nixos";
                    url = "https://www.nyx.chaotic.cx/";
                  }
                  {
                    name = "NUR";
                    tags = ["nixos"];
                    keyword = "nixos";
                    url = "https://nur.nix-community.org/";
                  }
                  {
                    name = "Noogle";
                    tags = ["nixos"];
                    keyword = "nixos";
                    url = "https://noogle.dev/";
                  }
                  {
                    name = "Home Manager Options";
                    tags = ["homemanager"];
                    keyword = "homemanager";
                    url = "https://home-manager-options.extranix.com/";
                  }
                  {
                    name = "NixOS & Flakes Book";
                    tags = ["nixos"];
                    keyword = "nixos";
                    url = "https://nixos-and-flakes.thiscute.world/introduction/";
                  }
                  {
                    name = "Nix Pills";
                    tags = ["nix"];
                    keyword = "nix";
                    url = "https://nixos.org/guides/nix-pills/";
                  }
                  {
                    name = "Zero to Nix";
                    tags = ["nix"];
                    keyword = "nix";
                    url = "https://zero-to-nix.com/";
                  }
                  {
                    name = "nix.dev";
                    tags = ["nix"];
                    keyword = "nix";
                    url = "https://nix.dev/";
                  }
                  {
                    name = "Wombat's Book of Nix";
                    tags = ["nix"];
                    keyword = "nix";
                    url = "https://mhwombat.codeberg.page/nix-book/";
                  }
                  {
                    name = "Plasma-Manager Options";
                    tags = ["nix"];
                    keyword = "nix";
                    url = "https://nix-community.github.io/plasma-manager/options.xhtml";
                  }
                  {
                    name = "Nixpkgs PRs Dashboard";
                    tags = ["nix"];
                    keyword = "nix";
                    url = "https://nixpkgs-prs.fliegendewurst.eu/";
                  }
                  {
                    name = "Nixpkgs PR Tracker";
                    tags = ["nix"];
                    keyword = "nix";
                    url = "https://nixpkgs-tracker.ocfox.me/";
                  }
                ];
              }
              {
                name = "Wikis";
                bookmarks = [
                  {
                    name = "HackTricks";
                    tags = ["hacktricks"];
                    keyword = "hacktricks";
                    url = "https://book.hacktricks.xyz/";
                  }
                  {
                    name = "HackTricks Cloud";
                    tags = ["hacktricks"];
                    keyword = "hacktricks";
                    url = "https://cloud.hacktricks.wiki/";
                  }
                  {
                    name = "Payloads All The Things";
                    tags = ["payloadsallthethings"];
                    keyword = "payloadsallthethings";
                    url = "https://swisskyrepo.github.io/PayloadsAllTheThings/";
                  }
                  {
                    name = "Internal All The Things";
                    tags = ["internalallthethings"];
                    keyword = "internalallthethings";
                    url = "https://swisskyrepo.github.io/InternalAllTheThings/";
                  }
                  {
                    name = "Hardware All The Things";
                    tags = ["hardwareallthethings"];
                    keyword = "hardwareallthethings";
                    url = "https://swisskyrepo.github.io/HardwareAllTheThings/";
                  }
                  {
                    name = "Jorian CTF";
                    tags = ["jorianwoltjer"];
                    keyword = "jorianwoltjer";
                    url = "https://book.jorianwoltjer.com/";
                  }
                  {
                    name = "CTF Database";
                    tags = ["ctf"];
                    keyword = "ctf";
                    url = "https://ctfsearch.hackmap.win/";
                  }
                ];
              }
              {
                name = "Platforms";
                bookmarks = [
                  {
                    name = "HTB Main";
                    tags = ["htb"];
                    keyword = "htb";
                    url = "https://app.hackthebox.com";
                  }
                  {
                    name = "HTB Academy";
                    tags = ["htb"];
                    keyword = "htb";
                    url = "https://academy.hackthebox.com";
                  }
                  {
                    name = "HTB CTF";
                    tags = ["htb"];
                    keyword = "htb";
                    url = "https://ctf.hackthebox.com";
                  }
                  {
                    name = "Vulnlab";
                    tags = ["vulnlab"];
                    keyword = "vulnlab";
                    url = "https://www.vulnlab.com/";
                  }
                  {
                    name = "PortSwigger Academy";
                    tags = ["portswigger"];
                    keyword = "portswigger";
                    url = "https://portswigger.net/web-security";
                  }
                  {
                    name = "TryHackMe";
                    tags = ["thm"];
                    keyword = "thm";
                    url = "https://tryhackme.com/";
                  }
                  {
                    name = "OverTheWire";
                    tags = ["overthewire"];
                    keyword = "overthewire";
                    url = "https://overthewire.org/wargames/";
                  }
                ];
              }
              {
                name = "AI";
                bookmarks = [
                  {
                    name = "PentestGPT";
                    tags = ["pentestgpt"];
                    keyword = "pentestgpt";
                    url = "https://pentestgpt.ai";
                  }
                  {
                    name = "Grok";
                    tags = ["grok"];
                    keyword = "grok";
                    url = "https://grok.com";
                  }
                  {
                    name = "ChatGPT";
                    tags = ["chatgpt"];
                    keyword = "chatgpt";
                    url = "https://chatgpt.com";
                  }
                  {
                    name = "Perplexity";
                    tags = ["perplexity"];
                    keyword = "perplexity";
                    url = "https://perplexity.ai";
                  }
                ];
              }
              {
                name = "OSINT";
                bookmarks = [
                  {
                    name = "WayBackMachine";
                    tags = ["WayBackMachine"];
                    keyword = "WayBackMachine";
                    url = "https://archive.org/";
                  }
                  {
                    name = "Shodan";
                    tags = ["shodan"];
                    keyword = "shodan";
                    url = "https://www.shodan.io/";
                  }
                  {
                    name = "censys";
                    tags = ["censys"];
                    keyword = "censys";
                    url = "https://search.censys.io/";
                  }
                  {
                    name = "URLHaus abuse";
                    tags = ["abuse"];
                    keyword = "abuse";
                    url = "https://urlhaus.abuse.ch/browse/";
                  }
                  {
                    name = "C2 Tracker";
                    tags = ["tracker"];
                    keyword = "tracker";
                    url = "https://tracker.viriback.com/";
                  }
                  {
                    name = "Threatcenter";
                    tags = ["threatcenter"];
                    keyword = "threatcenter";
                    url = "https://threatcenter.crdf.fr/";
                  }
                  {
                    name = "intelx";
                    tags = ["intelx"];
                    keyword = "intelx";
                    url = "https://intelx.io/";
                  }
                  {
                    name = "OSINT Framework";
                    tags = ["osint"];
                    keyword = "osint";
                    url = "https://osintframework.com/";
                  }
                  {
                    name = "IntelTechniques";
                    tags = ["inteltechniques"];
                    keyword = "inteltechniques";
                    url = "https://inteltechniques.com/tools/Search.html";
                  }
                ];
              }
              {
                name = "Web";
                bookmarks = [
                  {
                    name = "CSPBypass";
                    tags = ["csp"];
                    keyword = "csp";
                    url = "https://cspbypass.com/";
                  }
                  {
                    name = "jwt.io";
                    tags = ["jwt.io"];
                    keyword = "jwt.io";
                    url = "https://jwt.io/";
                  }
                  {
                    name = "oauth.tools";
                    tags = ["oauth.tools"];
                    keyword = "oauth.tools";
                    url = "https://oauth.tools/";
                  }
                  {
                    name = "Chrome Extension Security";
                    tags = ["extension"];
                    keyword = "extension";
                    url = "https://extensions.neplox.security/";
                  }
                  {
                    name = "Dom-Clobbering";
                    tags = ["dom"];
                    keyword = "dom";
                    url = "https://domclob.xyz/";
                  }
                  {
                    name = "Dom-Explorer";
                    tags = ["dom"];
                    keyword = "dom";
                    url = "https://yeswehack.github.io/Dom-Explorer/";
                  }
                  {
                    name = "XS-Leaks";
                    tags = ["xs"];
                    keyword = "xs";
                    url = "https://xsleaks.dev/";
                  }
                  {
                    name = "GMSGadget";
                    tags = ["xss"];
                    keyword = "xss";
                    url = "https://gmsgadget.com/";
                  }
                ];
              }
              {
                name = "GTFOBins";
                bookmarks = [
                  {
                    name = "GTFOBins";
                    tags = ["gtfobins"];
                    keyword = "gtfobins";
                    url = "https://gtfobins.github.io/";
                  }
                  {
                    name = "LOLBAS ";
                    tags = ["lolbas"];
                    keyword = "lolbas";
                    url = "https://lolbas-project.github.io/";
                  }
                  {
                    name = "WADComs ";
                    tags = ["wadcoms"];
                    keyword = "wadcoms";
                    url = "https://wadcoms.github.io/";
                  }
                ];
              }
              {
                name = "Reporting";
                bookmarks = [
                  {
                    name = "Offsec Sysreptor";
                    tags = ["sysreptor"];
                    keyword = "sysreptor";
                    url = "https://oscp.sysreptor.com/";
                  }
                  {
                    name = "HTB Sysreptor";
                    tags = ["sysreptor"];
                    keyword = "sysreptor";
                    url = "https://htb.sysreptor.com/";
                  }
                ];
              }
              {
                name = "Element";
                tags = ["element"];
                keyword = "element";
                url = "https://chat.tchncs.de";
              }
            ];
          }
        ];
      };

      settings = {
        # Make Prefs declarative
        "remote.prefs.recommended" = false;

        # Enable Dark Theme
        "ui.systemUsesDarkTheme" = 1;
        "browser.in-content.dark-mode" = true;

        # Disable irritating first-run stuff
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.feeds.showFirstRunUI" = false;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.rights.3.shown" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.uitour.enabled" = false;
        "startup.homepage_override_url" = "";
        "startup.homepage_welcome_url.additional" = "";
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.addedImportButton" = true;
        "browser.contentblocking.introCount" = 99;

        # Disable Warnings
        "browser.tabs.warnOnClose" = false;
        "browser.tabs.warnOnCloseOtherTabs" = false;
        "browser.tabs.warnOnOpen" = false;
        "browser.warnOnQuit" = false;

        # Disable Tab Restrictions for Pop-Ups
        "browser.link.open_newwindow.restriction" = 0;

        # Disable all of the AI stuff
        "browser.ml.enable" = false;
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.hideFromLabs" = false;
        "browser.ml.chat.hideLabsShortcuts" = false;
        "browser.ml.chat.page" = false;
        "browser.ml.chat.page.footerBadge" = false;
        "browser.ml.chat.page.menuBadge" = false;
        "browser.ml.chat.menu" = false;
        "browser.ml.chat.sidebar" = false;
        "browser.ml.linkPreview.enabled" = false;
        "browser.ml.pageAssist.enabled" = false;
        "browser.ml.smartAssist.enabled" = false;
        "browser.tabs.groups.smart.enabled" = false;
        "browser.tabs.groups.smart.userEnable" = false;
        "browser.search.visualSearch.featureGate" = false;
        "browser.urlbar.quicksuggest.mlEnabled" = false;
        "pdfjs.enableAltText" = false;
        "places.semanticHistory.featureGate" = false;
        "sidebar.revamp" = false;
        "extensions.ml.enabled" = false;

        "browser.aboutConfig.showWarning" = false;
        "toolkit.telemetry.enabled" = false;
        # Prompt every time when downloading
        "browser.download.useDownloadDir" = false;

        "browser.newtab.preload" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.sections" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.default.sites" = "";

        "browser.tabs.tabmanager.enabled" = false;

        # Disable ALT keybinding
        "ui.key.menuAccessKeyFocuses" = false;

        "browser.discovery.enabled" = false;
        "extensions.getAddons.showPane" = false;
        "extensions.getAddons.cache.enabled" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.pocket.enabled" = false;
        "extensions.screenshots.disabled" = true;
        "extensions.blocklist.enabled" = false;
        "extensions.update.autoUpdateDefault" = false;
        "extensions.systemAddon.update.enabled" = false;
        "extensions.systemAddon.update.url" = "";
        "extensions.update.enabled" = false;
        "identity.fxaccounts.enabled" = false;
        "identity.fxaccounts.telemetry.clientAssociationPing.enabled" = false;

        # Telemetry / Data collection / Crash reporting
        "app.shield.optoutstudies.enabled" = false;
        "browser.ping-centre.telemetry" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.clean" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "toolkit.coverage.endpoint.base" = "";
        "toolkit.coverage.opt-out" = true;
        "toolkit.telemetry.coverage.opt-out" = true;
        "browser.region.update.enabled" = false;
        "browser.region.network.url" = "";
        "browser.aboutHomeSnippets.updateUrl" = "";
        "browser.selfsupport" = false;

        # Disable URL and file security "features"
        "browser.safebrowsing.phishing.enabled" = false;
        "browser.safebrowsing.malware.enabled" = false;
        "browser.safebrowsing.blockedURIs.enabled" = false;
        "browser.safebrowsing.downloads.enabled" = false;
        "browser.safebrowsing.downloads.remote.enabled" = false;
        "browser.safebrowsing.downloads.remote.block_dangerous" = false;
        "browser.safebrowsing.downloads.remote.block_dangerous_host" = false;
        "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
        "browser.safebrowsing.downloads.remote.block_uncommon" = false;
        "browser.safebrowsing.downloads.remote.url" = "";
        "browser.safebrowsing.provider.*.gethashURL" = "";
        "browser.safebrowsing.provider.*.updateURL" = "";

        # Disable recommendations
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        # Opens about:addons by default when navigating to add-ons
        "extensions.ui.lastCategory" = "about:addons";
        # Disable additional Network Stuff
        "browser.vpn_promo.enabled" = false;
        "app.normandy.enabled" = false;
        "extensions.webextensions.restrictedDomains" = "";
        "browser.search.geoip.url" = "";

        # Enable automatic cookie banner handling
        "cookiebanners.service.mode" = 2;
        "cookiebanners.service.mode.privateBrowsing" = 2;
        # Enable console pasting
        "devtools.selfxss.count" = 50;

        "dom.security.https_only_mode" = false;
        # DNS
        "network.trr.mode" = 2;
        "network.trr.uri" = "https://doh.mullvad.net/dns-query";
        "network.trr.wait-for-portal" = true;
        # Enable ECH
        "network.dns.echconfig.enabled" = true;
        "network.dns.http3_echconfig.enabled" = true;

        "security.OCSP.enabled" = 0;
        "network.prefetch-next" = false;
        "network.dns.disablePrefetch" = true;
        "media.peerconnection.ice.default_address_only" = true;
        "network.http.speculative-parallel-limit" = 0;

        # Autofill
        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;
        "browser.formfill.enable" = false;
        "signon.formlessCapture.enabled" = false;
        "signon.showAutoCompleteFooter" = false;
        "signon.autofillForms.http" = false;
        "signon.management.page.breach-alerts.enabled" = false;
        "signon.generation.enabled" = false;

        # Scrolling
        "apz.overscroll.enabled" = true;
        "apz.gtk.kinetic_scroll.enabled" = true;

        "network.auth.subresource-http-auth-allow" = 1;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.rdd-vpx.enabled" = true;
        "widget.dmabuf.force-enabled" = true;
        "webgl.enable-debug-renderer-info" = false;

        "widget.use-xdg-desktop-portal.file-picker" = 1;
        # automatically enable extensions
        "extensions.autoDisableScopes" = 0;
        "full-screen-api.warning.timeout" = 0;
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.tabs.loadBookmarksInTabs" = true;
        "browser.startup.couldRestoreSession.count" = -1;

        # Enable htb domains without redirectiuon to google
        "browser.fixup.domainsuffixwhitelist.htb" = true;
        "browser.urlbar.trimURLs" = false;

        # Layout
        # This is needed to pin the extensions!
        "browser.uiCustomization.state" = builtins.toJSON {
          placements = {
            nav-bar = [
              "back-button"
              "forward-button"
              "stop-reload-button"
              "customizableui-special-spring1"
              "vertical-spacer"
              "urlbar-container"
              "customizableui-special-spring2"
              "downloads-button"
              "fxa-toolbar-menu-button"
              # Extension Order is defined here!
              "${sanitize ublock-origin.addonId}-browser-action"
              "${sanitize bitwarden.addonId}-browser-action"
              "${sanitize pwnfox.addonId}-browser-action"
              "${sanitize darkreader.addonId}-browser-action"
              "${sanitize wappalyzer.addonId}-browser-action"
              "${sanitize bypass-paywalls-clean.addonId}-browser-action"
              "${sanitize cookie-editor.addonId}-browser-action"
              "${sanitize hacktools.addonId}-browser-action"
              "${sanitize simple-modify-header.addonId}-browser-action"
            ];
          };
        };
      };

      extensions = {
        force = true;
        packages = [
          bitwarden
          bypass-paywalls-clean
          cookie-editor
          darkreader
          hacktools
          pwnfox
          simple-modify-header
          ublock-origin
          wappalyzer
        ];
        settings = {
          # Darkreader config: https://github.com/BryceBeagle/nixos-config/blob/main/modules/programs/firefox/extensions/darkreader.nix
          # https://github.com/nix-community/home-manager/pull/6389
          # https://github.com/nix-community/home-manager/issues/4618
          # https://github.com/nix-community/home-manager/issues/8094
          "${ublock-origin.addonId}".settings = {
            selectedFilterLists = [
              "user-filters"
              "ublock-filters"
              "ublock-badware"
              "ublock-privacy"
              "ublock-quick-fixes"
              "ublock-unbreak"
              "easylist"
              "adguard-generic"
              "easyprivacy"
              "adguard-spyware-url"
              "urlhaus-1"
              "curben-phishing"
              "plowe-0"
              "fanboy-cookiemonster"
              "ublock-cookies-easylist"
              "adguard-cookies"
              "ublock-cookies-adguard"
              "easylist-chat"
              "easylist-newsletters"
              "easylist-notifications"
              "easylist-annoyances"
              "adguard-other-annoyances"
              "adguard-popup-overlays"
              "adguard-widgets"
              "ublock-annoyances"
              "DEU-0"
            ];
          };
          # Bitwarden Configuration
          "${bitwarden.addonId}" = {
            force = true;
            settings = {
              global_environment_environment = {
                region = "Self-hosted";
                urls = {
                  base = "https://vaultwarden.let-net.cc";
                };
              };
              global_loginEmail_storedEmail = "alexstephan005@protonmail.com";
              global_vaultBrowserIntroCarousel_introCarouselDismissed = true;
              global_extensionInitialInstall_extensionInstalled = true;
              global_vaultAppearance_copyButtons = "quick";
              global_autofillSettingsLocal_inlineMenuVisibility = {
                __json__ = true;
                value = "1";
              };
              user_5450439a-482e-48fe-91ba-a0fecf259c67_autofillSettings_autofillOnPageLoad = true;
              user_5450439a-482e-48fe-91ba-a0fecf259c67_autofillSettings_autofillOnPageLoadDefault = true;
              user_5450439a-482e-48fe-91ba-a0fecf259c67_domainSettings_defaultUriMatchStrategy = 1;
            };
          };
          # Cookie-Editor
          "${cookie-editor.addonId}" = {
            force = true;
            settings = {
              all_options.adsEnabled = false;
            };
          };
          "${pwnfox.addonId}" = {
            force = true;
            settings = {
              enabled = true;
              useBurpProxyContainer = true;
              removeSecurityHeaders = true;
            };
          };
          "${wappalyzer.addonId}" = {
            force = true;
            settings = {
              termsAccepted = true;
              tracking = false;
              version = 1;
              upgradeMessage = false;
              theme = "dark";
            };
          };
          "${bypass-paywalls-clean.addonId}" = {
            force = true;
            settings = {
              optInShown = false;
              customShown = false;
              optInFetch = true;
              optIn = true;
              customOptIn = true;
              optInUpdate = false;
            };
          };
        };
      };
    };
  };
}
