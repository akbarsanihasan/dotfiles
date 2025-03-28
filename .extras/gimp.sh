#!/usr/bin/env bash

source "./flatpak.sh"

if command -v flatpak &>/dev/null; then
    if ! flatpak --user --noninteractive --assumeyes install org.gimp.GIMP; then
        echo -e "Gimp installation failed"
        exit 1
    fi

    curl -Lo photogimp.zip https://github.com/Diolinux/PhotoGIMP/releases/download/3.0/PhotoGIMP-linux.zip
    unzip -vo ./photogimp.zip -d $HOME
    rm -rf ./photogimp.zip
fi
