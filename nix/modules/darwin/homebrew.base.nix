{ ... }:

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
      "google-chrome"
    ];
    taps = [
      "nikitabobko/tap"
      "olets/tap"
    ];
    masApps = {
      "LocalSend" = 1661733229;
    };
    greedyCasks = true;
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
