{ config, lib, pkgs, ... }:

{
  home.stateVersion = "23.05";

  home.file.".zshenv".text = ''
    source $HOME/.config/zsh/.zshenv
  '';

  xdg.dataFile = with pkgs; {
    # Zsh plugins
    "zsh/zsh-autosuggestions".source = "${zsh-autosuggestions}/share/zsh-autosuggestions";
    "zsh/zsh-completions".source = "${zsh-completions}/share/zsh-completions";
    "zsh/zsh-history-substring-search".source = "${zsh-history-substring-search}/share/zsh-history-substring-search";
    "zsh/zsh-syntax-highlighting".source = "${zsh-syntax-highlighting}/share/zsh-syntax-highlighting";
    "zsh/fzf".source = "${fzf}/share/fzf";
  };

  programs.starship.enable = true;
}
