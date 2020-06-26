#!/bin/bash

# DHCP requirements
sudo apt install isc-dhcp-server -y
sudo sed -i 's/#DHCPDv4_CONF/DHCPDv4_CONF/g' /etc/default/isc-dhcp-server
sudo sed -i 's/#DHCPDv4_PID/DHCPDv4_PID/g' /etc/default/isc-dhcp-server
# Get the NIC's name internet must be present
main_interface=$(ip route get 1.1.1.1 | awk -- '{printf $5}')
sudo sed -i 's/INTERFACESv4=""/INTERFACESv4='$main_interface'/g' /etc/default/isc-dhcp-server
sudo sed -i 's/INTERFACESv6=""/#INTERFACESv6=""/g' /etc/default/isc-dhcp-server
sudo mv /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf-original

exit