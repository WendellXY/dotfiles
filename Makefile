BASE_DIR   :=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

${HOME}/.config:
	mkdir -p ${HOME}/.config

.PHONY: install brew nvim fish zsh starship

install: brew nvim fish zsh starship

# MARK: HomeBrew
brew:
    $(MAKE) -f brew/Makefile import

# MARK: neovim
nvim: | ${HOME}/.config/nvim
	@echo "NeoVim configuration installed"

${HOME}/.config/nvim: ${HOME}/.config
	ln -s ${BASE_DIR}/nvim ${HOME}/.config/nvim

# MARK: fish
fish: | ${HOME}/.config/fish
	@echo "Fish configuration installed"

${HOME}/.config/fish: ${HOME}/.config
	ln -s ${BASE_DIR}/fish ${HOME}/.config/fish

# MARK: zsh
zsh: | ${HOME}/.zshrc
	@echo "Zsh configuration installed"

${HOME}/.zshrc:
	ln -s ${BASE_DIR}/zsh/zshrc ${HOME}/.zshrc

# MARK: starship
starship: | ${HOME}/.config/starship
	@echo "Starship configuration installed"

${HOME}/.config/starship: ${HOME}/.config
	ln -s ${BASE_DIR}/starship ${HOME}/.config/starship
