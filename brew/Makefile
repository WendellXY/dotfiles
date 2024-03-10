# Makefile for exporting and importing Homebrew packages

# Filenames for the package lists
FORMULAS_LIST := brew.formulas.txt
CASKS_LIST := brew.casks.txt
TAPS_LIST := brew.taps.txt

.PHONY: export import clean _check-brew

# Export installed formulas, casks and taps to separate files
export: _check-brew
	@echo "Exporting list of installed Homebrew formulas, casks and taps..."
	@brew leaves --installed-on-request > $(FORMULAS_LIST)
	@brew list --cask > $(CASKS_LIST)
	@brew tap > $(TAPS_LIST)
	@echo "Export complete. Files created: $(FORMULAS_LIST), $(CASKS_LIST)"

# Import formulas, casks and taps from the exported files
import: _check-brew
	@echo "Importing Homebrew formulas from $(FORMULAS_LIST)..."
	@xargs brew install < $(FORMULAS_LIST)
	@echo "Importing Homebrew casks from $(CASKS_LIST)..."
	@xargs brew install --cask < $(CASKS_LIST)
	@echo "Importing Homebrew taps from $(TAPS_LIST)..."
	@xargs xargs brew tap < $(TAPS_LIST)
	@echo "Import complete."

# Clean generated files from export
clean:
	@echo "Cleaning generated files."
	@rm $(FORMULAS_LIST)
	@rm $(CASKS_LIST)
	@rm $(TAPS_LIST)
	@echo "Clean complete. Files removed: $(FORMULAS_LIST), $(CASKS_LIST), $(TAPS_LIST)"


# Check for Homebrew installation, update if exists, otherwise install
_check-brew:
	@which brew > /dev/null; \
	if [ $$? -eq 0 ]; then \
		echo "Homebrew is installed, updating..."; \
		brew update; \
	else \
		echo "Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi
