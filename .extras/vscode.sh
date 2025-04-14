#!/usr/bin/env bash

if ! command -v flatpak &>/dev/null; then
    clear
    echo -e "Flatpak is not installed"
    exit 1
fi

if command -v flatpak &>/dev/null; then
    if ! flatpak --user --noninteractive --assumeyes install com.visualstudio.code; then
        echo -e "VSC*de installation failed"
        exit 1
    fi
fi
