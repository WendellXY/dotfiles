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

    zig.url = "github:mitchellh/zig-overlay";
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
        inputs.zig.overlays.default
        (final: prev: {
          zig = final.zigpkgs.master;
          opencode = inputs.opencode.packages.${prev.stdenv.hostPlatform.system}.default;
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
