{ pkgs, ... }:

let
  baseHomebrew = import ./homebrew.base.nix { inherit pkgs; };
in
{
  homebrew = baseHomebrew.homebrew // {
    brews = baseHomebrew.homebrew.brews ++ [
      "lima"
      "sourcery"
      "xcode-build-server"
    ];

    casks = baseHomebrew.homebrew.casks ++ [
      "android-platform-tools"
      # "claude-code" # Use shell script to install to catch the latest version: `curl -fsSL https://claude.ai/install.sh | bash`
      # "codex" # Install using npm: `npm install -g @openai/codex`
      "iina"
      "imageoptim"
      "figma"
      "github"
      "obsidian"
      # "ollama-app"
      "playcover-community"
      "sf-symbols"
      "visual-studio-code"
    ];

    taps = baseHomebrew.homebrew.taps ++ [
      "playcover/playcover"
      "0x1306a94/homebrew-tap"
    ];

    masApps = baseHomebrew.homebrew.masApps // {
      "WeChat" = 836500024;
      "Raycast Companion" = 6738274497;
      "TestFlight" = 899247664;
      "Pages" = 409201541;
      "Telegram" = 747648890;
      "Numbers" = 409203825;
    };
  };
}
