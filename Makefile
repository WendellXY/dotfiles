BASE_DIR   :=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

${HOME}/.config:
	mkdir -p ${HOME}/.config

.PHONY: install brew nvim nushell fish zsh starship alacritty wezterm kitty warp zed bat

install: brew nvim fish zsh starship

# MARK: nix
nix: | ${HOME}/.config/nix
	@echo "NeoVim configuration installed"

${HOME}/.config/nix: ${HOME}/.config
	ln -s ${BASE_DIR}/nix ${HOME}/.config/nix


# MARK: HomeBrew
brew:
	@brew bundle

# MARK: neovim
nvim: | ${HOME}/.config/nvim
	@echo "NeoVim configuration installed"

${HOME}/.config/nvim: ${HOME}/.config
	ln -s ${BASE_DIR}/nvim ${HOME}/.config/nvim

# MARK: nushell
nushell: | ${HOME}/Library/Application\ Support/nushell
	@echo "Nushell configuration installed"

${HOME}/Library/Application\ Support/nushell:
	ln -s "${BASE_DIR}/nushell" "${HOME}/Library/Application Support/"

nushell-linux: | ${HOME}/.config/nushell
	@echo "Nushell configuration installed"

${HOME}/.config/nushell:
	ln -s ${BASE_DIR}/nushell ${HOME}/.config/nushell

# MARK: fish
fish: | ${HOME}/.config/fish
	@echo "Fish configuration installed"

${HOME}/.config/fish: ${HOME}/.config
	ln -s ${BASE_DIR}/fish ${HOME}/.config/fish

# MARK: zsh
zsh: | ${HOME}/.zshenv ${HOME}/.config/zsh
	@echo "Zsh configuration installed"

${HOME}/.zshenv:
	ln -s ${BASE_DIR}/zsh/.zshenv ${HOME}/.zshenv

${HOME}/.config/zsh:
	ln -s ${BASE_DIR}/zsh ${HOME}/.config/zsh

# MARK: starship
starship: | ${HOME}/.config/starship
	@echo "Starship configuration installed"

${HOME}/.config/starship: ${HOME}/.config
	ln -s ${BASE_DIR}/starship ${HOME}/.config/starship

# MARK: starship
atuin: | ${HOME}/.config/atuin
	@echo "Atuin configuration installed"

${HOME}/.config/atuin:: ${HOME}/.config
	ln -s ${BASE_DIR}/atuin ${HOME}/.config/atuin

# MARK: alacritty
alacritty: | ${HOME}/.config/alacritty
	@echo "Alacritty configuration installed"

${HOME}/.config/alacritty: ${HOME}/.config
	ln -s ${BASE_DIR}/alacritty ${HOME}/.config/alacritty

# MARK: WezTerm
wezterm: | ${HOME}/.config/wezterm
	@echo "WezTerm configuration installed"

${HOME}/.config/wezterm: ${HOME}/.config
	ln -s ${BASE_DIR}/wezterm ${HOME}/.config/wezterm

# MARK: kitty
kitty: | ${HOME}/.config/kitty
	@echo "WezTerm configuration installed"

${HOME}/.config/kitty: ${HOME}/.config
	ln -s ${BASE_DIR}/kitty ${HOME}/.config/kitty

# MARK: warp
warp: | ${HOME}/.warp
	@echo "Warp configuration installed"

${HOME}/.warp:
	ln -s ${BASE_DIR}/warp ${HOME}/.warp

# MARK: Ghostty
ghostty: | ${HOME}/.config/ghostty
	@echo "Ghostty configuration installed"

${HOME}/.config/ghostty: ${HOME}/.config
	ln -s ${BASE_DIR}/ghostty ${HOME}/.config/ghostty

# MARK: Zed
zed: | ${HOME}/.config/zed
	@echo "Zed configuration installed"

${HOME}/.config/zed: ${HOME}/.config
	ln -s ${BASE_DIR}/zed ${HOME}/.config/zed

# MARK: bat
bat: | ${HOME}/.config/bat
	@echo "Bat configuration installed"

${HOME}/.config/bat: ${HOME}/.config
	ln -s ${BASE_DIR}/bat ${HOME}/.config/bat

# MARK: yazi
yazi: | ${HOME}/.config/yazi
	@echo "Yazi configuration installed"

${HOME}/.config/yazi: ${HOME}/.config
	ln -s ${BASE_DIR}/yazi ${HOME}/.config/yazi

# MARK: sketchybar
sketchybar: | ${HOME}/.config/sketchybar
	@echo "SketchyBar configuration installed"

${HOME}/.config/sketchybar: ${HOME}/.config
	ln -s ${BASE_DIR}/sketchybar ${HOME}/.config/sketchybar

# MARK: aerospace
aerospace: | ${HOME}/.config/aerospace
	@echo "Aerospace configuration installed"

${HOME}/.config/aerospace: ${HOME}/.config
	ln -s ${BASE_DIR}/aerospace ${HOME}/.config/aerospace

# MARK: yabai
yabai: | ${HOME}/.config/yabai
	@echo "Yabai configuration installed"

${HOME}/.config/yabai: ${HOME}/.config
	ln -s ${BASE_DIR}/yabai ${HOME}/.config/yabai

# MARK: tmux
tmux: | ${HOME}/.config/tmux
	@echo "Tmux configuration installed"

${HOME}/.config/tmux: ${HOME}/.config
	ln -s ${BASE_DIR}/tmux ${HOME}/.config/tmux
