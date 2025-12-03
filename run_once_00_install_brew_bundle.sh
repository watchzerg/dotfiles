#!/usr/bin/env bash
# chezmoi: run_once
# 用于在首次 `chezmoi apply` 时，根据 Brewfile 安装 CLI / Cask / MAS 应用。

set -euo pipefail

# chezmoi 在执行脚本时会提供 $CHEZMOI_SOURCE_DIR
CHEZMOI_SOURCE_DIR=${CHEZMOI_SOURCE_DIR:-"$HOME/.local/share/chezmoi"}
BREW_DIR="$CHEZMOI_SOURCE_DIR/brew"
cd "$CHEZMOI_SOURCE_DIR"

########################################
# 1. CLI formula（不涉及 GUI）
########################################

brew bundle --file="$BREW_DIR/Brewfile.cli"

########################################
# 2. Cask 应用（GUI / 字体等）
########################################

brew bundle --file="$BREW_DIR/Brewfile.cask"

########################################
# 3. MAS 应用（通过 mas CLI 安装）
########################################

brew bundle --file="$BREW_DIR/Brewfile.mas"

########################################
# 4. fzf Keybindings + Completion
########################################

"$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc