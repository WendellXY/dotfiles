{ overlays, username }:
{ pkgs, ... }:

let
  lix =
    if pkgs.stdenv.hostPlatform.isDarwin then
      # Lix 2.94.1 has flaky installCheck failures on Darwin; keep the same
      # runtime version but skip the packaging test phase locally.
      pkgs.lixPackageSets.stable.lix.overrideAttrs (_: {
        doInstallCheck = false;
      })
    else
      pkgs.lixPackageSets.stable.lix;
in
{
  nix.package = lix;
  nix.settings.trusted-users = [ username ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = overlays;
}
