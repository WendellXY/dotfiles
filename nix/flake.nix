{
  description = "Tzeentch's nix-darwin system flake with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      homebrew-bundle,
      home-manager,
    }:
    let
      configuration =
        { pkgs, config, ... }:
        {
          # Packages to install in system profile
          environment.systemPackages =
            with pkgs;
            let
              # Terminal Emulators
              terminals = [
                alacritty
                iterm2
                kitty
              ];

              # Shell and Terminal Utilities
              shellUtils = [
                atuin # Shell history management
                bat # Better cat
                delta # Better git diff
                eza # Modern ls replacement
                fd # Better find
                fzf # Fuzzy finder
                gh # GitHub CLI
                git # Version control
                git-lfs # Git large file storage
                jq # JSON processor
                lazygit # Git client
                ripgrep # Better grep
                tldr # Simplified man pages
                tmux # Terminal multiplexer
                tree-sitter # Parser generator tool
                yazi # File manager
                zoxide # Smarter cd command
              ];

              # Development Tools
              devTools = [
                cmake # Build system
                cocoapods # iOS dependency manager
                meson # Build system
                pipx # Python package installer
                fastlane # iOS deployment automation
                neovim # Text editor
                vscode
                zed
              ];

              # Frameworks
              frameworks = [
                libarchive # Archive library
                libyaml # YAML parser
              ];

              # Programming Languages and Runtime
              languages = [
                go
                lua
                luajit
                nil # nix language server
                nixfmt-rfc-style
                nixpkgs-fmt # Nix code formatter
                nodejs
                python3
                ruby_3_3
                zig
                rustup # Rust toolchain installer
                swiftlint # Swift linter
              ];

              # Media Tools
              mediaTools = [
                ffmpeg
                ffmpegthumbnailer
              ];

              # Applications
              applications = [
                alt-tab-macos # Better app switcher
                google-chrome # Web browser
                ice-bar # macOS menu bar app
                image_optim # Image optimizer
                lmstudio # LLM Studio
                obsidian # Note-taking app
              ];

              # Shell Customization
              shellCustomization = [
                starship # Shell prompt
              ];

              # Zsh Specific Plugins
              zshPlugins = [
                zsh-autosuggestions
                zsh-completions
                zsh-history-substring-search
                zsh-syntax-highlighting
              ];

            in
            terminals
            ++ shellUtils
            ++ devTools
            ++ frameworks
            ++ languages
            ++ mediaTools
            ++ applications
            ++ shellCustomization
            ++ zshPlugins;

          homebrew = {
            enable = true;
            brews = [
              "mas"
              "swiftgen"
              "xcode-build-server"
              "xcbeautify"
              "zsh-completions"
              "zsh-abbr"
              "zsh-autosuggestions-abbreviations-strategy"
            ];
            casks = [
              "arc"
              "iina"
              "firefox"
              "figma"
              "aerospace"
              "wezterm"
              "gitbutler"
              "github"
              "github-copilot-for-xcode"
              "ollama" # LLM Manager"
              "playcover-community"
              "sf-symbols"
              "stats"
            ];
            taps = [
              "nikitabobko/tap"
              "olets/tap"
              "playcover/playcover"
            ];
            masApps = {
              "Xcode" = 497799835;
              "Twitter" = 1482454543;
              "Developer" = 640199958;
              "Keynote" = 409183694;
              "WeChat" = 836500024;
              "Wallpaper Play" = 1638457121;
              "Raycast Companion" = 6738274497;
              "Microsoft Excel" = 462058435;
              "TestFlight" = 899247664;
              "Pages" = 409201541;
              "Telegram" = 747648890;
              "Numbers" = 409203825;
              "Noir" = 1592917505;
            };
            onActivation.cleanup = "zap";
            onActivation.autoUpdate = true;
            onActivation.upgrade = true;
          };

          fonts.packages = with pkgs; [
            fira-code
            nerd-fonts.monaspace
            monaspace
          ];

          nix.settings.trusted-users = [ "wendell" ];
          services.nix-daemon.enable = true;

          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = 5;
          system.defaults = {

            NSGlobalDomain = {
              _HIHideMenuBar = false;

              # Enable press-and-hold repeating
              ApplePressAndHoldEnabled = false;
              InitialKeyRepeat = 10;
              KeyRepeat = 2;
            };

            dock = {
              orientation = "right";

              # Set dock to auto-hide, and transparentize icons of hidden apps (⌘H)
              autohide = true;
              showhidden = true;

              persistent-apps = [
                "/Applications/Nix Apps/Google Chrome.app"
                "/System/Applications/Messages.app"
                "/System/Applications/Mail.app"
                "/System/Applications/Music.app"
                "/System/Applications/System Settings.app"
                "/Applications/WezTerm.app"
              ];
            };

            finder = {
              # Disable warning when changing a file extension
              FXEnableExtensionChangeWarning = false;

              # Show all files and their extensions
              AppleShowAllExtensions = true;
              AppleShowAllFiles = true;

              # Show path bar, and layout as multi-column
              ShowPathbar = true;
              FXPreferredViewStyle = "clmv";

              # Search in current folder by default
              FXDefaultSearchScope = "SCcf";
            };

            trackpad = {
              # Enable trackpad tap to click
              Clicking = true;

              # Enable 3-finger drag
              TrackpadThreeFingerDrag = true;
            };

            ActivityMonitor = {
              # Sort by CPU usage
              SortColumn = "CPUUsage";
              SortDirection = 0;
            };

            CustomSystemPreferences = {
              NSGlobalDomain = {
                # Set the system accent color, TODO: https://github.com/LnL7/nix-darwin/pull/230
                AppleAccentColor = 6;
                # Jump to the spot that's clicked on the scroll bar, TODO: https://github.com/LnL7/nix-darwin/pull/672
                AppleScrollerPagingBehavior = true;
                # Prefer tabs when opening documents, TODO: https://github.com/LnL7/nix-darwin/pull/673
                AppleWindowTabbingMode = "always";
              };

            };

            CustomUserPreferences = {
              "com.apple.AdLib" = {
                # Disable personalized advertising
                forceLimitAdTracking = true;
                allowApplePersonalizedAdvertising = false;
                allowIdentifierForAdvertising = false;
              };

              "com.apple.finder" = {
                # Keep the desktop clean
                ShowHardDrivesOnDesktop = false;
                ShowRemovableMediaOnDesktop = false;
                ShowExternalHardDrivesOnDesktop = false;
                ShowMountedServersOnDesktop = false;

                # Show directories first
                _FXSortFoldersFirst = true; # TODO: https://github.com/LnL7/nix-darwin/pull/594

                # New window use the $HOME path
                NewWindowTarget = "PfHm";
                NewWindowTargetPath = "file://$HOME/";

                # Allow text selection in Quick Look
                QLEnableTextSelection = true;
              };

              "com.apple.dt.Xcode" = {
                # Disable macro validation
                IDESkipMacroFingerprintValidation = true;
                # Use the built-in source control management to fix SPM error
                # https://stackoverflow.com/a/78981529/10769660
                IDEPackageSupportUseBuiltinSCM = true;
              };
            };

          };

          nixpkgs.hostPlatform = "aarch64-darwin";
          nixpkgs.config.allowUnfree = true;
        };

      homeManagerConfiguration =
        { pkgs, config, ... }:
        {
          home = {
            username = "wendell";
            homeDirectory = /Users/wendell;
            stateVersion = "23.11";
          };
          home.file.".zshenv".text = ''
            source $HOME/.config/zsh/.zshenv
          '';
          programs.starship.enable = true;
          xdg.dataFile = with pkgs; {
            # Zsh plugins
            "zsh/zsh-autosuggestions".source = "${zsh-autosuggestions}/share/zsh-autosuggestions";
            "zsh/zsh-completions".source = "${zsh-completions}/share/zsh-completions";
            "zsh/zsh-history-substring-search".source =
              "${zsh-history-substring-search}/share/zsh-history-substring-search";
            "zsh/zsh-syntax-highlighting".source = "${zsh-syntax-highlighting}/share/zsh-syntax-highlighting";
            "zsh/fzf".source = "${fzf}/share/fzf";
          };
        };
    in
    {
      darwinConfigurations."base" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
          (
            { config, ... }:
            {
              homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
            }
          )
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              autoMigrate = true;
              user = "wendell";
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "homebrew/homebrew-bundle" = homebrew-bundle;
              };
            };
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.wendell = homeManagerConfiguration;
              extraSpecialArgs = { inherit inputs; };
            };
            users.users.wendell.home = /Users/wendell;
          }
        ];
      };

      darwinPackages = self.darwinConfigurations."base".pkgs;
    };
}
