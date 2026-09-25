#!/bin/bash
set -e

NVM_DIR="$HOME/.nvm"
NVM_VERSION="v0.40.8"

# If Node.js >= 22 already exists, skip everything
if command -v node &>/dev/null; then
    NODE_MAJOR=$(node -p 'process.versions.node.split(".")[0]')
    if [ "$NODE_MAJOR" -ge 22 ]; then
        echo "Node.js $NODE_MAJOR already installed, skipping."
        exit 0
    fi
fi

echo "Installing NVM..."

bash $LINUXDIR/PM/PM.sh wget

# Install NVM only if it does not already exist
if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    wget -qO- \
        "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" |
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
