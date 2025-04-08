#!/usr/bin/env bash

clear

if ! command -v docker &>/dev/null; then
    source "./docker.sh"
fi

# if ! command -v podman &>/dev/null; then
#     source "./podman.sh"
# fi

if ! command -v distrobox &>/dev/null; then
    curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install |
        sh -s -- --prefix $HOME/.local
else
    echo -e "Distrobox already installed"
fi
