#!/bin/bash

# Установка WireGuard
sudo apt update
sudo apt install -y wireguard

# Генерация ключей
umask 0777
wg genkey | tee privatekey | wg pubkey > publickey

# Конфигурация WireGuard
echo "
[Interface]
PrivateKey = $(cat privatekey)
Address = 10.0.0.1/24
ListenPort = 51820

[Peer]
PublicKey = $1
AllowedIPs = 10.0.0.2/32
" | sudo tee /etc/wireguard/wg0.conf

# Запуск WireGuard
sudo wg-quick up wg0
sudo systemctl enable wg-quick@wg0

