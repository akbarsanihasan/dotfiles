#!/usr/bin/env bash

if ! command -v flatpak &>/dev/null; then
    source "./flatpak.sh"
fi

flatpak --user --noninteractive --assumeyes install md.obsidian.Obsidian
