.PHONY: brew brew-cli brew-cask brew-mas

doctor:
	@command -v chezmoi >/dev/null || { echo "chezmoi not found"; exit 1; }
	@command -v brew >/dev/null || { echo "brew not found"; exit 1; }
	@test -f "$(BREW_DIR)/Brewfile.cli" || { echo "$(BREW_DIR)/Brewfile.cli not found"; exit 1; }
	@test -f "$(BREW_DIR)/Brewfile.cask" || { echo "$(BREW_DIR)/Brewfile.cask not found"; exit 1; }
	@echo "Basic checks OK"

doctor-mas:
	@command -v mas >/dev/null || { echo "mas not found. Run: make brew-cli"; exit 1; }
	@test -f "$(BREW_DIR)/Brewfile.mas" || { echo "$(BREW_DIR)/Brewfile.mas not found"; exit 1; }
	@mas account >/dev/null || { echo "Not signed in to Mac App Store. Open App Store and sign in first."; exit 1; }
	@echo "MAS checks OK"

brew-cli:
	brew bundle --file=brew/Brewfile.cli

brew-cask:
	brew bundle --file=brew/Brewfile.cask

brew-mas:
	brew bundle --file=brew/Brewfile.mas
