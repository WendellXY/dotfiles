{ inputs, username }:
{ ... }:

{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    (import ../common/home-manager-shared.nix { inherit username; })
  ];

  users.users.${username}.home = "/Users/${username}";
}
