{ username }:
{ ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = false;
    users.${username} = import ../../users/${username}.nix;
  };
}
