#!/usr/bin/env bash
set -euo pipefail

# 触发安装node（利用之前brew安装好的nvm）
. "$(brew --prefix nvm)/nvm.sh"
nvm install --lts

# 禁止往SMB等远程目录写入.DS_Store
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
killall Finder

# cursor cli （社区反馈不优雅，等官方完善brew cask版本）
# curl https://cursor.com/install -fsS | bash

# openclaw （https://openclaw.ai/）需要用到的时候再安装
# curl -fsSL https://openclaw.ai/install.sh | bash
