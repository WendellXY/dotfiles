{
  description = "Tzeentch's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {

      nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget
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
        brews = [
          "mas"
        ];
        casks = [
          "iina"
          "firefox"
          "aerospace"
        ];
        taps = [
          "nikitabobko/tap"
        ];
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

      fonts.packages = [
        pkgs.monaspace
      ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.zsh.enable = true;
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#base
    darwinConfigurations."base" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "wendell";
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."base".pkgs;
  };
}
