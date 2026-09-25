#!/bin/bash

[ $# -eq 0 ] && exit 1

source /etc/os-release

case "$ID" in
    ubuntu|debian)
        sudo apt install -y "$@" >/dev/null
        ;;

    centos|rhel|rocky|almalinux)
        if command -v dnf &>/dev/null; then
            sudo dnf install -y "$@" >/dev/null
        else
            sudo yum install -y "$@" >/dev/null
        fi
        ;;

    fedora)
        sudo dnf install -y "$@" >/dev/null
        ;;

    arch|manjaro)
        sudo pacman -S --noconfirm "$@" >/dev/null
        ;;

    opensuse*|sles)
        sudo zypper install -y "$@" >/dev/null
        ;;
    alpine)
        sudo apk add "$@" >/dev/null         
        ;;
    *)
        echo "Unsupported distribution: $ID" >&2
        exit 1
        ;;
esac
