{ pkgs, ... }:

{
  environment.systemPackages =
    with pkgs;
    let
      shellUtils = [
        atuin
        bat
        delta
        eza
        fastfetch
        fd
        fzf
        gh
        git
        lazygit
        nix-prefetch-git
        nix-prefetch-github
        ripgrep
        tldr
        tmux
        tree-sitter
        vivid
        yazi
        zoxide
      ];

      devTools = [
        cmake
        cocoapods
        meson
        neovim
        pipx
        pnpm
        fastlane
      ];

      frameworks = [
        libarchive
        libyaml
      ];

      languages = [
        go
        lua
        luajit
        nil
        nixfmt
        nodejs
        python3
        ruby_3_3
        zig
        rustup
      ];

      mediaTools = [
        ffmpeg
        ffmpegthumbnailer
        imagemagick
      ];

      shellCustomization = [
        starship
      ];

      zshPlugins = [
        zsh-autosuggestions
        zsh-completions
        zsh-history-substring-search
        zsh-syntax-highlighting
      ];
    in
    shellUtils ++ devTools ++ frameworks ++ languages ++ mediaTools ++ shellCustomization ++ zshPlugins;
}
