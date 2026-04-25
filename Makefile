.PHONY: doctor doctor-mas doctor-init fix-permissions brew brew-cli brew-cask brew-mas init-script

BREW_DIR := ./brew
INIT_SCRIPT := ./scripts/init.sh
SCRIPTS := $(INIT_SCRIPT)

doctor:
	@command -v chezmoi >/dev/null || { echo "chezmoi not found"; exit 1; }
	@command -v brew >/dev/null || { echo "brew not found"; exit 1; }
	@test -f "$(BREW_DIR)/Brewfile.cli" || { echo "$(BREW_DIR)/Brewfile.cli not found"; exit 1; }
	@test -f "$(BREW_DIR)/Brewfile.cask" || { echo "$(BREW_DIR)/Brewfile.cask not found"; exit 1; }
	@echo "Basic checks OK"

doctor-mas: doctor
	@command -v mas >/dev/null || { echo "mas not found. Run: make brew-cli"; exit 1; }
	@test -f "$(BREW_DIR)/Brewfile.mas" || { echo "$(BREW_DIR)/Brewfile.mas not found"; exit 1; }
	@echo "MAS checks OK"

doctor-init:
	@test -f "$(INIT_SCRIPT)" || { echo "$(INIT_SCRIPT) not found"; exit 1; }
	@test -x "$(INIT_SCRIPT)" || { echo "$(INIT_SCRIPT) is not executable. Run: make fix-permissions"; exit 1; }
	@echo "init-script checks OK"

brew: brew-cli brew-cask

brew-cli: doctor
	brew bundle --file="$(BREW_DIR)/Brewfile.cli"

brew-cask: doctor
	brew bundle --file="$(BREW_DIR)/Brewfile.cask"

brew-mas: doctor-mas
	brew bundle --file="$(BREW_DIR)/Brewfile.mas"

fix-permissions:
	@for script in $(SCRIPTS); do \
		test -f "$$script" || { echo "$$script not found"; exit 1; }; \
		chmod +x "$$script"; \
	done

init-script: doctor-init
	"$(INIT_SCRIPT)"
