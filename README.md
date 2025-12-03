# macOS 新机器初始化指南

通过 Homebrew + chezmoi + dotfiles 一键完成新 Mac 的开发环境初始化。

> 仓库假定使用 1Password SSH Agent 管理 GitHub SSH 密钥。

## 0. 准备 1Password SSH Agent

1. 从官网使用 DMG 安装 1Password。
2. 启用 SSH Agent：
   - 1Password → Settings → Developer → Enable SSH Agent
3. 测试：
   ```bash
   ssh -T git@github.com
   ```

## 1. 安装 Xcode Command Line Tools

```bash
xcode-select --install
```

## 2. 安装 [Homebrew](https://brew.sh/)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> /Users/watchzerg/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/watchzerg/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update
```

## 3. 安装 chezmoi

```bash
brew install chezmoi
```

## 4. 初始化 chezmoi

```bash
chezmoi init --apply git@github.com:watchzerg/dotfiles.git
```

此命令会：

- 通过 SSH 从 GitHub 克隆 dotfiles
- 应用所有 dotfiles 至 HOME 目录
- 自动执行 run\_once\_\* 脚本（包含 brew bundle、字体安装等）

## 5. 后续维护

```bash
chezmoi cd
git add .
git commit -m "Initial commit"
git branch -M main # 仅首次
git remote add origin git@github.com:watchzerg/dotfiles.git # 仅首次
git push -u origin main # 仅首次
git push
```

