{
  nixpkgs,
  overlays,
  inputs,
}:

let
  # Common parameters
  username = "wendell";
  system = "aarch64-darwin";

  # Common modules that are shared between configurations
  commonModules = [
    ./modules/system.nix
    ./modules/fonts.nix

    inputs.nix-homebrew.darwinModules.nix-homebrew
    inputs.home-manager.darwinModules.home-manager

    # Homebrew tap configuration
    (
      { config, ... }:
      {
        homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
      }
    )

    # Home manager configuration
    (
      { pkgs, ... }@args:
      {
        users.users.${username}.home = /Users/${username};
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = false;
          users.${username} = import ./users/${username}.nix args;
        };
      }
    )

    # Nix settings and overlays
    (
      { pkgs, ... }:
      {
        nix.settings.trusted-users = [ username ];
        nixpkgs.config.allowUnfree = true;
        nixpkgs.overlays = overlays;
      }
    )

    # Nix-homebrew configuration
    {
      nix-homebrew = {
        enable = true;
        enableRosetta = true;
        autoMigrate = true;
        user = username;
        taps = {
          "homebrew/homebrew-core" = inputs.homebrew-core;
          "homebrew/homebrew-cask" = inputs.homebrew-cask;
          "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
        };
      };
    }
  ];

  # Function to create a darwin configuration with specific modules
  mkDarwinConfig =
    {
      extraModules ? [ ],
    }:
    inputs.nix-darwin.lib.darwinSystem {
      inherit system;
      modules = commonModules ++ extraModules;
    };

in
{
  inherit mkDarwinConfig;
}
