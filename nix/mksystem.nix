{
  inputs,
  nixpkgs,
}:

{
  mkDarwinConfig =
    {
      modules,
      system ? "aarch64-darwin",
    }:
    inputs.nix-darwin.lib.darwinSystem {
      inherit modules system;
    };

  mkNixosConfig =
    {
      modules,
      system ? "aarch64-linux",
    }:
    nixpkgs.lib.nixosSystem {
      inherit modules system;
    };
}
