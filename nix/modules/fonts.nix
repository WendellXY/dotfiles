{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    fira-code
    nerd-fonts.monaspace
    monaspace
  ];
}
