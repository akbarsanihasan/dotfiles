#!/usr/bin/env bash

source "./flatpak.sh"

if command -v flatpak &>/dev/null; then
    if ! flatpak --user --noninteractive --assumeyes install md.obsidian.Obsidian; then
        echo -e "Obsidian installation failed"
        exit 1
    fi
fi
