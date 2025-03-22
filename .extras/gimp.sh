#!/usr/bin/env bash

source "./flatpak.sh"

if command -v flatpak &>/dev/null; then
    if ! flatpak --user --noninteractive --assumeyes install org.gimp.GIMP; then
        echo -e "Gimp installation failed"
        exit 1
    fi
fi
