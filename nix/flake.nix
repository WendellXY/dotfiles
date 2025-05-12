{
  description = "Tzeentch's nix-darwin system flake with Home Manager";

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
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      homebrew-bundle,
      home-manager,
      ...
    }@inputs:
    let
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
        inputs.rust.overlays.default
        (final: prev: {
          bat = final.callPackage ./pkgs/bat.nix { };
        })
      ];

      mkSystem = import ./mksystem.nix {
        inherit overlays nixpkgs inputs;
      };
    in
    {
      darwinConfigurations.base = mkSystem.mkDarwinConfig {
        extraModules = [
          ./modules/homebrew.base.nix
          ./modules/packages.base.nix
        ];
      };
      darwinConfigurations.client = mkSystem.mkDarwinConfig {
        extraModules = [
          ./modules/homebrew.client.nix
          ./modules/packages.client.nix
        ];
      };
    };
}
