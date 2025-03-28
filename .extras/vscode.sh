#!/usr/bin/env bash

source "./flatpak.sh"

if command -v flatpak &>/dev/null; then
    if ! flatpak --user --noninteractive --assumeyes install com.visualstudio.code; then
        echo -e "VSC*de installation failed"
        exit 1
    fi
fi
