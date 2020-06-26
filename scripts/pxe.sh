#!/bin/bash

sudo apt install syslinux pxelinux -y
sudo cp /usr/lib/PXELINUX/pxelinux.0 /tftpboot
sudo cp /usr/lib/syslinux/modules/bios/{ldlinux.c32,libcom32.c32,libutil.c32,vesamenu.c32} /tftpboot

exit