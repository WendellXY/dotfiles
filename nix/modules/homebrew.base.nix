{ pkgs, ... }:

{
  homebrew = {
    enable = true;
    brews = [
      "mas"
      "swiftgen"
      "tencent-mars-xlog-util"
      "xcbeautify"
      "zsh-completions"
      "zsh-abbr"
      "zsh-autosuggestions-abbreviations-strategy"
    ];
    casks = [
      "firefox"
    ];
    taps = [
      "nikitabobko/tap"
      "olets/tap"
    ];
    masApps = {
      "LocalSend" = 1661733229;
    };
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
