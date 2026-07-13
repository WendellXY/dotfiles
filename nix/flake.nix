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
          opencode =
            (inputs.opencode.packages.${prev.stdenv.hostPlatform.system}.default).overrideAttrs
              (oldAttrs: {
                nativeBuildInputs =
                  (oldAttrs.nativeBuildInputs or [ ])
                  ++ final.lib.optionals final.stdenv.hostPlatform.isDarwin [
                    final.darwin.autoSignDarwinBinariesHook
                  ];

                postPatch =
                  (oldAttrs.postPatch or "")
                  + final.lib.optionalString final.stdenv.hostPlatform.isDarwin ''
                    # Bun's compiled binary is not validly signed until the Darwin
                    # fixup hook runs. Keep the later versionCheckHook as the runtime
                    # smoke test after autoSignDarwinBinariesHook has re-signed it.
                    substituteInPlace packages/opencode/script/build.ts \
                      --replace-fail \
                        'if (item.os === process.platform && item.arch === process.arch && !item.abi) {' \
                        'if (false && item.os === process.platform && item.arch === process.arch && !item.abi) {'
                  '';

                postInstall =
                  final.lib.optionalString final.stdenv.hostPlatform.isDarwin ''
                    # Completion generation executes the wrapped binary before the
                    # normal fixup phase, so it also needs a valid signature here.
                    signIfRequired "$out/bin/.opencode-wrapped"
                  ''
                  + (oldAttrs.postInstall or "");
              });
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
