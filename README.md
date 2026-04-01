# Configurations

Welcome to my dotfiles repository, a curated collection of configuration files tailored for macOS environments. These configurations streamline the setup of various development tools, ensuring a seamless and productive workspace. Leveraging a Makefile, this project simplifies the process of applying configurations by automatically creating the necessary symlinks for each tool.

## Installation

To apply all configurations and set up the environment as designed, navigate to the root directory of this project and execute:

```sh
make install
```

If you prefer to configure only specific tools or applications, you can do so by specifying the component's name in place of `<component>` in the following command:

```sh
make <component>
```

## Nix Homebrew Updates

This repo pins Homebrew itself and its declarative taps through `nix/flake.lock`, so `darwin-rebuild` only sees newer Homebrew formula/cask definitions after those inputs are refreshed.

To update the Homebrew-related flake inputs, run:

```sh
make nix-update-homebrew
```

Then run your usual `darwin-rebuild switch --flake ./nix#<config>` command to apply the newer pins.
