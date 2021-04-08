#!/bin/bash


# Disable DHCP-Server
sudo systemctl disable --now isc-dhcp-server

# Disable TFTP Server
sudo systemctl disable --now tftpd-hpa

# Remove DHCP and TFTP and empty the tftpboot folder
sudo apt remove isc-dhcp-server tftpd-hpa -y && sudo apt autoremove -y
sudo rm -rf /tftpboot/*

