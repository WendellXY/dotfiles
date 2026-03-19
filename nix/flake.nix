{
  description = "Tzeentch's multi-platform Nix flake with nix-darwin, NixOS, and Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    rust.url = "github:oxalica/rust-overlay";
    opencode.url = "github:anomalyco/opencode";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      username = "wendell";

      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
        inputs.rust.overlays.default
        (final: prev: {
          bat = final.callPackage ./pkgs/bat.nix { };
        })
      ];

      mkSystem = import ./mksystem.nix {
        inherit inputs nixpkgs;
      };

      commonNixModule = import ./modules/common/nix.nix {
        inherit overlays username;
      };

      commonFontsModule = ./modules/common/fonts.nix;

      darwinHomeManagerModule = import ./modules/darwin/home-manager.nix {
        inherit inputs username;
      };

      darwinNixHomebrewModule = import ./modules/darwin/nix-homebrew.nix {
        inherit inputs username;
      };

      nixosHomeManagerModule = import ./modules/nixos/home-manager.nix {
        inherit inputs username;
      };

      nixosUserModule = import ./modules/nixos/user.nix {
        inherit username;
      };

      darwinBaseModule = {
        imports = [
          commonNixModule
          commonFontsModule
          darwinHomeManagerModule
          darwinNixHomebrewModule
          ./modules/darwin/system.nix
          ./modules/darwin/homebrew.base.nix
          ./modules/common/packages.base.nix
        ];
      };

      darwinClientModule = {
        imports = [
          commonNixModule
          commonFontsModule
          darwinHomeManagerModule
          darwinNixHomebrewModule
          ./modules/darwin/system.nix
          ./modules/darwin/homebrew.client.nix
          ./modules/common/packages.client.nix
        ];
      };

      nixosBaseModule = {
        imports = [
          commonNixModule
          commonFontsModule
          nixosHomeManagerModule
          nixosUserModule
          ./modules/nixos/system.nix
          ./modules/common/packages.base.nix
        ];
      };

      nixosClientModule = {
        imports = [
          commonNixModule
          commonFontsModule
          nixosHomeManagerModule
          nixosUserModule
          ./modules/nixos/system.nix
          ./modules/common/packages.client.nix
        ];
      };
    in
    {
      darwinConfigurations.base = mkSystem.mkDarwinConfig {
        modules = [ darwinBaseModule ];
      };

      darwinConfigurations.client = mkSystem.mkDarwinConfig {
        modules = [ darwinClientModule ];
      };

      nixosModules.base = nixosBaseModule;
      nixosModules.client = nixosClientModule;

      nixosConfigurations.base = mkSystem.mkNixosConfig {
        modules = [ nixosBaseModule ];
      };

      nixosConfigurations.client = mkSystem.mkNixosConfig {
        modules = [ nixosClientModule ];
      };
    };
}
