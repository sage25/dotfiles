#!/bin/bash
set -e

NVM_DIR="$HOME/.nvm"

echo "Installing NVM..."

bash $LINUXDIR/PM/PM.sh wget

if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    NVM_LATEST=$(wget -qO- \
        https://api.github.com/repos/nvm-sh/nvm/releases/latest |
        grep -o '"tag_name": "[^"]*' |
        cut -d'"' -f4)

    if [ -z "$NVM_LATEST" ]; then
        echo "Error: Failed to get latest NVM version" >&2
        exit 1
    fi

    wget -qO- \
        "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_LATEST}/install.sh" |
        bash >/dev/null
fi

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

if ! command -v nvm &>/dev/null; then
    echo "Error: NVM is not available" >&2
    exit 1
fi

echo "Installing Node.js LTS..."

nvm install --lts >/dev/null

# Switch to LTS and set it as default
nvm use --lts >/dev/null
nvm alias default 'lts/*' >/dev/null

echo "Node.js LTS installed and activated."
