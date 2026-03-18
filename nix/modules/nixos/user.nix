{ username }:
{ lib, ... }:

{
  users.users.${username} = {
    isNormalUser = lib.mkDefault true;
    createHome = lib.mkDefault true;
    home = lib.mkDefault "/home/${username}";
    extraGroups = lib.mkDefault [ "wheel" ];
  };
}
