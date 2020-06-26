#!/bin/bash

sudo apt install git build-essential liblzma-dev zlib1g-dev binutils-dev genisoimage uuid-dev -y
rm -rf /tmp/ipxe
mkdir -p /tmp/ipxe
cd /tmp/ipxe
git clone git://git.ipxe.org/ipxe.git ipxe
cd /tmp/ipxe/src
make && make bin/NIC

exit
