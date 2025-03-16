#!/usr/bin/env bash

if ! command -v flatpak &>/dev/null; then
    if command -v pacman &>/dev/null; then
        sudo pacman -Sy
        sudo pacman -S flatpak --noconfirm
    fi

    if command -v apt-get &>/dev/null; then
        sudo apt-get update -y
        sudo apt-get install -y flatpak
    fi
fi

flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak override --user --filesystem=xdg-config/gtk-3.0:ro
flatpak override --user --filesystem=xdg-config/gtk-4.0:ro

flatpak override --user --env=QT_STYLE_OVERRIDE=kvantum
flatpak override --user --filesystem=xdg-config/Kvantum:ro

flatpak install --user --noninteractive --assumeyes com.github.tchx84.Flatseal

sudo reboot
