########################################
# 3. Prompt: Starship
########################################
eval "$(starship init zsh)"

########################################
# 4. Shell 行为 & 历史记录
########################################
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
set -o pipefail

# less 默认行为（允许颜色）
export LESS='-R'
