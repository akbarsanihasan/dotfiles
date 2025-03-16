#!/usr/bin/env bash

if command -v pacman &>/dev/null; then
    sudo pacman -S flatpak
fi

if command -v apt-get &>/dev/null; then
    sudo apt-get flatpak
fi

flatpak --user --noninteractive install flatseal

flatpak --user override --filesystem=xdg-config/gtk-3.0:ro
flatpak --user override --filesystem=xdg-config/gtk-4.0:ro

flatpak --user override --env=QT_STYLE_OVERRIDE=kvantum
flatpak --user override --filesystem=xdg-config/Kvantum:ro
