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
    # Keep manual `brew install` / `brew upgrade` behavior available outside rebuilds.
    global.autoUpdate = true;
    # Make manual `brew bundle` use the Brewfile generated from this repo's
    # nix-darwin homebrew declarations instead of a separate checked-in file.
    global.brewfile = true;
    # Leave Homebrew state in the user's control during darwin-rebuild.
    onActivation.cleanup = "none";
    onActivation.autoUpdate = false;
    onActivation.upgrade = false;
  };
}
