#!/usr/bin/env bash

set -Eeuo pipefail
trap exit SIGINT SIGTERM ERR EXIT

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

PACKAGES="fish bat"

if [ -f /etc/fedora-release ]; then
    sudo dnf install lsd starship $PACKAGES -y
elif [ -f /etc/debian_version ]; then
    sudo apt install $PACKAGES -y
    curl -fsSL https://starship.rs/install.sh | bash
    curl -OLC https://github.com/Peltoche/lsd/releases/download/0.19.0/lsd_0.19.0_amd64.deb
    dpkg -i lsd_0.19.0_amd64.deb
elif [ -f /msys.exe ]; then
    echo "Assuming packages are installed by Scoop."
    echo "Please set MSYS2_PATH_TYPE to inherit."
    pacman --noconfirm -S fish
else
    echo "Can't detect distro. Please install: $PACKAGES lsd starship"
    read -n1 -r -p "Press any key after installation..."
fi

ln -s  $script_dir/.config ~/.config
ln -s  $script_dir/.gitconfig ~/.gitconfig
