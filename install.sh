#!/bin/bash

sudo apt update;sudo apt dist-upgrade -y

CWD="$(pwd)"

# Install DHCP-Server
sudo bash ${CWD}/scripts/dhcp.sh
sudo cp ${CWD}/customize/dhcp/* /etc/dhcp
sudo systemctl isc-dhcp-server restart

# Install TFTP Server
sudo bash ${CWD}/scripts/tftp.sh
sudo rm /etc/default/tftpd-hpa
sudo cp ${CWD}/customize/tftp/tftpd-hpa /etc/default
sudo systemctl restart tftpd-hpa

# Install PXE
sudo bash ${CWD}/scripts/pxe.sh
sudo mkdir -p /tftpboot/pxelinux.cfg
sudo cp ${CWD}/customize/pxelinux.cfg/default /tftpboot/pxelinux.cfg


# Install iPXE
sudo bash ${CWD}/scripts/ipxe.sh
cp ${CWD}/customize/iPXE/* /tmp/ipxe/src
cd /tmp/ipxe/src
# Build BIOS x64 
sudo make bin/undionly.kpxe EMBED=ipxescript
sudo make bin/ipxe.pxe EMBED=ipxescript
# Build BIOS ipxelinux.0
sudo make bin/undionly.kkkpxe EMBED=ipxelinux.ipxe,/usr/lib/PXELINUX/pxelinux.0
# Build UEFI x64
sudo make bin-x86_64-efi/ipxe.efi EMBED=ipxescript 
sudo make bin-x86_64-efi/snponly.efi EMBED=ipxescript 
# Move the Files over to tftpboot
sudo install -v -m 0644 -g tftp -o tftp bin/undionly.kpxe /tftpboot/undionly.kpxe
sudo install -v -m 0644 -g tftp -o tftp bin/ipxe.pxe /tftpboot/ipxe.pxe
sudo install -v -m 0644 -g tftp -o tftp bin/undionly.kkkpxe /tftpboot/ipxelinux.0
sudo install -v -m 0644 -g tftp -o tftp bin-x86_64-efi/ipxe.efi /tftpboot/ipxe.efi
sudo install -v -m 0644 -g tftp -o tftp bin-x86_64-efi/snponly.efi /tftpboot/snponly.efi

# Symlink undionly.kpxe undionly.0 
#sudo ln -s /tftpboot/undionly.kpxe /tftpboot/undionly.0

# Restart the Services
sudo systemctl restart isc-dhcp-server
sudo systemctl restart tftpd-hpa