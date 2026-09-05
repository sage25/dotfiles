#!/bin/bash

echo "Start downloading wget"

{
    if ! command -v wget &>/dev/null; then

        if [ "$(id -u)" -eq 0 ]; then
            SUDO=""
        else
            SUDO="sudo"
        fi

        if command -v apt-get &>/dev/null; then
            $SUDO apt-get update -qq
            $SUDO apt-get install -y -qq wget

        elif command -v dnf &>/dev/null; then
            $SUDO dnf install -y -q wget

        elif command -v yum &>/dev/null; then
            $SUDO yum install -y -q wget

        elif command -v pacman &>/dev/null; then
            $SUDO pacman -Sy --noconfirm wget

        elif command -v apk &>/dev/null; then
            $SUDO apk add --no-cache wget

        elif command -v zypper &>/dev/null; then
            $SUDO zypper --non-interactive install wget

        elif command -v xbps-install &>/dev/null; then
            $SUDO xbps-install -Sy wget

        else
            echo "No supported package manager"
            exit 1
        fi
    fi

} >/dev/null 2>&1


if command -v wget &>/dev/null; then
    echo "wget download completed"
else
    echo "wget install failed"
    exit 1
fi
