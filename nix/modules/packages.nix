{ pkgs, ... }:

{
  # Packages to install in system profile
  environment.systemPackages =
    with pkgs;
    let
      # Terminal Emulators
      terminals = [
        alacritty
        iterm2
        kitty
      ];

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
        git-lfs # Git large file storage
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

      # Development Tools
      devTools = [
        cmake # Build system
        cocoapods # iOS dependency manager
        meson # Build system
        pipx # Python package installer
        fastlane # iOS deployment automation
        neovim # Text editor
        vscode
        zed
      ];

      # Frameworks
      frameworks = [
        libarchive # Archive library
        libyaml # YAML parser
      ];

      # Programming Languages and Runtime
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
        swiftlint # Swift linter
      ];

      # Media Tools
      mediaTools = [
        ffmpeg
        ffmpegthumbnailer
        imagemagick # Image manipulation
				pngquant # PNG image compression
      ];

      # Applications
      applications = [
        alt-tab-macos # Better app switcher
        google-chrome # Web browser
        ice-bar # macOS menu bar app
        lmstudio # LLM Studio
        obsidian # Note-taking app
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
    terminals
    ++ shellUtils
    ++ devTools
    ++ frameworks
    ++ languages
    ++ mediaTools
    ++ applications
    ++ shellCustomization
    ++ zshPlugins;
}
