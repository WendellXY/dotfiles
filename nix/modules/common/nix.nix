{ overlays, username }:
{ pkgs, ... }:

{
  nix.package = pkgs.lixPackageSets.stable.lix;
  nix.settings.trusted-users = [ username ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = overlays;
}
