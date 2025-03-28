#!/usr/bin/env bash

if ! command -v flatpak &>/dev/null; then
    if command -v pacman &>/dev/null; then
        sudo pacman -Sy
        if ! sudo pacman -S flatpak --noconfirm; then
            echo -e "Flatpak installation failed"
            exit 1
        fi
    fi

    if command -v apt-get &>/dev/null; then
        sudo apt-get update -y
        if ! sudo apt-get install -y flatpak; then
            echo -e "Flatpak installation failed"
            exit 1
        fi
    fi

    flatpak override --user --allow=bluetooth

    flatpak override --user --device=dri
    flatpak override --user --device=input
    flatpak override --user --device=shm
    flatpak override --user --device=all

    flatpak override --user --socket=x11
    flatpak override --user --socket=wayland
    flatpak override --user --socket=pulseaudio
    flatpak override --user --socket=session-bus
    flatpak override --user --socket=system-bus
    flatpak override --user --socket=ssh-auth
    flatpak override --user --socket=inherit-wayland-socket

    flatpak override --user --filesystem=home
    flatpak override --user --filesystem=xdg-config/gtk-3.0:ro
    flatpak override --user --filesystem=xdg-config/gtk-4.0:ro
    flatpak override --user --filesystem=xdg-config/Kvantum:ro
    flatpak override --user --filesystem=xdg-data/themes:ro
    flatpak override --user --filesystem=xdg-data/fonts:ro

    flatpak override --user --env=QT_STYLE_OVERRIDE=kvantum
    flatpak override --user --env=QT_QPA_PLATFORM="wayland;xcb"
    flatpak override --user --env=ELECTRON_OZONE_PLATFORM_HINT=auto
    if gsettings get org.gnome.desktop.interface gtk-theme &>/dev/null; then
        flatpak override --user --env=GTK_THEME="$(gsettings get org.gnome.desktop.interface gtk-theme | sed "s/'//g")"
    fi

    flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install --user --noninteractive --assumeyes com.github.tchx84.Flatseal
fi
