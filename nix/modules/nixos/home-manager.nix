{ inputs, username }:
{ ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    (import ../common/home-manager-shared.nix { inherit username; })
  ];
}
