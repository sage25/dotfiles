#!/bin/bash
set -e

echo "Start downloading NVM"

NVM_DIR="$HOME/.nvm"

# 如果 NVM 已存在，跳过安装，但需要确保它被加载到当前 shell
if [ -s "$NVM_DIR/nvm.sh" ]; then
    echo "NVM already installed, loading..."
else
    echo "Installing NVM..."
    # 保留错误输出，让用户看到问题
    NVM_LATEST=$(wget -qO- https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep -o '"tag_name": "[^"]*' | cut -d'"' -f4)
    if [ -z "$NVM_LATEST" ]; then
        echo "Error: Failed to fetch latest NVM version from GitHub API" >&2
        exit 1
    fi
    # 下载并执行安装脚本，保留错误输出
    wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_LATEST}/install.sh" | bash
    echo "NVM installed successfully"
fi

# 加载 NVM（若已存在则重新加载）
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# 验证 NVM 是否可用
if ! command -v nvm &>/dev/null; then
    echo "Error: NVM not available after installation" >&2
    exit 1
fi

# 安装 Node.js LTS（保留部分输出，方便查看进度）
if ! nvm install --lts; then
    echo "Error: Failed to install Node.js LTS" >&2
    exit 1
fi

echo "NVM installation completed"

# 处理交互式切换
# 若在 CI 或非交互环境下，设置默认行为（如 NVM_AUTO_SWITCH=yes）
if [ -t 0 ] && [ -z "$CI" ]; then
    read -p "Do you want to switch to the LTS version of Node.js? (y/n) :> " answer
    case "$answer" in
        [Yy]* )
            if nvm use --lts && nvm alias default lts/*; then
                echo "Switched to LTS and set as default."
            else
                echo "Warning: Failed to switch or set default" >&2
            fi
            ;;
        * )
            echo "No switch. You can manually run 'nvm use --lts' later."
            ;;
    esac
else
    # 非交互环境默认不切换，或者根据环境变量决定
    echo "Non-interactive mode, skipping switch."
fi
