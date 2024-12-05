{
  description = "Tzeentch's nix-darwin system flake with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;

      # Packages to install in system profile
      environment.systemPackages = with pkgs; let 
        general = [ 
          alacritty
          eza
          delta
          fd
          fzf
          neovim
          obsidian
          tmux
          atuin
          starship
          ripgrep
          zoxide
        ];

        zshPlugins = [
          zsh-autosuggestions
          zsh-completions
          zsh-history-substring-search
          zsh-syntax-highlighting
        ];
      in general ++ zshPlugins;

      homebrew = {
        enable = true;
        brews = [ "mas" ];
        casks = [ "iina" "firefox" "aerospace" ];
        taps = [ "nikitabobko/tap" ];
        masApps = {
          "Xcode"             = 497799835;
          "Twitter"           = 1482454543;
          "Developer"         = 640199958;
          "Keynote"           = 409183694;
          "WeChat"            = 836500024;
          "Wallpaper Play"    = 1638457121;
          "Raycast Companion" = 6738274497;
          "Microsoft Excel"   = 462058435;
          "TestFlight"        = 899247664;
          "Pages"             = 409201541;
          "Telegram"          = 747648890;
          "Numbers"           = 409203825;
          "Noir"              = 1592917505;
        };
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      fonts.packages = [ pkgs.monaspace ];

      nix.settings.experimental-features = "nix-command flakes";

      programs.zsh.enable = true;
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;

      nixpkgs.hostPlatform = "aarch64-darwin";
    };

    homeManagerConfiguration = { pkgs, ... }: {
      # Home Manager configuration
      home.username = "wendell";
      home.homeDirectory = "/Users/wendell";

      # Example Home Manager modules and configurations
      programs.starship.enable = true;
      programs.git = {
        enable = true;
        userEmail = "root@tzeentch.io";
        userName = "WendellXY";
      };
    };
  in
  {
    darwinConfigurations."base" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        home-manager.nixosModules.home-manager
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "wendell";
          };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ];
    };

    # Expose Home Manager as a flake output for convenience
    # homeConfigurations = {
    #   "wendell" = home-manager.lib.homeManagerConfiguration {
    #     modules = [ homeManagerConfiguration ];
    #     pkgs = inputs.nixpkgs;
    #   };
    # };

    darwinPackages = self.darwinConfigurations."base".pkgs;
  };
}
