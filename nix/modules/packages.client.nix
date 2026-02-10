{ pkgs, ... }:

let
  basePackages = import ./packages.base.nix { inherit pkgs; };
in
{
  # Extend the base packages with client-specific packages
  environment.systemPackages =
    basePackages.environment.systemPackages
    ++ (
      with pkgs;
      let
        # Terminal Emulators
        terminals = [
          # iterm2
        ];

        # Additional Shell and Terminal Utilities
        shellUtils = [
          jq # JSON processor
          git-lfs # Git large file storage
        ];

        # Development Tools
        devTools = [
          zed
					claude-code
        ];

        # Programming Languages and Runtime
        languages = [
          swiftlint # Swift linter
        ];

        # Media Tools
        mediaTools = [
          pngquant # PNG image compression
        ];

        # Applications
        applications = [
          ice-bar # macOS menu bar app
        ];

      in
      terminals ++ shellUtils ++ devTools ++ languages ++ mediaTools ++ applications
    );
}
