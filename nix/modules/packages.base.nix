{ pkgs, ... }:

{
  # Packages to install in system profile
  environment.systemPackages =
    with pkgs;
    let
      # Shell and Terminal Utilities
      shellUtils = [
        bat # Better cat
        delta # Better git diff
        eza # Modern ls replacement
        fastfetch # Fast system information
        fd # Better find
        fzf # Fuzzy finder
        git # Version control
        jq # JSON processor
        lazygit # Git client
        nix-prefetch-git # Script used to obtain source hashes for fetchgit
        nix-prefetch-github # Script used to obtain source hashes for fetchFromGitHub
        ripgrep # Better grep
        tldr # Simplified man pages
        tmux # Terminal multiplexer
        tree-sitter # Parser generator tool
        yazi # File manager
        zoxide # Smarter cd command
      ];

      # Minimal Development Tools
      devTools = [
        cmake # Build system
        cocoapods # iOS dependency manager
        meson # Build system
        neovim # Text editor
        pipx # Python package installer
        fastlane # iOS deployment automation
      ];

      # Frameworks
      frameworks = [
        libarchive # Archive library
        libyaml # YAML parser
      ];

      # Basic Programming Languages
      languages = [
        go
        lua
        luajit
        nil # nix language server
        nixfmt-rfc-style
        nixpkgs-fmt # Nix code formatter
        nodejs
        python3
        ruby_3_3
        zig
        rustup # Rust toolchain installer
      ];

      # Media Tools
      mediaTools = [
        ffmpeg
        ffmpegthumbnailer
        imagemagick # Image manipulation
      ];

      # Shell Customization
      shellCustomization = [
        starship # Shell prompt
      ];

      # Zsh Specific Plugins
      zshPlugins = [
        zsh-autosuggestions
        zsh-completions
        zsh-history-substring-search
        zsh-syntax-highlighting
      ];

    in
    shellUtils
    ++ devTools
    ++ frameworks
    ++ languages
    ++ mediaTools
    ++ shellCustomization
    ++ zshPlugins;
}
