#!/usr/bin/env bash

if command -v flatpak &>/dev/null; then
    source "./flatpak.sh"
    flatpak --user --noninteractive --assumeyes install md.obsidian.Obsidian
fi
