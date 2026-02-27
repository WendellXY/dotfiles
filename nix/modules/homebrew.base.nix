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
      "claude-code"
    ];
    taps = [
      "nikitabobko/tap"
      "olets/tap"
    ];
    masApps = {
      "LocalSend" = 1661733229;
    };
    # Upgrade casks even if they are self-updating or unversioned.
    greedyCasks = true;
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
