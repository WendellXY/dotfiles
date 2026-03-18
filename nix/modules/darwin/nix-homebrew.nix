{ inputs, username }:
{ config, ... }:

{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  homebrew.taps = builtins.attrNames config.nix-homebrew.taps;

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
