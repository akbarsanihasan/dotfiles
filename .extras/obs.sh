#!/usr/bin/env bash

if ! command -v flatpak &>/dev/null; then
    clear
    echo -e "Flatpak is not installed"
    exit 1
fi

if ! flatpak --user --noninteractive --assumeyes install com.obsproject.Studio; then
    echo -e "Chromium installation failed"
    exit 1
fi
