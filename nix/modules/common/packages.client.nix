{ lib, pkgs, ... }:

let
  basePackages = import ./packages.base.nix { inherit pkgs; };
in
{
  environment.systemPackages =
    basePackages.environment.systemPackages
    ++ (
      with pkgs;
      let
        shellUtils = [
          jq
          git-lfs
        ];

        devTools = [
          opencode
        ];

        languages = [
          swiftlint
        ];

        mediaTools = [
          pngquant
        ];

        applications = lib.optionals pkgs.stdenv.isDarwin [
          ice-bar
        ];
      in
      shellUtils ++ devTools ++ languages ++ mediaTools ++ applications
    );
}
