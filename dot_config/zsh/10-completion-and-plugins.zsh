########################################
# 1. 补全系统 (completion)
########################################
# Homebrew 提供的补全路径，必须在 compinit 前加入 fpath
fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)

# 补全行为配置（在 compinit 前）
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

########################################
# 2. Zinit & 插件
########################################
# 用 brew 安装的 Zinit
source "$HOMEBREW_PREFIX/opt/zinit/zinit.zsh"

# ===== 补全插件：必须在 compinit 前加载，且不要 wait =====
zinit ice lucid
zinit light zsh-users/zsh-completions

# 初始化补全（使用缓存）
autoload -Uz compinit
compinit -C

# ===== fzf-tab（建议 compinit 后）=====
zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# ===== 交互增强插件 =====
# autosuggestions：输入联想
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

# syntax-highlighting：必须最后加载避免冲突
zinit ice wait lucid atload"zle reset-prompt"
zinit light zsh-users/zsh-syntax-highlighting
