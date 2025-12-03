########################################
# 5. fzf 默认快捷键（Ctrl-R / Ctrl-T 等）
########################################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

########################################
# 6. CLI 工具 & alias
########################################
# zoxide
eval "$(zoxide init zsh)"

# eza / bat 等别名
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first'
alias la='eza -la --icons --group-directories-first'
alias cat='bat --style=plain --pager=never'
