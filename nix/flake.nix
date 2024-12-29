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

    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nix-darwin, nixpkgs, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, home-manager, rust-overlay, ... }:
    let
      batOverlay = final: prev: {
        bat = final.callPackage ./pkgs/bat.nix { };
      };
    in
    {
      darwinConfigurations = {
        base = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./modules/system.nix

            ./modules/fonts.nix
            ./modules/homebrew.nix
            ./modules/packages.nix

            nix-homebrew.darwinModules.nix-homebrew
            home-manager.darwinModules.home-manager
            ({ config, ... }: {
              homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
            })
            ({ pkgs, ... } @ args: {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.wendell = import ./users/wendell.nix args;
              users.users.wendell.home = /Users/wendell;
            })
            ({ pkgs, ... }: {
              nix.settings.trusted-users = [ "wendell" ];
              services.nix-daemon.enable = true;

              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = [
                # neovim-overlay.overlay
                rust-overlay.overlays.default
                batOverlay
              ];
            })
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
            }
          ];
        };
      };
    };
}
