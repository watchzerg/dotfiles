# macOS 新机器初始化指南

通过 Homebrew + chezmoi + dotfiles 一键完成新 Mac 的开发环境初始化。

## 1. 安装 Xcode Command Line Tools 和 Homebrew

```bash
xcode-select --install

# 安装homebrew（https://brew.sh/），并按提示执行后续的几行配置命令
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 安装Ghostty，后续不就再需要Terminal了
brew install --cask ghostty
```

## 2. 安装和应用chezmoi

```bash
brew install chezmoi
chezmoi init --apply git@github.com:watchzerg/dotfiles.git
```

## 3. 用brew安装其它软件（这里不希望走chezmoi的run_once，还是手工执行可靠些）

```bash
chezmoi cd

# 第1步，命令行工具与cask
make doctor
brew bundle check --file=brew/Brewfile.cli --verbose
make brew-cli
exec zsh -l # 刷新shell，启用新安装的各种工具
brew bundle check --file=brew/Brewfile.cask --verbose
make brew-cask

# 第2步：Mac App Store 应用（需要先登录）
make doctor-mas
brew bundle check --file=brew/Brewfile.mas --verbose
make brew-mas

# 第3步，第三方厂商脚本（例如Claude Code）
make doctor-init
make fix-init-permission # 脚本加执行权限，通常不需要
make init-script
```

# 维护

## 1. 更新Brewfile（例如安装了新软件）

```bash
chezmoi cd

# 当前系统中安装的formula，哪些不在Brewfile.cli里
comm -23 <(brew leaves | sort) <(brew bundle list --file=./brew/Brewfile.cli --formula | sort)
$EDITOR brew/Brewfile.cli
make brew-cli

# 当前系统中安装的cask，哪些不在Brewfile.cask里
comm -23 <(brew list --cask | sort) <(brew bundle list --file=./brew/Brewfile.cask --cask | sort)
$EDITOR brew/Brewfile.cask
make brew-cask

# 当前系统中安装的cask，哪些不在Brewfile.mas里
mas list | awk '{print $1 "\t" $0}' | sort > /tmp/mas-installed.tsv; \
comm -23 \
  <(cut -f1 /tmp/mas-installed.tsv) \
  <(ruby -e 'def mas(name,id:,**opts); puts id; end; eval(File.read(ARGV[0]))' ./brew/Brewfile.mas | sort) \
| while read id; do awk -F'\t' -v id="$id" '$1 == id {print $2}' /tmp/mas-installed.tsv; done
$EDITOR brew/Brewfile.mas
make brew-mas
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
git push
```
