#!/usr/bin/env bash

if command -v pacman &>/dev/null; then
    sudo pacman -Sy
    if ! sudo pacman -S --noconfirm docker iptables-nft docker-compose docker-buildx; then
        echo -e "Docker installation failed"
        exit 1
    fi
fi

if command -v apt-get &>/dev/null; then
    sudo apt-get update -y
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
        sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
    sudo apt-get update
    if ! sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin; then
        echo -e "Docker installation failed"
        exit 1
    fi
fi

getent group docker || sudo groupadd docker
sudo usermod -aG docker "$USER"
sudo systemctl enable docker --now

echo -e
echo "Installation might require reboot"
