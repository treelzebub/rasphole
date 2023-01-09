#!/bin/bash

# with a fresh SD card, set up my raspberry pi with pi-hole and unbound

# update
echo
echo "Update all the things!"
echo
sudo apt update && sudo apt upgrade -y

# pi-hole
echo
echo "Installing pi-hole..."
echo
curl -sSL https://install.pi-hole.net | sudo bash

# unbound
echo
echo "Installing unbound..."
echo
sudo apt install unbound -y
wget https://www.internic.net/domain/named.root -qO- | sudo tee /var/lib/unbound/root.hints
sudo cp pi-hole.conf /etc/unbound/unbound.conf.d/pi-hole.conf
echo
echo "Attempting to init unbound..."
echo
sudo service unbound restart

# verify
dig pi-hole.net @127.0.0.1 -p 5335
echo
echo "Finally, configure Pi-hole to use your recursive DNS server by specifying 127.0.0.1#5335 as the Custom DNS (IPv4)"
echo
