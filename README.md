# macOS 新机器初始化指南

通过 Homebrew + chezmoi + dotfiles 一键完成新 Mac 的开发环境初始化。

## 1. 安装 Xcode Command Line Tools 和 Homebrew
```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> "$HOME/.zprofile"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
```

## 2. 安装和应用chezmoi

```bash
brew install chezmoi
chezmoi init -apply https://github.com/watchzerg/dotfiles.git # 公开仓库，不要提交api-key等
```

## 3. 用brew安装其它软件
```bash
chezmoi cd
make doctor
make brew-cli
make brew-cask
# 需要先登录 Mac App Store
make doctor-mas
make brew-mas
```

# 维护

## 1. 更新Brewfile（例如安装了新软件）
```bash
chezmoi cd
$EDITOR brew/Brewfile.cli # 或者 Brewfile.cask Brewfile.mas
git diff
git status
make brew-cli
```

## 2. 更新chezmoi里的配置

```bash
chezmoi cd # 进入目录后
chezmoi edit ~/.zshrc # 修改对应的文件
chezmoi apply # 应用修改的文件
```

## 3. chezmoi的变更提交到github

```bash
chezmoi cd
git diff --cached
git add .
git commit -m "Update configuration"
git remote set-url origin git@github.com:watchzerg/dotfiles.git # 从http转为git方便使用sshkey
git push
```
