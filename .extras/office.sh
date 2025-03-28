#!/usr/bin/env bash

source "./flatpak.sh"

if command -v flatpak &>/dev/null; then
    if ! flatpak install --user --noninteractive --assumeyes org.onlyoffice.desktopeditors; then
        echo -e "Office installation failed"
        exit 1
    fi
fi
