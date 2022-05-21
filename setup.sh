#!/bin/bash

# with a fresh SD card, set up my raspberry pi with pi-hole and unbound

# packages
echo
echo "Update all the things!"
echo

sudo apt update && sudo apt upgrade -y
sudo apt install vim -y

# pi-hole
echo
echo "Installing pi-hole..."
echo

curl -sSL https://install.pi-hole.net | sudo bash

# unbound
echo
echo "Installing unbound..."
echo

sudo apt install unbound
wget https://www.internic.net/domain/named.root -qO- | sudo tee /var/lib/unbound/root.hints
sudo mv pi-hole.conf /etc/unbound/unbound.conf.d/pi-hole.conf

echo
echo "So far so good. Attempting to init unbound..."
echo

sudo service unbound restart
dig pi-hole.net @127.0.0.1 -p 5335

echo
echo "Finally, configure Pi-hole to use your recursive DNS server by specifying 127.0.0.1#5335 as the Custom DNS (IPv4)"
read -p "Press any key to continue..." -n1 -s