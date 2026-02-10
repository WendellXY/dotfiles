{ pkgs, ... }:

let
  baseHomebrew = import ./homebrew.base.nix { inherit pkgs; };
in
{
  homebrew = baseHomebrew.homebrew // {
    # Development tools for your daily work
    brews = baseHomebrew.homebrew.brews ++ [
      "sourcery"
      "xcode-build-server"
    ];

    # Additional applications for daily work
    casks = baseHomebrew.homebrew.casks ++ [
      "alt-tab"
      "android-platform-tools"
      "arc"
			"codex"
      "iina"
      "imageoptim"
      "figma"
      "google-chrome"
      "github"
      "github-copilot-for-xcode"
      "obsidian"
      "ollama-app"
      "playcover-community"
      "sf-symbols"
      "stats"
      "visual-studio-code"
    ];

    # Additional taps for development tools
    taps = baseHomebrew.homebrew.taps ++ [
      "playcover/playcover"
      "0x1306a94/homebrew-tap"
    ];

    # Work and development related apps
    masApps = baseHomebrew.homebrew.masApps // {
      # "Xcode" = 497799835;
      # "Twitter" = 1482454543;
      # "Developer" = 640199958;
      # "Keynote" = 409183694;
      "WeChat" = 836500024;
      "Raycast Companion" = 6738274497;
      "TestFlight" = 899247664;
      "Pages" = 409201541;
      "Telegram" = 747648890;
      "Numbers" = 409203825;
      # "Noir" = 1592917505;
    };
  };
}
