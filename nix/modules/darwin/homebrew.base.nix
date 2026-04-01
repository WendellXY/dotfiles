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
    # Keep manual `brew install` / `brew upgrade` behavior aligned with activation.
    global.autoUpdate = true;
    # These keep installed formulae and casks current once the pinned Homebrew
    # inputs in flake.lock have been refreshed.
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
