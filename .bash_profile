# 定义字符颜色
CYAN="\[\033[1;36m\]"
YELLOW="\[\033[1;33m\]"
GREEN="\[\033[32m\]"
RED="\[\033[1;31m\]"
RESET="\[\033[0m\]"

# 检查 Git 工作区是否有未提交更改
git_status_dirty() {
  if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
    echo " ✗"
  fi
}

# 设置 PS1
export PS1="${CYAN}\W${RESET}\$(__git_ps1 ' ${YELLOW}on ${GREEN}%s${RESET}')${RED}\$(git_status_dirty)${RESET} > "
