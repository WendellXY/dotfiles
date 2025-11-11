{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    fira-code
    nerd-fonts.monaspace
    monaspace
    maple-mono.truetype
    maple-mono.NF-unhinted
    maple-mono.NF-CN-unhinted
  ];
}
