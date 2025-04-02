#!/usr/bin/env bash

if ! command -v flatpak &>/dev/null; then
    clear
    echo -e "Flatpak is not installed"
    exit 1
fi

if command -v flatpak &>/dev/null; then
    if ! flatpak install --user --noninteractive --assumeyes org.onlyoffice.desktopeditors; then
        echo -e "Office installation failed"
        exit 1
    fi
fi
