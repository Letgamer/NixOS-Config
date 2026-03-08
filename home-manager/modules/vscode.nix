{
  pkgs,
  lib,
  hostname,
  ...
}:
let
  vscodeCliArgs = [
    # https://code.visualstudio.com/docs/configure/settings-sync#_recommended-configure-the-keyring-to-use-with-vs-code
    # For use with any package that implements the Secret Service API
    # (for example gnome-keyring, kwallet5, KeepassXC)
    "--password-store=basic"
  ];
in
{
  home.packages = with pkgs; [
    alejandra
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.override {
      commandLineArgs = vscodeCliArgs;
    };

    # disable mutable extensions
    mutableExtensionsDir = false;

    # set profiles
    profiles = {
      default = {

        # disable update check
        enableUpdateCheck = false;

        # disable extension update check
        enableExtensionUpdateCheck = false;

        # set extensions
        extensions = with pkgs.vscode-extensions; [
          # --- Nix / Environment ---
          mkhl.direnv # integrates direnv with VSCode
          oops418.nix-env-picker # select nix-env / nix-shell for projects
          jnoortheen.nix-ide # advanced Nix IDE features (linting, completion)

          # --- Code editing / navigation ---
          christian-kohler.path-intellisense # auto-complete file paths
          formulahendry.auto-rename-tag # auto-rename paired HTML/XML tags
          mechatroner.rainbow-csv # colorize CSV columns
          esbenp.prettier-vscode # Prettier code formatter
          ms-vscode.hexeditor # Hex editor for binary files
          oderwat.indent-rainbow # colorful indentation
          adpyke.codesnap # code screenshotter
          ibm.output-colorizer # log and output colorizer

          # --- Markdown / Docs ---
          yzhang.markdown-all-in-one # Markdown shortcuts, TOC, auto formatting
          davidanson.vscode-markdownlint # Linting for Markdown

          # --- Git / GitHub ---
          eamodio.gitlens # Git blame/history/insights
          github.vscode-pull-request-github # PR & issue integration with GitHub

          # --- Programming languages ---
          ms-vscode.cpptools # C/C++ IntelliSense & debugging
          ms-python.python # Python language support
          ms-python.vscode-pylance # Python analysis engine (fast autocomplete)
          tamasfe.even-better-toml # TOML syntax highlighting (Rust, configs)
          redhat.vscode-yaml # YAML validation & schema support
          ms-vscode.powershell # PowerShell language support
          rust-lang.rust-analyzer # Rust support
          myriad-dreamin.tinymist # Typst Integration

          # --- Server Management ---
          ms-azuretools.vscode-docker # Docker Extension
          ms-vscode-remote.remote-ssh # Remote SSh to my Server

          # --- AI ---
          github.copilot # GitHub Copilot AI pair programmer
          github.copilot-chat # Chat interface for GitHub Copilot
        ];

        # set user settings
        userSettings = {
          # This property will be used to generate settings.json:
          # https://code.visualstudio.com/docs/getstarted/settings#_settingsjson
          "telemetry.telemetryLevel" = "off";
          "telemetry.feedback.enabled" = false;
          "[nix]"."editor.tabSize" = 2;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = true;
          "editor.formatOnPaste" = true;
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "explorer.confirmDelete" = false;
          "explorer.confirmDragAndDrop" = false;
          "git.autofetch" = true;
          "git.confirmSync" = false;
          "github.gitProtocol" = "ssh";
          "security.workspace.trust.enabled" = false;
          "workbench.startupEditor" = "none";
          "workbench.secondarySidebar.defaultVisibility" = "hidden";
          "remote.SSH.defaultExtensions" = [
            "ms-azuretools.vscode-docker"
            "oderwat.indent-rainbow"
          ];
          "search.exclude" = {
            "**/.direnv" = true;
            "**/.git" = true;
            "**/.jj" = true;
            "**/.venv" = true;
            "**/node_modules" = true;
            "*.lock" = true;
            "dist" = true;
            "tmp" = true;
          };
          # Enable Nix LSP and autocompletion!
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.serverSettings"= {
            "nixd" = {
              "formatting" = {
                "command" = ["alejandra"];
              };
              "options" = {
                "home-manager" = {
                  "expr" = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${hostname}.options.home-manager.users.type.getSubOptions []";
                };
              };
            };
          };
          # Terminal Settings
          "terminal.external.linuxExec" = "alacritty";
          "terminal.integrated.defaultProfile.linux" = "zsh";
          "terminal.integrated.profiles.linux.zsh.path" = "${lib.getExe pkgs.zsh}";
        };
      };
    };
  };
}