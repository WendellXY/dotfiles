{ pkgs, ... }:

{
  # Packages to install in system profile
  environment.systemPackages =
    with pkgs;
    let
      # Shell and Terminal Utilities
      shellUtils = [
        atuin # Shell history management
        bat # Better cat
        delta # Better git diff
        eza # Modern ls replacement
        fastfetch # Fast system information
        fd # Better find
        fzf # Fuzzy finder
        gh # GitHub CLI
        git # Version control
        lazygit # Git client
        nix-prefetch-git # Script used to obtain source hashes for fetchgit
        nix-prefetch-github # Script used to obtain source hashes for fetchFromGitHub
        nushell # Shell replacement
        ripgrep # Better grep
        tldr # Simplified man pages
        tmux # Terminal multiplexer
        tree-sitter # Parser generator tool
        vivid # Generator for LS_COLORS with support for multiple color themes
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
        pnpm # Package manager for JS/TS
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
        nixfmt
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
    shellUtils ++ devTools ++ frameworks ++ languages ++ mediaTools ++ shellCustomization ++ zshPlugins;
}
