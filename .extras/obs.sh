#!/usr/bin/env bash

if command -v flatpak &>/dev/null; then
    if ! flatpak --user --noninteractive --assumeyes install com.obsproject.Studio; then
        echo -e "Chromium installation failed"
        exit 1
    fi
fi
