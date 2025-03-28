#!/usr/bin/env bash

if command -v flatpak &>/dev/null; then
    if ! flatpak --user --noninteractive --assumeyes install org.chromium.Chromium; then
        echo -e "Chromium installation failed"
        exit 1
    fi
fi
