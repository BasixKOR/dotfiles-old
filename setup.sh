#!/usr/bin/env bash

set -Eeuo pipefail
trap exit SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

PACKAGES="fish bat lsd starship"

if [ -f /etc/fedora-release ]; then
    sudo dnf install $PACKAGES -y
elif [ -f /etc/debian_version ]; then
    sudo apt install $PACKAGES -y
elif [ -f /msys.exe ]; then
    echo "Assuming packages are installed by Scoop."
    echo "Please set MSYS2_PATH_TYPE to inherit."
    pacman -S fish
else
    echo "Can't detect distro. Please install: $PACKAGES"
    read -n1 -r -p "Press any key after installation..."
fi

ln -s  $script_dir/.config ~/.config
ln -s  $script_dir/.gitconfig ~/.gitconfig
